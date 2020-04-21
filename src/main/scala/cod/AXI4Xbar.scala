

package cod

import chisel3._
import chisel3.util.{Arbiter, DecoupledIO, log2Ceil}
import com.typesafe.scalalogging.Logger

/**
 * Simple AXI4 Crossbar.
 * @param m Number of masters.
 * @param addressSpace Destination address spaces.
 *
 * TODO Auto-extensive id bits
 * TODO Id bits overflow checking
 * TODO Test multiple master hit cases
 * TODO Test async
 * TODO Inflight Control
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
  val awDest = RegInit(VecInit(Seq.fill(m) { 0.U(log2Ceil(io.out.size)) }))
  val awDestValid = RegInit(VecInit(Seq.fill(m) { RegInit(false.B) }))

  // A Common Logic
  private def addressPortBinding(ins: Seq[DecoupledIO[AXI4BundleA]], outs: Seq[DecoupledIO[AXI4BundleA]],
                                 arbs: Seq[Arbiter[AXI4BundleA]], cmd: String): Seq[UInt] = {
    val chosen = addressSpace.zipWithIndex map { case ((start, end), i) =>
      val arb = arbs(i)
      val out = outs(i)
      // Bind each master with arbiter's input, masked by address range.
      (arb.io.in zip ins).zipWithIndex foreach { case ((arb_in, in), i) =>
        val addr_hit = start.U <= in.bits.addr && in.bits.addr < end.U
        arb_in <> in
        arb_in.valid := in.valid && addr_hit
        in.ready := arb_in.ready && addr_hit  // Arbiter will show ready to invalid producer!
      }
      out <> arb.io.out
      out.bits.id := (arb.io.out.bits.id << inIdBits).asUInt | arb.io.chosen
      when (out.fire()) {
        emulog(s"in[%d] $cmd routed to out[%d](%x,%x), id %x->%x",
          arb.io.chosen, i.U, start.U, end.U, arb.io.out.bits.id, out.bits.id)
      }

      arb.io.chosen
    }

    for ((in, i) <- ins.zipWithIndex) {
      in.ready := chosen.map(_ === i.U).reduce(_||_)
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
  io.in.map(_.w).zipWithIndex foreach { case (w, i) =>
    val dest = awDest(i)
    val destValid = awDestValid(i)
    io.out(dest).w <> w
    emulog { p => when (w.fire()) {
      p.emulog("w out port %d fired from in port %d", dest, i.U)
    }}
    when (w.fire() && w.bits.last) {
      destValid := false.B
      emulog("w in port %d last finished\n", i.U)
    }
    assert(!w.valid || destValid, s"in port $i w.ch valid with no aw fired")
  }

  // Route B
  io.in.map(_.b) foreach (b => b <> 0.U.asTypeOf(b))  // Tell FIRRTL we have initialized in all addr cases.
  io.out.map(_.b).zipWithIndex foreach { case (b, i) =>
    val id = b.bits.id(inIdBits - 1, 0)
    val in_b = io.in(id).b
    in_b <> b
    in_b.bits.id := b.bits.id >> inIdBits
    when (in_b.fire()) {
      emulog("out[%d] b routed to %d", i.U, id)
    }
  }

  // Route AR
  addressPortBinding(io.in.map(_.ar), io.out.map(_.ar), outARArbs, "ar")

  // Route R
  io.in.map(_.r) foreach (r => r <> 0.U.asTypeOf(r))  // Tell FIRRTL we have initialized in all addr cases.
  io.out.map(_.r).zipWithIndex foreach { case (r, i) =>
    val id = r.bits.id(inIdBits - 1, 0)
    val in_r = io.in(id).r
    in_r <> r
    in_r.bits.id := r.bits.id >> inIdBits
    when(in_r.fire()) {
      emulog("r out port %d route to in port %d", i.U, id)
    }
  }
}