package cod

import chisel3._
import chisel3.util._
import chisel3.iotesters._
import org.scalatest.{Matchers, FlatSpec}


class AXI4Master(addrs: Seq[Long], name: String, id: Int) extends Module with HasEmuLog {
  val io = IO(new AXI4)

  override def emulog_theme = "master_" + name

  val s_idle :: s_aw :: s_w :: s_bresp :: s_ar :: s_r :: s_end :: Nil = Enum(7)
  val state = RegInit(s_idle)

  io.ar.valid := false.B
  io.ar.bits := 0.U.asTypeOf(io.ar.bits)
  io.r.ready := false.B

  io.aw.valid := false.B
  io.aw.bits := 0.U.asTypeOf(io.aw.bits)
  io.w.valid := false.B
  io.w.bits := 0.U.asTypeOf(io.w.bits)
  io.b.ready := false.B

  val (w_cnt, w_last) = Counter(state === s_w && io.w.fire(), 4)

  when (state =/= s_idle) {
    emulog("state = %d", state)
  }

  switch (state) {
    is (s_idle) {
      state := s_ar
    }

    is (s_aw) {
      io.aw.valid := true.B
      io.aw.bits.addr := addrs(0).U
      io.aw.bits.id := id.U

      when (io.aw.fire()) {
        emulog("aw fired")
        state := s_w
      }
    }

    is (s_w) {
      io.w.valid := true.B
      io.w.bits.last := w_last
      when (io.w.fire()) {
        emulog("w fire cnt %d", w_cnt)
      }
      when (io.w.fire() && w_last) {
        emulog("w last")
        state := s_bresp
      }
    }

    is (s_bresp) {
      io.b.ready := true.B
      when (io.b.fire()) {
        emulog("bresp fired, id %x", io.b.bits.id)
        state := s_end
      }
    }

    is (s_ar) {
      io.ar.valid := true.B
      io.ar.bits.addr := addrs(0).U
      io.ar.bits.id := id.U
      when (io.ar.fire()) {
        emulog("ar fired")
        state := s_r
      }
    }

    is (s_r) {
      io.r.ready := true.B
      when (io.r.fire()) {
        emulog("r fired, id %x", io.r.bits.id)
        when (io.r.bits.last) {
          emulog("r last")
          state := s_end
        }
      }
    }
  }
}


class AXI4Client(name: String) extends Module with HasEmuLog {
  val io = IO(Flipped(new AXI4))

  override def emulog_theme = "client_" + name

  val s_idle :: s_aw :: s_w :: s_bresp :: s_ar :: s_r :: s_end :: Nil = Enum(7)
  val state = RegInit(s_idle)
  val id = RegInit(0.U(AXI4Parameters.idBits.W))

  io.r.bits := 0.U.asTypeOf(io.r.bits)
  io.b.bits := 0.U.asTypeOf(io.b.bits)

  io.ar.ready := false.B
  io.r.valid := false.B

  io.aw.ready := false.B
  io.w.ready := false.B
  io.b.valid := false.B

  when (state =/= s_idle) {
    emulog("state = %d", state)
  }

  val (r_cnt, r_last) = Counter(state === s_r && io.r.fire(), 4)

  switch (state) {
    is (s_idle) {
      state := s_ar
    }

    is (s_aw) {
      io.aw.ready := true.B
      when (io.aw.fire()) {
        emulog("aw fired addr %x id %x", io.aw.bits.addr, io.aw.bits.id)
        id := io.aw.bits.id
        state := s_w
      }
    }

    is (s_w) {
      io.w.ready := true.B
      when (io.w.fire()) {
        emulog("w fired")
        when (io.w.bits.last) {
          emulog("w last")
          state := s_bresp
        }
      }
    }

    is (s_bresp) {
      io.b.valid := true.B
      io.b.bits.id := id
      when (io.b.fire()) {
        emulog("bresp fired")
        state := s_end
      }
    }

    is (s_ar) {
      io.ar.ready := true.B
      when (io.ar.fire()) {
        emulog("ar fired, addr %x, id %x", io.ar.bits.addr, io.ar.bits.id)
        id := io.ar.bits.id
        state := s_r
      }
    }

    is (s_r) {
      io.r.valid := true.B
      io.r.bits.id := id
      io.r.bits.last := r_last
      when (io.r.fire()) {
        emulog("r fired %d", r_cnt)
        when (r_last) {
          emulog("r last")
          state := s_end
        }
      }
    }
  }
}


class Testharness extends Module {
  val io = IO(new Bundle {})
  val m1 = Module(new AXI4Master(List(0x100), "A", 33))
  val m2 = Module(new AXI4Master(List(0x400), "B", 44))
  val c1 = Module(new AXI4Client("C"))
  val c2 = Module(new AXI4Client("D"))
  val xbr = Module(new AXI4Xbar(2, List((0, 0x200), (0x300, 0x500))))
  xbr.io.in(1) <> m1.io
  xbr.io.in(0) <> m2.io
  c1.io <> xbr.io.out(0)
  c2.io <> xbr.io.out(1)
}

class AXI4XbarTester(c: Testharness) extends PeekPokeTester(c) {
  for (i <- 0 to 100) {
    println("==================================")
    step(1)
  }
}

object Test extends App {
  chisel3.iotesters.Driver(() => new Testharness) { c =>
    new AXI4XbarTester(c)
  }
}