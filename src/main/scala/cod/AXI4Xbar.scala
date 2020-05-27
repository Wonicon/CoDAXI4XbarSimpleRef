package cod

import chisel3._
import chisel3.util._

/**
 * Simple AXI4 Crossbar.
 * @param m Number of masters.
 * @param addressSpace Destination address spaces.
 */
class AXI4Xbar(m: Int, addressSpace: List[(Long, Long)]) extends Module with HasEmuLog {
  val io = IO(new Bundle {
    val in = Vec(m, Flipped(new AXI4))
    val out = Vec(addressSpace.size, new AXI4)
  })

  for ((in, i) <- io.in.zipWithIndex) {
    when (in.ar.valid) { emulog("in[%d] ar valid addr %x id %x", i.U, in.ar.bits.addr, in.ar.bits.id)}
    when (in.aw.valid) { emulog("in[%d] aw valid addr %x id %x", i.U, in.aw.bits.addr, in.aw.bits.id)}
    when (in.w.valid) { emulog("in[%d] w valid last %b", i.U, in.w.bits.last)}
  }

  for ((out, i) <- io.out.zipWithIndex) {
    when (out.r.valid) { emulog("out[%d] r valid id %x last %b", i.U, out.r.bits.id, out.r.bits.last)}
    when (out.b.valid) { emulog("out[%d] b valid id %x", i.U, out.b.bits.id) }
  }

  // Config Logging
  override def emulog_theme = "axi4xbar"

  val inIdBits = log2Ceil(io.in.size)
  println(s"Xbar has ${io.in.size} masters and ${io.out.size} clients, additional id bits usage is $inIdBits")

  val outARArbs = Seq.fill(addressSpace.size) { Module(new Arbiter(new AXI4BundleA(AXI4Parameters.dataBits), m)) }
  val outAWArbs = Seq.fill(addressSpace.size) { Module(new Arbiter(new AXI4BundleA(AXI4Parameters.dataBits), m)) }
  val outWBurst = RegInit(VecInit(Seq.fill(addressSpace.size) { false.B }))
  val inRBurst = RegInit(VecInit(Seq.fill(addressSpace.size) { false.B }))

  val awDest = RegInit(VecInit(Seq.fill(m) { 0.U(log2Ceil(io.out.size)) }))
  val awDestValid = RegInit(VecInit(Seq.fill(m) { RegInit(false.B) }))

  // A Common Logic
  private def addressPortBinding(ins: Seq[DecoupledIO[AXI4BundleA]], outs: Seq[DecoupledIO[AXI4BundleA]],
                                 arbs: Seq[Arbiter[AXI4BundleA]], cmd: String): Seq[UInt] = {
    val outstanding_guard = if (cmd == "aw") outWBurst else inRBurst
    val ins_hits = ins.map { in =>
      addressSpace.map { case (start, end) =>
        start.U <= in.bits.addr && in.bits.addr < end.U
      }
    }
    val chosen = addressSpace.zipWithIndex map { case ((start, end), out_idx) =>
      val arb = arbs(out_idx)
      val out = outs(out_idx)
      val inflight = outstanding_guard(out_idx)
      // Bind each master with arbiter's input, masked by address range.
      (arb.io.in zip ins).zipWithIndex foreach { case ((arb_in, in), in_idx) =>
        val addr_hit = ins_hits(in_idx)(out_idx)
        arb_in <> in
        if (cmd == "aw") {
          arb_in.valid := in.valid && addr_hit && !inflight
        }
        else {
          arb_in.valid := in.valid && addr_hit && !inflight && !outAWArbs(out_idx).io.out.valid
        }
      }
      out <> arb.io.out
      out.bits.id := (arb.io.out.bits.id << inIdBits).asUInt | arb.io.chosen
      when (out.fire()) {
        emulog(s"in[%d] $cmd routed to out[%d](%x,%x), id %x->%x",
          arb.io.chosen, out_idx.U, start.U, end.U, arb.io.out.bits.id, out.bits.id)
        inflight := true.B
      }

      arb.io.chosen
    }

    // The requester can see the destination ready when it is chosen.
    for ((in, i) <- ins.zipWithIndex) {
      val hits = ins_hits(i)
      def rw_priority(o: Int) = if (cmd == "aw") true.B else !outAWArbs(o).io.out.valid
      in.ready := (chosen zip hits).zipWithIndex.map{ case ((choice, hit), o) =>
        rw_priority(o) && arbs(o).io.in(i).ready && choice === i.U && hit && !outstanding_guard(o)
      }.reduce(_||_)
    }

    chosen
  }

  // Route AW, prepare for W
  val awChosens = addressPortBinding(io.in.map(_.aw), io.out.map(_.aw), outAWArbs, "aw")

  // Record where AW has gone to route W
  awChosens.zipWithIndex foreach { case (awChosen, i) =>
    // AW routed
    when (outAWArbs(i).io.out.fire()) {
      emulog("in(%d) aw destination is %d", awChosen, i.U)
      awDest(awChosen) := i.U
      awDestValid(awChosen) := true.B
    }
  }

  // Route W
  io.out.map(_.w).foreach(w => w <> 0.U.asTypeOf(w)) // Tell FIRRTL we have initialized in all addr cases.
  for (i <- 0 until io.in.size) {
    val iw = io.in(i).w
    val iaw = io.in(i).aw
    iw.ready := false.B

    val oDestImm = MuxLookup(i.U, 0.U, outAWArbs.zipWithIndex.map{case(arb,j)=>(arb.io.chosen, j.U)})
    val oDest = Mux(iaw.fire(), oDestImm, awDest(i))
    val iwDestValid = awDestValid(i)
    when (iaw.fire() || iwDestValid) {
      io.out(oDest).w <> iw
    }

    emulog(iw.fire(), "w out port %d fired from in port %d", oDest, i.U)

    when (iw.fire() && iw.bits.last) {
      iwDestValid := false.B
      emulog("w in port %d last finished", i.U)
    }
  }

  // Route B
  io.in.map(_.b) foreach (b => b <> 0.U.asTypeOf(b))  // Tell FIRRTL we have initialized in all addr cases.
  io.out.map(_.b).zipWithIndex foreach { case (b, i) =>
    val id = b.bits.id(inIdBits - 1, 0)
    val in_b = io.in(id).b
    b.ready := false.B  // init
    when (b.valid) {
      in_b <> b
      in_b.bits.id := b.bits.id >> inIdBits
    }
    when (in_b.fire()) {
      emulog("out[%d] b routed to %d", i.U, id)
      outWBurst(i) := false.B
    }
  }

  // Route AR
  addressPortBinding(io.in.map(_.ar), io.out.map(_.ar), outARArbs, "ar")

  // Route R
  io.in.map(_.r) foreach (r => r <> 0.U.asTypeOf(r))  // Tell FIRRTL we have initialized in all addr cases.
  io.out.map(_.r).zipWithIndex foreach { case (r, i) =>
    val id = r.bits.id(inIdBits - 1, 0)
    val in_r = io.in(id).r
    r.ready := false.B // init
    when (r.valid) {
      in_r <> r
    }
    in_r.bits.id := r.bits.id >> inIdBits
    when (in_r.fire()) {
      emulog("r out port %d route to in port %d", i.U, id)
    }
    when (r.fire() && r.bits.last) {
      inRBurst(i) := false.B
    }
  }
}