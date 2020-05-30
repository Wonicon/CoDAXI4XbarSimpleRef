module Arbiter(
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [31:0] io_in_0_bits_addr,
  input  [2:0]  io_in_0_bits_prot,
  input  [31:0] io_in_0_bits_id,
  input         io_in_0_bits_user,
  input  [7:0]  io_in_0_bits_len,
  input  [2:0]  io_in_0_bits_size,
  input  [1:0]  io_in_0_bits_burst,
  input         io_in_0_bits_lock,
  input  [3:0]  io_in_0_bits_cache,
  input  [3:0]  io_in_0_bits_qos,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [31:0] io_in_1_bits_addr,
  input  [2:0]  io_in_1_bits_prot,
  input  [31:0] io_in_1_bits_id,
  input         io_in_1_bits_user,
  input  [7:0]  io_in_1_bits_len,
  input  [2:0]  io_in_1_bits_size,
  input  [1:0]  io_in_1_bits_burst,
  input         io_in_1_bits_lock,
  input  [3:0]  io_in_1_bits_cache,
  input  [3:0]  io_in_1_bits_qos,
  input         io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_bits_addr,
  output [2:0]  io_out_bits_prot,
  output [31:0] io_out_bits_id,
  output        io_out_bits_user,
  output [7:0]  io_out_bits_len,
  output [2:0]  io_out_bits_size,
  output [1:0]  io_out_bits_burst,
  output        io_out_bits_lock,
  output [3:0]  io_out_bits_cache,
  output [3:0]  io_out_bits_qos,
  output        io_chosen
);
  wire  _T; // @[Arbiter.scala 31:78]
  wire  _T_3; // @[Arbiter.scala 135:19]
  assign _T = ~io_in_0_valid; // @[Arbiter.scala 31:78]
  assign _T_3 = ~_T; // @[Arbiter.scala 135:19]
  assign io_in_0_ready = io_out_ready; // @[Arbiter.scala 134:14]
  assign io_in_1_ready = _T & io_out_ready; // @[Arbiter.scala 134:14]
  assign io_out_valid = _T_3 | io_in_1_valid; // @[Arbiter.scala 135:16]
  assign io_out_bits_addr = io_in_0_valid ? io_in_0_bits_addr : io_in_1_bits_addr; // @[Arbiter.scala 124:15 Arbiter.scala 128:19]
  assign io_out_bits_prot = io_in_0_valid ? io_in_0_bits_prot : io_in_1_bits_prot; // @[Arbiter.scala 124:15 Arbiter.scala 128:19]
  assign io_out_bits_id = io_in_0_valid ? io_in_0_bits_id : io_in_1_bits_id; // @[Arbiter.scala 124:15 Arbiter.scala 128:19]
  assign io_out_bits_user = io_in_0_valid ? io_in_0_bits_user : io_in_1_bits_user; // @[Arbiter.scala 124:15 Arbiter.scala 128:19]
  assign io_out_bits_len = io_in_0_valid ? io_in_0_bits_len : io_in_1_bits_len; // @[Arbiter.scala 124:15 Arbiter.scala 128:19]
  assign io_out_bits_size = io_in_0_valid ? io_in_0_bits_size : io_in_1_bits_size; // @[Arbiter.scala 124:15 Arbiter.scala 128:19]
  assign io_out_bits_burst = io_in_0_valid ? io_in_0_bits_burst : io_in_1_bits_burst; // @[Arbiter.scala 124:15 Arbiter.scala 128:19]
  assign io_out_bits_lock = io_in_0_valid ? io_in_0_bits_lock : io_in_1_bits_lock; // @[Arbiter.scala 124:15 Arbiter.scala 128:19]
  assign io_out_bits_cache = io_in_0_valid ? io_in_0_bits_cache : io_in_1_bits_cache; // @[Arbiter.scala 124:15 Arbiter.scala 128:19]
  assign io_out_bits_qos = io_in_0_valid ? io_in_0_bits_qos : io_in_1_bits_qos; // @[Arbiter.scala 124:15 Arbiter.scala 128:19]
  assign io_chosen = io_in_0_valid ? 1'h0 : 1'h1; // @[Arbiter.scala 123:13 Arbiter.scala 127:17]
endmodule
module AXI4Xbar(
  input         clock,
  input         reset,
  output        io_in_0_aw_ready,
  input         io_in_0_aw_valid,
  input  [31:0] io_in_0_aw_bits_addr,
  input  [2:0]  io_in_0_aw_bits_prot,
  input  [9:0]  io_in_0_aw_bits_id,
  input         io_in_0_aw_bits_user,
  input  [7:0]  io_in_0_aw_bits_len,
  input  [2:0]  io_in_0_aw_bits_size,
  input  [1:0]  io_in_0_aw_bits_burst,
  input         io_in_0_aw_bits_lock,
  input  [3:0]  io_in_0_aw_bits_cache,
  input  [3:0]  io_in_0_aw_bits_qos,
  output        io_in_0_w_ready,
  input         io_in_0_w_valid,
  input  [31:0] io_in_0_w_bits_data,
  input  [3:0]  io_in_0_w_bits_strb,
  input         io_in_0_w_bits_last,
  input         io_in_0_b_ready,
  output        io_in_0_b_valid,
  output [1:0]  io_in_0_b_bits_resp,
  output [9:0]  io_in_0_b_bits_id,
  output        io_in_0_b_bits_user,
  output        io_in_0_ar_ready,
  input         io_in_0_ar_valid,
  input  [31:0] io_in_0_ar_bits_addr,
  input  [2:0]  io_in_0_ar_bits_prot,
  input  [9:0]  io_in_0_ar_bits_id,
  input         io_in_0_ar_bits_user,
  input  [7:0]  io_in_0_ar_bits_len,
  input  [2:0]  io_in_0_ar_bits_size,
  input  [1:0]  io_in_0_ar_bits_burst,
  input         io_in_0_ar_bits_lock,
  input  [3:0]  io_in_0_ar_bits_cache,
  input  [3:0]  io_in_0_ar_bits_qos,
  input         io_in_0_r_ready,
  output        io_in_0_r_valid,
  output [1:0]  io_in_0_r_bits_resp,
  output [31:0] io_in_0_r_bits_data,
  output        io_in_0_r_bits_last,
  output [9:0]  io_in_0_r_bits_id,
  output        io_in_0_r_bits_user,
  output        io_in_1_aw_ready,
  input         io_in_1_aw_valid,
  input  [31:0] io_in_1_aw_bits_addr,
  input  [2:0]  io_in_1_aw_bits_prot,
  input  [9:0]  io_in_1_aw_bits_id,
  input         io_in_1_aw_bits_user,
  input  [7:0]  io_in_1_aw_bits_len,
  input  [2:0]  io_in_1_aw_bits_size,
  input  [1:0]  io_in_1_aw_bits_burst,
  input         io_in_1_aw_bits_lock,
  input  [3:0]  io_in_1_aw_bits_cache,
  input  [3:0]  io_in_1_aw_bits_qos,
  output        io_in_1_w_ready,
  input         io_in_1_w_valid,
  input  [31:0] io_in_1_w_bits_data,
  input  [3:0]  io_in_1_w_bits_strb,
  input         io_in_1_w_bits_last,
  input         io_in_1_b_ready,
  output        io_in_1_b_valid,
  output [1:0]  io_in_1_b_bits_resp,
  output [9:0]  io_in_1_b_bits_id,
  output        io_in_1_b_bits_user,
  output        io_in_1_ar_ready,
  input         io_in_1_ar_valid,
  input  [31:0] io_in_1_ar_bits_addr,
  input  [2:0]  io_in_1_ar_bits_prot,
  input  [9:0]  io_in_1_ar_bits_id,
  input         io_in_1_ar_bits_user,
  input  [7:0]  io_in_1_ar_bits_len,
  input  [2:0]  io_in_1_ar_bits_size,
  input  [1:0]  io_in_1_ar_bits_burst,
  input         io_in_1_ar_bits_lock,
  input  [3:0]  io_in_1_ar_bits_cache,
  input  [3:0]  io_in_1_ar_bits_qos,
  input         io_in_1_r_ready,
  output        io_in_1_r_valid,
  output [1:0]  io_in_1_r_bits_resp,
  output [31:0] io_in_1_r_bits_data,
  output        io_in_1_r_bits_last,
  output [9:0]  io_in_1_r_bits_id,
  output        io_in_1_r_bits_user,
  input         io_out_0_aw_ready,
  output        io_out_0_aw_valid,
  output [31:0] io_out_0_aw_bits_addr,
  output [2:0]  io_out_0_aw_bits_prot,
  output [9:0]  io_out_0_aw_bits_id,
  output        io_out_0_aw_bits_user,
  output [7:0]  io_out_0_aw_bits_len,
  output [2:0]  io_out_0_aw_bits_size,
  output [1:0]  io_out_0_aw_bits_burst,
  output        io_out_0_aw_bits_lock,
  output [3:0]  io_out_0_aw_bits_cache,
  output [3:0]  io_out_0_aw_bits_qos,
  input         io_out_0_w_ready,
  output        io_out_0_w_valid,
  output [31:0] io_out_0_w_bits_data,
  output [3:0]  io_out_0_w_bits_strb,
  output        io_out_0_w_bits_last,
  output        io_out_0_b_ready,
  input         io_out_0_b_valid,
  input  [1:0]  io_out_0_b_bits_resp,
  input  [9:0]  io_out_0_b_bits_id,
  input         io_out_0_b_bits_user,
  input         io_out_0_ar_ready,
  output        io_out_0_ar_valid,
  output [31:0] io_out_0_ar_bits_addr,
  output [2:0]  io_out_0_ar_bits_prot,
  output [9:0]  io_out_0_ar_bits_id,
  output        io_out_0_ar_bits_user,
  output [7:0]  io_out_0_ar_bits_len,
  output [2:0]  io_out_0_ar_bits_size,
  output [1:0]  io_out_0_ar_bits_burst,
  output        io_out_0_ar_bits_lock,
  output [3:0]  io_out_0_ar_bits_cache,
  output [3:0]  io_out_0_ar_bits_qos,
  output        io_out_0_r_ready,
  input         io_out_0_r_valid,
  input  [1:0]  io_out_0_r_bits_resp,
  input  [31:0] io_out_0_r_bits_data,
  input         io_out_0_r_bits_last,
  input  [9:0]  io_out_0_r_bits_id,
  input         io_out_0_r_bits_user
);
  wire  outARArbs_0_io_in_0_ready; // @[AXI4Xbar.scala 34:55]
  wire  outARArbs_0_io_in_0_valid; // @[AXI4Xbar.scala 34:55]
  wire [31:0] outARArbs_0_io_in_0_bits_addr; // @[AXI4Xbar.scala 34:55]
  wire [2:0] outARArbs_0_io_in_0_bits_prot; // @[AXI4Xbar.scala 34:55]
  wire [31:0] outARArbs_0_io_in_0_bits_id; // @[AXI4Xbar.scala 34:55]
  wire  outARArbs_0_io_in_0_bits_user; // @[AXI4Xbar.scala 34:55]
  wire [7:0] outARArbs_0_io_in_0_bits_len; // @[AXI4Xbar.scala 34:55]
  wire [2:0] outARArbs_0_io_in_0_bits_size; // @[AXI4Xbar.scala 34:55]
  wire [1:0] outARArbs_0_io_in_0_bits_burst; // @[AXI4Xbar.scala 34:55]
  wire  outARArbs_0_io_in_0_bits_lock; // @[AXI4Xbar.scala 34:55]
  wire [3:0] outARArbs_0_io_in_0_bits_cache; // @[AXI4Xbar.scala 34:55]
  wire [3:0] outARArbs_0_io_in_0_bits_qos; // @[AXI4Xbar.scala 34:55]
  wire  outARArbs_0_io_in_1_ready; // @[AXI4Xbar.scala 34:55]
  wire  outARArbs_0_io_in_1_valid; // @[AXI4Xbar.scala 34:55]
  wire [31:0] outARArbs_0_io_in_1_bits_addr; // @[AXI4Xbar.scala 34:55]
  wire [2:0] outARArbs_0_io_in_1_bits_prot; // @[AXI4Xbar.scala 34:55]
  wire [31:0] outARArbs_0_io_in_1_bits_id; // @[AXI4Xbar.scala 34:55]
  wire  outARArbs_0_io_in_1_bits_user; // @[AXI4Xbar.scala 34:55]
  wire [7:0] outARArbs_0_io_in_1_bits_len; // @[AXI4Xbar.scala 34:55]
  wire [2:0] outARArbs_0_io_in_1_bits_size; // @[AXI4Xbar.scala 34:55]
  wire [1:0] outARArbs_0_io_in_1_bits_burst; // @[AXI4Xbar.scala 34:55]
  wire  outARArbs_0_io_in_1_bits_lock; // @[AXI4Xbar.scala 34:55]
  wire [3:0] outARArbs_0_io_in_1_bits_cache; // @[AXI4Xbar.scala 34:55]
  wire [3:0] outARArbs_0_io_in_1_bits_qos; // @[AXI4Xbar.scala 34:55]
  wire  outARArbs_0_io_out_ready; // @[AXI4Xbar.scala 34:55]
  wire  outARArbs_0_io_out_valid; // @[AXI4Xbar.scala 34:55]
  wire [31:0] outARArbs_0_io_out_bits_addr; // @[AXI4Xbar.scala 34:55]
  wire [2:0] outARArbs_0_io_out_bits_prot; // @[AXI4Xbar.scala 34:55]
  wire [31:0] outARArbs_0_io_out_bits_id; // @[AXI4Xbar.scala 34:55]
  wire  outARArbs_0_io_out_bits_user; // @[AXI4Xbar.scala 34:55]
  wire [7:0] outARArbs_0_io_out_bits_len; // @[AXI4Xbar.scala 34:55]
  wire [2:0] outARArbs_0_io_out_bits_size; // @[AXI4Xbar.scala 34:55]
  wire [1:0] outARArbs_0_io_out_bits_burst; // @[AXI4Xbar.scala 34:55]
  wire  outARArbs_0_io_out_bits_lock; // @[AXI4Xbar.scala 34:55]
  wire [3:0] outARArbs_0_io_out_bits_cache; // @[AXI4Xbar.scala 34:55]
  wire [3:0] outARArbs_0_io_out_bits_qos; // @[AXI4Xbar.scala 34:55]
  wire  outARArbs_0_io_chosen; // @[AXI4Xbar.scala 34:55]
  wire  outAWArbs_0_io_in_0_ready; // @[AXI4Xbar.scala 35:55]
  wire  outAWArbs_0_io_in_0_valid; // @[AXI4Xbar.scala 35:55]
  wire [31:0] outAWArbs_0_io_in_0_bits_addr; // @[AXI4Xbar.scala 35:55]
  wire [2:0] outAWArbs_0_io_in_0_bits_prot; // @[AXI4Xbar.scala 35:55]
  wire [31:0] outAWArbs_0_io_in_0_bits_id; // @[AXI4Xbar.scala 35:55]
  wire  outAWArbs_0_io_in_0_bits_user; // @[AXI4Xbar.scala 35:55]
  wire [7:0] outAWArbs_0_io_in_0_bits_len; // @[AXI4Xbar.scala 35:55]
  wire [2:0] outAWArbs_0_io_in_0_bits_size; // @[AXI4Xbar.scala 35:55]
  wire [1:0] outAWArbs_0_io_in_0_bits_burst; // @[AXI4Xbar.scala 35:55]
  wire  outAWArbs_0_io_in_0_bits_lock; // @[AXI4Xbar.scala 35:55]
  wire [3:0] outAWArbs_0_io_in_0_bits_cache; // @[AXI4Xbar.scala 35:55]
  wire [3:0] outAWArbs_0_io_in_0_bits_qos; // @[AXI4Xbar.scala 35:55]
  wire  outAWArbs_0_io_in_1_ready; // @[AXI4Xbar.scala 35:55]
  wire  outAWArbs_0_io_in_1_valid; // @[AXI4Xbar.scala 35:55]
  wire [31:0] outAWArbs_0_io_in_1_bits_addr; // @[AXI4Xbar.scala 35:55]
  wire [2:0] outAWArbs_0_io_in_1_bits_prot; // @[AXI4Xbar.scala 35:55]
  wire [31:0] outAWArbs_0_io_in_1_bits_id; // @[AXI4Xbar.scala 35:55]
  wire  outAWArbs_0_io_in_1_bits_user; // @[AXI4Xbar.scala 35:55]
  wire [7:0] outAWArbs_0_io_in_1_bits_len; // @[AXI4Xbar.scala 35:55]
  wire [2:0] outAWArbs_0_io_in_1_bits_size; // @[AXI4Xbar.scala 35:55]
  wire [1:0] outAWArbs_0_io_in_1_bits_burst; // @[AXI4Xbar.scala 35:55]
  wire  outAWArbs_0_io_in_1_bits_lock; // @[AXI4Xbar.scala 35:55]
  wire [3:0] outAWArbs_0_io_in_1_bits_cache; // @[AXI4Xbar.scala 35:55]
  wire [3:0] outAWArbs_0_io_in_1_bits_qos; // @[AXI4Xbar.scala 35:55]
  wire  outAWArbs_0_io_out_ready; // @[AXI4Xbar.scala 35:55]
  wire  outAWArbs_0_io_out_valid; // @[AXI4Xbar.scala 35:55]
  wire [31:0] outAWArbs_0_io_out_bits_addr; // @[AXI4Xbar.scala 35:55]
  wire [2:0] outAWArbs_0_io_out_bits_prot; // @[AXI4Xbar.scala 35:55]
  wire [31:0] outAWArbs_0_io_out_bits_id; // @[AXI4Xbar.scala 35:55]
  wire  outAWArbs_0_io_out_bits_user; // @[AXI4Xbar.scala 35:55]
  wire [7:0] outAWArbs_0_io_out_bits_len; // @[AXI4Xbar.scala 35:55]
  wire [2:0] outAWArbs_0_io_out_bits_size; // @[AXI4Xbar.scala 35:55]
  wire [1:0] outAWArbs_0_io_out_bits_burst; // @[AXI4Xbar.scala 35:55]
  wire  outAWArbs_0_io_out_bits_lock; // @[AXI4Xbar.scala 35:55]
  wire [3:0] outAWArbs_0_io_out_bits_cache; // @[AXI4Xbar.scala 35:55]
  wire [3:0] outAWArbs_0_io_out_bits_qos; // @[AXI4Xbar.scala 35:55]
  wire  outAWArbs_0_io_chosen; // @[AXI4Xbar.scala 35:55]
  reg [63:0] timer; // @[EmuLog.scala 9:30]
  reg [63:0] _RAND_0;
  wire [63:0] _T_1; // @[EmuLog.scala 10:18]
  wire  _T_3; // @[EmuLog.scala 16:13]
  reg  outWBurst_0; // @[AXI4Xbar.scala 36:26]
  reg [31:0] _RAND_1;
  reg  inRBurst_0; // @[AXI4Xbar.scala 37:25]
  reg [31:0] _RAND_2;
  reg  awDestValid_0; // @[AXI4Xbar.scala 40:28]
  reg [31:0] _RAND_3;
  reg  awDestValid_1; // @[AXI4Xbar.scala 40:28]
  reg [31:0] _RAND_4;
  wire  _T_26; // @[Decoupled.scala 40:37]
  wire  _T_29; // @[AXI4Xbar.scala 51:49]
  wire  _T_32; // @[AXI4Xbar.scala 51:49]
  wire  _T_34; // @[AXI4Xbar.scala 63:36]
  wire  _T_35; // @[AXI4Xbar.scala 63:51]
  wire  _T_37; // @[AXI4Xbar.scala 63:36]
  wire [32:0] _T_40; // @[AXI4Xbar.scala 70:42]
  wire [32:0] _GEN_400; // @[AXI4Xbar.scala 70:62]
  wire [32:0] _T_41; // @[AXI4Xbar.scala 70:62]
  wire  _T_42; // @[Decoupled.scala 40:37]
  wire  _GEN_2; // @[AXI4Xbar.scala 71:25]
  wire  _T_45; // @[AXI4Xbar.scala 85:24]
  wire  _T_46; // @[AXI4Xbar.scala 85:60]
  wire  _T_47; // @[AXI4Xbar.scala 85:50]
  wire  _T_48; // @[AXI4Xbar.scala 85:68]
  wire  _T_51; // @[AXI4Xbar.scala 85:24]
  wire  _T_52; // @[AXI4Xbar.scala 85:60]
  wire  _T_53; // @[AXI4Xbar.scala 85:50]
  wire  _T_54; // @[AXI4Xbar.scala 85:68]
  wire  _GEN_5; // @[AXI4Xbar.scala 108:29]
  wire  _GEN_6; // @[AXI4Xbar.scala 108:29]
  wire  _T_63; // @[Decoupled.scala 40:37]
  wire  _T_66; // @[AXI4Xbar.scala 122:22]
  wire  _GEN_11; // @[AXI4Xbar.scala 122:38]
  wire [3:0] _GEN_12; // @[AXI4Xbar.scala 122:38]
  wire [31:0] _GEN_13; // @[AXI4Xbar.scala 122:38]
  wire  _GEN_14; // @[AXI4Xbar.scala 122:38]
  wire  _T_67; // @[Decoupled.scala 40:37]
  wire  _T_71; // @[AXI4Xbar.scala 128:21]
  wire  _T_76; // @[Decoupled.scala 40:37]
  wire  _T_79; // @[AXI4Xbar.scala 122:22]
  wire  _T_80; // @[Decoupled.scala 40:37]
  wire  _T_84; // @[AXI4Xbar.scala 128:21]
  wire  _GEN_402; // @[AXI4Xbar.scala 141:12]
  wire  _GEN_23; // @[AXI4Xbar.scala 141:12]
  wire  _GEN_24; // @[AXI4Xbar.scala 141:12]
  wire [9:0] _GEN_25; // @[AXI4Xbar.scala 141:12]
  wire [9:0] _GEN_26; // @[AXI4Xbar.scala 141:12]
  wire [1:0] _GEN_27; // @[AXI4Xbar.scala 141:12]
  wire [1:0] _GEN_28; // @[AXI4Xbar.scala 141:12]
  wire  _GEN_29; // @[AXI4Xbar.scala 141:12]
  wire  _GEN_30; // @[AXI4Xbar.scala 141:12]
  wire  _GEN_89; // @[AXI4Xbar.scala 141:12]
  wire  _GEN_90; // @[AXI4Xbar.scala 141:12]
  wire [9:0] _io_in_T_89_b_bits_id_0; // @[AXI4Xbar.scala 142:20 AXI4Xbar.scala 142:20]
  wire [9:0] _GEN_113; // @[AXI4Xbar.scala 142:20]
  wire [9:0] _GEN_114; // @[AXI4Xbar.scala 142:20]
  wire  _T_91; // @[Decoupled.scala 40:37]
  wire  _T_95; // @[AXI4Xbar.scala 51:49]
  wire  _T_98; // @[AXI4Xbar.scala 51:49]
  wire  _T_100; // @[AXI4Xbar.scala 66:36]
  wire  _T_101; // @[AXI4Xbar.scala 66:51]
  wire  _T_102; // @[AXI4Xbar.scala 66:48]
  wire  _T_103; // @[AXI4Xbar.scala 66:64]
  wire  _T_105; // @[AXI4Xbar.scala 66:36]
  wire  _T_107; // @[AXI4Xbar.scala 66:48]
  wire [32:0] _T_110; // @[AXI4Xbar.scala 70:42]
  wire [32:0] _GEN_404; // @[AXI4Xbar.scala 70:62]
  wire [32:0] _T_111; // @[AXI4Xbar.scala 70:62]
  wire  _T_112; // @[Decoupled.scala 40:37]
  wire  _GEN_207; // @[AXI4Xbar.scala 71:25]
  wire  _T_116; // @[AXI4Xbar.scala 85:24]
  wire  _T_117; // @[AXI4Xbar.scala 85:60]
  wire  _T_118; // @[AXI4Xbar.scala 85:50]
  wire  _T_119; // @[AXI4Xbar.scala 85:68]
  wire  _T_123; // @[AXI4Xbar.scala 85:24]
  wire  _T_124; // @[AXI4Xbar.scala 85:60]
  wire  _T_125; // @[AXI4Xbar.scala 85:50]
  wire  _T_126; // @[AXI4Xbar.scala 85:68]
  wire  _GEN_405; // @[AXI4Xbar.scala 160:12]
  wire  _GEN_208; // @[AXI4Xbar.scala 160:12]
  wire  _GEN_209; // @[AXI4Xbar.scala 160:12]
  wire [9:0] _GEN_210; // @[AXI4Xbar.scala 160:12]
  wire [9:0] _GEN_211; // @[AXI4Xbar.scala 160:12]
  wire  _GEN_212; // @[AXI4Xbar.scala 160:12]
  wire  _GEN_213; // @[AXI4Xbar.scala 160:12]
  wire [31:0] _GEN_214; // @[AXI4Xbar.scala 160:12]
  wire [31:0] _GEN_215; // @[AXI4Xbar.scala 160:12]
  wire [1:0] _GEN_216; // @[AXI4Xbar.scala 160:12]
  wire [1:0] _GEN_217; // @[AXI4Xbar.scala 160:12]
  wire  _GEN_218; // @[AXI4Xbar.scala 160:12]
  wire  _GEN_219; // @[AXI4Xbar.scala 160:12]
  wire  _GEN_295; // @[AXI4Xbar.scala 160:12]
  wire  _GEN_296; // @[AXI4Xbar.scala 160:12]
  wire [9:0] _GEN_304; // @[AXI4Xbar.scala 159:20]
  wire [9:0] _GEN_305; // @[AXI4Xbar.scala 159:20]
  wire [9:0] _io_in_T_131_r_bits_id_0; // @[AXI4Xbar.scala 162:18 AXI4Xbar.scala 162:18]
  wire  _T_133; // @[Decoupled.scala 40:37]
  wire  _T_136; // @[Decoupled.scala 40:37]
  wire  _T_137; // @[AXI4Xbar.scala 166:20]
  Arbiter outARArbs_0 ( // @[AXI4Xbar.scala 34:55]
    .io_in_0_ready(outARArbs_0_io_in_0_ready),
    .io_in_0_valid(outARArbs_0_io_in_0_valid),
    .io_in_0_bits_addr(outARArbs_0_io_in_0_bits_addr),
    .io_in_0_bits_prot(outARArbs_0_io_in_0_bits_prot),
    .io_in_0_bits_id(outARArbs_0_io_in_0_bits_id),
    .io_in_0_bits_user(outARArbs_0_io_in_0_bits_user),
    .io_in_0_bits_len(outARArbs_0_io_in_0_bits_len),
    .io_in_0_bits_size(outARArbs_0_io_in_0_bits_size),
    .io_in_0_bits_burst(outARArbs_0_io_in_0_bits_burst),
    .io_in_0_bits_lock(outARArbs_0_io_in_0_bits_lock),
    .io_in_0_bits_cache(outARArbs_0_io_in_0_bits_cache),
    .io_in_0_bits_qos(outARArbs_0_io_in_0_bits_qos),
    .io_in_1_ready(outARArbs_0_io_in_1_ready),
    .io_in_1_valid(outARArbs_0_io_in_1_valid),
    .io_in_1_bits_addr(outARArbs_0_io_in_1_bits_addr),
    .io_in_1_bits_prot(outARArbs_0_io_in_1_bits_prot),
    .io_in_1_bits_id(outARArbs_0_io_in_1_bits_id),
    .io_in_1_bits_user(outARArbs_0_io_in_1_bits_user),
    .io_in_1_bits_len(outARArbs_0_io_in_1_bits_len),
    .io_in_1_bits_size(outARArbs_0_io_in_1_bits_size),
    .io_in_1_bits_burst(outARArbs_0_io_in_1_bits_burst),
    .io_in_1_bits_lock(outARArbs_0_io_in_1_bits_lock),
    .io_in_1_bits_cache(outARArbs_0_io_in_1_bits_cache),
    .io_in_1_bits_qos(outARArbs_0_io_in_1_bits_qos),
    .io_out_ready(outARArbs_0_io_out_ready),
    .io_out_valid(outARArbs_0_io_out_valid),
    .io_out_bits_addr(outARArbs_0_io_out_bits_addr),
    .io_out_bits_prot(outARArbs_0_io_out_bits_prot),
    .io_out_bits_id(outARArbs_0_io_out_bits_id),
    .io_out_bits_user(outARArbs_0_io_out_bits_user),
    .io_out_bits_len(outARArbs_0_io_out_bits_len),
    .io_out_bits_size(outARArbs_0_io_out_bits_size),
    .io_out_bits_burst(outARArbs_0_io_out_bits_burst),
    .io_out_bits_lock(outARArbs_0_io_out_bits_lock),
    .io_out_bits_cache(outARArbs_0_io_out_bits_cache),
    .io_out_bits_qos(outARArbs_0_io_out_bits_qos),
    .io_chosen(outARArbs_0_io_chosen)
  );
  Arbiter outAWArbs_0 ( // @[AXI4Xbar.scala 35:55]
    .io_in_0_ready(outAWArbs_0_io_in_0_ready),
    .io_in_0_valid(outAWArbs_0_io_in_0_valid),
    .io_in_0_bits_addr(outAWArbs_0_io_in_0_bits_addr),
    .io_in_0_bits_prot(outAWArbs_0_io_in_0_bits_prot),
    .io_in_0_bits_id(outAWArbs_0_io_in_0_bits_id),
    .io_in_0_bits_user(outAWArbs_0_io_in_0_bits_user),
    .io_in_0_bits_len(outAWArbs_0_io_in_0_bits_len),
    .io_in_0_bits_size(outAWArbs_0_io_in_0_bits_size),
    .io_in_0_bits_burst(outAWArbs_0_io_in_0_bits_burst),
    .io_in_0_bits_lock(outAWArbs_0_io_in_0_bits_lock),
    .io_in_0_bits_cache(outAWArbs_0_io_in_0_bits_cache),
    .io_in_0_bits_qos(outAWArbs_0_io_in_0_bits_qos),
    .io_in_1_ready(outAWArbs_0_io_in_1_ready),
    .io_in_1_valid(outAWArbs_0_io_in_1_valid),
    .io_in_1_bits_addr(outAWArbs_0_io_in_1_bits_addr),
    .io_in_1_bits_prot(outAWArbs_0_io_in_1_bits_prot),
    .io_in_1_bits_id(outAWArbs_0_io_in_1_bits_id),
    .io_in_1_bits_user(outAWArbs_0_io_in_1_bits_user),
    .io_in_1_bits_len(outAWArbs_0_io_in_1_bits_len),
    .io_in_1_bits_size(outAWArbs_0_io_in_1_bits_size),
    .io_in_1_bits_burst(outAWArbs_0_io_in_1_bits_burst),
    .io_in_1_bits_lock(outAWArbs_0_io_in_1_bits_lock),
    .io_in_1_bits_cache(outAWArbs_0_io_in_1_bits_cache),
    .io_in_1_bits_qos(outAWArbs_0_io_in_1_bits_qos),
    .io_out_ready(outAWArbs_0_io_out_ready),
    .io_out_valid(outAWArbs_0_io_out_valid),
    .io_out_bits_addr(outAWArbs_0_io_out_bits_addr),
    .io_out_bits_prot(outAWArbs_0_io_out_bits_prot),
    .io_out_bits_id(outAWArbs_0_io_out_bits_id),
    .io_out_bits_user(outAWArbs_0_io_out_bits_user),
    .io_out_bits_len(outAWArbs_0_io_out_bits_len),
    .io_out_bits_size(outAWArbs_0_io_out_bits_size),
    .io_out_bits_burst(outAWArbs_0_io_out_bits_burst),
    .io_out_bits_lock(outAWArbs_0_io_out_bits_lock),
    .io_out_bits_cache(outAWArbs_0_io_out_bits_cache),
    .io_out_bits_qos(outAWArbs_0_io_out_bits_qos),
    .io_chosen(outAWArbs_0_io_chosen)
  );
  assign _T_1 = timer + 64'h1; // @[EmuLog.scala 10:18]
  assign _T_3 = ~reset; // @[EmuLog.scala 16:13]
  assign _T_26 = outAWArbs_0_io_out_ready & outAWArbs_0_io_out_valid; // @[Decoupled.scala 40:37]
  assign _T_29 = io_in_0_aw_bits_addr < 32'h80100000; // @[AXI4Xbar.scala 51:49]
  assign _T_32 = io_in_1_aw_bits_addr < 32'h80100000; // @[AXI4Xbar.scala 51:49]
  assign _T_34 = io_in_0_aw_valid & _T_29; // @[AXI4Xbar.scala 63:36]
  assign _T_35 = ~outWBurst_0; // @[AXI4Xbar.scala 63:51]
  assign _T_37 = io_in_1_aw_valid & _T_32; // @[AXI4Xbar.scala 63:36]
  assign _T_40 = {outAWArbs_0_io_out_bits_id, 1'h0}; // @[AXI4Xbar.scala 70:42]
  assign _GEN_400 = {{32'd0}, outAWArbs_0_io_chosen}; // @[AXI4Xbar.scala 70:62]
  assign _T_41 = _T_40 | _GEN_400; // @[AXI4Xbar.scala 70:62]
  assign _T_42 = io_out_0_aw_ready & io_out_0_aw_valid; // @[Decoupled.scala 40:37]
  assign _GEN_2 = _T_42 | outWBurst_0; // @[AXI4Xbar.scala 71:25]
  assign _T_45 = outAWArbs_0_io_in_0_ready; // @[AXI4Xbar.scala 85:24]
  assign _T_46 = ~outAWArbs_0_io_chosen; // @[AXI4Xbar.scala 85:60]
  assign _T_47 = _T_45 & _T_46; // @[AXI4Xbar.scala 85:50]
  assign _T_48 = _T_47 & _T_29; // @[AXI4Xbar.scala 85:68]
  assign _T_51 = outAWArbs_0_io_in_1_ready; // @[AXI4Xbar.scala 85:24]
  assign _T_52 = outAWArbs_0_io_chosen; // @[AXI4Xbar.scala 85:60]
  assign _T_53 = _T_51 & _T_52; // @[AXI4Xbar.scala 85:50]
  assign _T_54 = _T_53 & _T_32; // @[AXI4Xbar.scala 85:68]
  assign _GEN_5 = _T_46 | awDestValid_0; // @[AXI4Xbar.scala 108:29]
  assign _GEN_6 = outAWArbs_0_io_chosen | awDestValid_1; // @[AXI4Xbar.scala 108:29]
  assign _T_63 = io_in_0_aw_ready & io_in_0_aw_valid; // @[Decoupled.scala 40:37]
  assign _T_66 = _T_63 | awDestValid_0; // @[AXI4Xbar.scala 122:22]
  assign _GEN_11 = _T_66 & io_in_0_w_bits_last; // @[AXI4Xbar.scala 122:38]
  assign _GEN_12 = _T_66 ? io_in_0_w_bits_strb : 4'h0; // @[AXI4Xbar.scala 122:38]
  assign _GEN_13 = _T_66 ? io_in_0_w_bits_data : 32'h0; // @[AXI4Xbar.scala 122:38]
  assign _GEN_14 = _T_66 & io_in_0_w_valid; // @[AXI4Xbar.scala 122:38]
  assign _T_67 = io_in_0_w_ready & io_in_0_w_valid; // @[Decoupled.scala 40:37]
  assign _T_71 = _T_67 & io_in_0_w_bits_last; // @[AXI4Xbar.scala 128:21]
  assign _T_76 = io_in_1_aw_ready & io_in_1_aw_valid; // @[Decoupled.scala 40:37]
  assign _T_79 = _T_76 | awDestValid_1; // @[AXI4Xbar.scala 122:22]
  assign _T_80 = io_in_1_w_ready & io_in_1_w_valid; // @[Decoupled.scala 40:37]
  assign _T_84 = _T_80 & io_in_1_w_bits_last; // @[AXI4Xbar.scala 128:21]
  assign _GEN_402 = ~io_out_0_b_bits_id[0]; // @[AXI4Xbar.scala 141:12]
  assign _GEN_23 = _GEN_402 & io_out_0_b_bits_user; // @[AXI4Xbar.scala 141:12]
  assign _GEN_24 = io_out_0_b_bits_id[0] & io_out_0_b_bits_user; // @[AXI4Xbar.scala 141:12]
  assign _GEN_25 = ~io_out_0_b_bits_id[0] ? io_out_0_b_bits_id : 10'h0; // @[AXI4Xbar.scala 141:12]
  assign _GEN_26 = io_out_0_b_bits_id[0] ? io_out_0_b_bits_id : 10'h0; // @[AXI4Xbar.scala 141:12]
  assign _GEN_27 = ~io_out_0_b_bits_id[0] ? io_out_0_b_bits_resp : 2'h0; // @[AXI4Xbar.scala 141:12]
  assign _GEN_28 = io_out_0_b_bits_id[0] ? io_out_0_b_bits_resp : 2'h0; // @[AXI4Xbar.scala 141:12]
  assign _GEN_29 = _GEN_402 & io_out_0_b_valid; // @[AXI4Xbar.scala 141:12]
  assign _GEN_30 = io_out_0_b_bits_id[0] & io_out_0_b_valid; // @[AXI4Xbar.scala 141:12]
  assign _GEN_89 = io_out_0_b_bits_id[0] ? io_in_1_b_ready : io_in_0_b_ready; // @[AXI4Xbar.scala 141:12]
  assign _GEN_90 = io_out_0_b_bits_id[0] ? io_in_1_b_valid : io_in_0_b_valid; // @[AXI4Xbar.scala 141:12]
  assign _io_in_T_89_b_bits_id_0 = {{1'd0}, io_out_0_b_bits_id[9:1]}; // @[AXI4Xbar.scala 142:20 AXI4Xbar.scala 142:20]
  assign _GEN_113 = ~io_out_0_b_bits_id[0] ? _io_in_T_89_b_bits_id_0 : _GEN_25; // @[AXI4Xbar.scala 142:20]
  assign _GEN_114 = io_out_0_b_bits_id[0] ? _io_in_T_89_b_bits_id_0 : _GEN_26; // @[AXI4Xbar.scala 142:20]
  assign _T_91 = _GEN_89 & _GEN_90; // @[Decoupled.scala 40:37]
  assign _T_95 = io_in_0_ar_bits_addr < 32'h80100000; // @[AXI4Xbar.scala 51:49]
  assign _T_98 = io_in_1_ar_bits_addr < 32'h80100000; // @[AXI4Xbar.scala 51:49]
  assign _T_100 = io_in_0_ar_valid & _T_95; // @[AXI4Xbar.scala 66:36]
  assign _T_101 = ~inRBurst_0; // @[AXI4Xbar.scala 66:51]
  assign _T_102 = _T_100 & _T_101; // @[AXI4Xbar.scala 66:48]
  assign _T_103 = ~outAWArbs_0_io_out_valid; // @[AXI4Xbar.scala 66:64]
  assign _T_105 = io_in_1_ar_valid & _T_98; // @[AXI4Xbar.scala 66:36]
  assign _T_107 = _T_105 & _T_101; // @[AXI4Xbar.scala 66:48]
  assign _T_110 = {outARArbs_0_io_out_bits_id, 1'h0}; // @[AXI4Xbar.scala 70:42]
  assign _GEN_404 = {{32'd0}, outARArbs_0_io_chosen}; // @[AXI4Xbar.scala 70:62]
  assign _T_111 = _T_110 | _GEN_404; // @[AXI4Xbar.scala 70:62]
  assign _T_112 = io_out_0_ar_ready & io_out_0_ar_valid; // @[Decoupled.scala 40:37]
  assign _GEN_207 = _T_112 | inRBurst_0; // @[AXI4Xbar.scala 71:25]
  assign _T_116 = _T_103 & outARArbs_0_io_in_0_ready; // @[AXI4Xbar.scala 85:24]
  assign _T_117 = ~outARArbs_0_io_chosen; // @[AXI4Xbar.scala 85:60]
  assign _T_118 = _T_116 & _T_117; // @[AXI4Xbar.scala 85:50]
  assign _T_119 = _T_118 & _T_95; // @[AXI4Xbar.scala 85:68]
  assign _T_123 = _T_103 & outARArbs_0_io_in_1_ready; // @[AXI4Xbar.scala 85:24]
  assign _T_124 = outARArbs_0_io_chosen; // @[AXI4Xbar.scala 85:60]
  assign _T_125 = _T_123 & _T_124; // @[AXI4Xbar.scala 85:50]
  assign _T_126 = _T_125 & _T_98; // @[AXI4Xbar.scala 85:68]
  assign _GEN_405 = ~io_out_0_r_bits_id[0]; // @[AXI4Xbar.scala 160:12]
  assign _GEN_208 = _GEN_405 & io_out_0_r_bits_user; // @[AXI4Xbar.scala 160:12]
  assign _GEN_209 = io_out_0_r_bits_id[0] & io_out_0_r_bits_user; // @[AXI4Xbar.scala 160:12]
  assign _GEN_210 = ~io_out_0_r_bits_id[0] ? io_out_0_r_bits_id : 10'h0; // @[AXI4Xbar.scala 160:12]
  assign _GEN_211 = io_out_0_r_bits_id[0] ? io_out_0_r_bits_id : 10'h0; // @[AXI4Xbar.scala 160:12]
  assign _GEN_212 = _GEN_405 & io_out_0_r_bits_last; // @[AXI4Xbar.scala 160:12]
  assign _GEN_213 = io_out_0_r_bits_id[0] & io_out_0_r_bits_last; // @[AXI4Xbar.scala 160:12]
  assign _GEN_214 = ~io_out_0_r_bits_id[0] ? io_out_0_r_bits_data : 32'h0; // @[AXI4Xbar.scala 160:12]
  assign _GEN_215 = io_out_0_r_bits_id[0] ? io_out_0_r_bits_data : 32'h0; // @[AXI4Xbar.scala 160:12]
  assign _GEN_216 = ~io_out_0_r_bits_id[0] ? io_out_0_r_bits_resp : 2'h0; // @[AXI4Xbar.scala 160:12]
  assign _GEN_217 = io_out_0_r_bits_id[0] ? io_out_0_r_bits_resp : 2'h0; // @[AXI4Xbar.scala 160:12]
  assign _GEN_218 = _GEN_405 & io_out_0_r_valid; // @[AXI4Xbar.scala 160:12]
  assign _GEN_219 = io_out_0_r_bits_id[0] & io_out_0_r_valid; // @[AXI4Xbar.scala 160:12]
  assign _GEN_295 = io_out_0_r_bits_id[0] ? io_in_1_r_ready : io_in_0_r_ready; // @[AXI4Xbar.scala 160:12]
  assign _GEN_296 = io_out_0_r_bits_id[0] ? io_in_1_r_valid : io_in_0_r_valid; // @[AXI4Xbar.scala 160:12]
  assign _GEN_304 = io_out_0_r_valid ? _GEN_210 : 10'h0; // @[AXI4Xbar.scala 159:20]
  assign _GEN_305 = io_out_0_r_valid ? _GEN_211 : 10'h0; // @[AXI4Xbar.scala 159:20]
  assign _io_in_T_131_r_bits_id_0 = {{1'd0}, io_out_0_r_bits_id[9:1]}; // @[AXI4Xbar.scala 162:18 AXI4Xbar.scala 162:18]
  assign _T_133 = _GEN_295 & _GEN_296; // @[Decoupled.scala 40:37]
  assign _T_136 = io_out_0_r_ready & io_out_0_r_valid; // @[Decoupled.scala 40:37]
  assign _T_137 = _T_136 & io_out_0_r_bits_last; // @[AXI4Xbar.scala 166:20]
  assign io_in_0_aw_ready = _T_48 & _T_35; // @[AXI4Xbar.scala 61:16 AXI4Xbar.scala 84:16]
  assign io_in_0_w_ready = _T_66 & io_out_0_w_ready; // @[AXI4Xbar.scala 117:14 AXI4Xbar.scala 123:23]
  assign io_in_0_b_valid = io_out_0_b_valid & _GEN_29; // @[AXI4Xbar.scala 135:34 AXI4Xbar.scala 141:12]
  assign io_in_0_b_bits_resp = io_out_0_b_valid ? _GEN_27 : 2'h0; // @[AXI4Xbar.scala 135:34 AXI4Xbar.scala 141:12]
  assign io_in_0_b_bits_id = io_out_0_b_valid ? _GEN_113 : 10'h0; // @[AXI4Xbar.scala 135:34 AXI4Xbar.scala 141:12 AXI4Xbar.scala 142:20]
  assign io_in_0_b_bits_user = io_out_0_b_valid & _GEN_23; // @[AXI4Xbar.scala 135:34 AXI4Xbar.scala 141:12]
  assign io_in_0_ar_ready = _T_119 & _T_101; // @[AXI4Xbar.scala 61:16 AXI4Xbar.scala 84:16]
  assign io_in_0_r_valid = io_out_0_r_valid & _GEN_218; // @[AXI4Xbar.scala 154:34 AXI4Xbar.scala 160:12]
  assign io_in_0_r_bits_resp = io_out_0_r_valid ? _GEN_216 : 2'h0; // @[AXI4Xbar.scala 154:34 AXI4Xbar.scala 160:12]
  assign io_in_0_r_bits_data = io_out_0_r_valid ? _GEN_214 : 32'h0; // @[AXI4Xbar.scala 154:34 AXI4Xbar.scala 160:12]
  assign io_in_0_r_bits_last = io_out_0_r_valid & _GEN_212; // @[AXI4Xbar.scala 154:34 AXI4Xbar.scala 160:12]
  assign io_in_0_r_bits_id = ~io_out_0_r_bits_id[0] ? _io_in_T_131_r_bits_id_0 : _GEN_304; // @[AXI4Xbar.scala 154:34 AXI4Xbar.scala 160:12 AXI4Xbar.scala 162:18]
  assign io_in_0_r_bits_user = io_out_0_r_valid & _GEN_208; // @[AXI4Xbar.scala 154:34 AXI4Xbar.scala 160:12]
  assign io_in_1_aw_ready = _T_54 & _T_35; // @[AXI4Xbar.scala 61:16 AXI4Xbar.scala 84:16]
  assign io_in_1_w_ready = _T_79 & io_out_0_w_ready; // @[AXI4Xbar.scala 117:14 AXI4Xbar.scala 123:23]
  assign io_in_1_b_valid = io_out_0_b_valid & _GEN_30; // @[AXI4Xbar.scala 135:34 AXI4Xbar.scala 141:12]
  assign io_in_1_b_bits_resp = io_out_0_b_valid ? _GEN_28 : 2'h0; // @[AXI4Xbar.scala 135:34 AXI4Xbar.scala 141:12]
  assign io_in_1_b_bits_id = io_out_0_b_valid ? _GEN_114 : 10'h0; // @[AXI4Xbar.scala 135:34 AXI4Xbar.scala 141:12 AXI4Xbar.scala 142:20]
  assign io_in_1_b_bits_user = io_out_0_b_valid & _GEN_24; // @[AXI4Xbar.scala 135:34 AXI4Xbar.scala 141:12]
  assign io_in_1_ar_ready = _T_126 & _T_101; // @[AXI4Xbar.scala 61:16 AXI4Xbar.scala 84:16]
  assign io_in_1_r_valid = io_out_0_r_valid & _GEN_219; // @[AXI4Xbar.scala 154:34 AXI4Xbar.scala 160:12]
  assign io_in_1_r_bits_resp = io_out_0_r_valid ? _GEN_217 : 2'h0; // @[AXI4Xbar.scala 154:34 AXI4Xbar.scala 160:12]
  assign io_in_1_r_bits_data = io_out_0_r_valid ? _GEN_215 : 32'h0; // @[AXI4Xbar.scala 154:34 AXI4Xbar.scala 160:12]
  assign io_in_1_r_bits_last = io_out_0_r_valid & _GEN_213; // @[AXI4Xbar.scala 154:34 AXI4Xbar.scala 160:12]
  assign io_in_1_r_bits_id = io_out_0_r_bits_id[0] ? _io_in_T_131_r_bits_id_0 : _GEN_305; // @[AXI4Xbar.scala 154:34 AXI4Xbar.scala 160:12 AXI4Xbar.scala 162:18]
  assign io_in_1_r_bits_user = io_out_0_r_valid & _GEN_209; // @[AXI4Xbar.scala 154:34 AXI4Xbar.scala 160:12]
  assign io_out_0_aw_valid = outAWArbs_0_io_out_valid; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_aw_bits_addr = outAWArbs_0_io_out_bits_addr; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_aw_bits_prot = outAWArbs_0_io_out_bits_prot; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_aw_bits_id = _T_41[9:0]; // @[AXI4Xbar.scala 69:11 AXI4Xbar.scala 70:19]
  assign io_out_0_aw_bits_user = outAWArbs_0_io_out_bits_user; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_aw_bits_len = outAWArbs_0_io_out_bits_len; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_aw_bits_size = outAWArbs_0_io_out_bits_size; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_aw_bits_burst = outAWArbs_0_io_out_bits_burst; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_aw_bits_lock = outAWArbs_0_io_out_bits_lock; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_aw_bits_cache = outAWArbs_0_io_out_bits_cache; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_aw_bits_qos = outAWArbs_0_io_out_bits_qos; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_w_valid = _T_79 ? io_in_1_w_valid : _GEN_14; // @[AXI4Xbar.scala 113:34 AXI4Xbar.scala 123:23 AXI4Xbar.scala 123:23]
  assign io_out_0_w_bits_data = _T_79 ? io_in_1_w_bits_data : _GEN_13; // @[AXI4Xbar.scala 113:34 AXI4Xbar.scala 123:23 AXI4Xbar.scala 123:23]
  assign io_out_0_w_bits_strb = _T_79 ? io_in_1_w_bits_strb : _GEN_12; // @[AXI4Xbar.scala 113:34 AXI4Xbar.scala 123:23 AXI4Xbar.scala 123:23]
  assign io_out_0_w_bits_last = _T_79 ? io_in_1_w_bits_last : _GEN_11; // @[AXI4Xbar.scala 113:34 AXI4Xbar.scala 123:23 AXI4Xbar.scala 123:23]
  assign io_out_0_b_ready = io_out_0_b_valid & _GEN_89; // @[AXI4Xbar.scala 139:13 AXI4Xbar.scala 141:12]
  assign io_out_0_ar_valid = outARArbs_0_io_out_valid; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_ar_bits_addr = outARArbs_0_io_out_bits_addr; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_ar_bits_prot = outARArbs_0_io_out_bits_prot; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_ar_bits_id = _T_111[9:0]; // @[AXI4Xbar.scala 69:11 AXI4Xbar.scala 70:19]
  assign io_out_0_ar_bits_user = outARArbs_0_io_out_bits_user; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_ar_bits_len = outARArbs_0_io_out_bits_len; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_ar_bits_size = outARArbs_0_io_out_bits_size; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_ar_bits_burst = outARArbs_0_io_out_bits_burst; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_ar_bits_lock = outARArbs_0_io_out_bits_lock; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_ar_bits_cache = outARArbs_0_io_out_bits_cache; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_ar_bits_qos = outARArbs_0_io_out_bits_qos; // @[AXI4Xbar.scala 69:11]
  assign io_out_0_r_ready = io_out_0_r_valid & _GEN_295; // @[AXI4Xbar.scala 158:13 AXI4Xbar.scala 160:12]
  assign outARArbs_0_io_in_0_valid = _T_102 & _T_103; // @[AXI4Xbar.scala 61:16 AXI4Xbar.scala 66:24]
  assign outARArbs_0_io_in_0_bits_addr = io_in_0_ar_bits_addr; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_0_bits_prot = io_in_0_ar_bits_prot; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_0_bits_id = {{22'd0}, io_in_0_ar_bits_id}; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_0_bits_user = io_in_0_ar_bits_user; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_0_bits_len = io_in_0_ar_bits_len; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_0_bits_size = io_in_0_ar_bits_size; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_0_bits_burst = io_in_0_ar_bits_burst; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_0_bits_lock = io_in_0_ar_bits_lock; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_0_bits_cache = io_in_0_ar_bits_cache; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_0_bits_qos = io_in_0_ar_bits_qos; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_1_valid = _T_107 & _T_103; // @[AXI4Xbar.scala 61:16 AXI4Xbar.scala 66:24]
  assign outARArbs_0_io_in_1_bits_addr = io_in_1_ar_bits_addr; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_1_bits_prot = io_in_1_ar_bits_prot; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_1_bits_id = {{22'd0}, io_in_1_ar_bits_id}; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_1_bits_user = io_in_1_ar_bits_user; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_1_bits_len = io_in_1_ar_bits_len; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_1_bits_size = io_in_1_ar_bits_size; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_1_bits_burst = io_in_1_ar_bits_burst; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_1_bits_lock = io_in_1_ar_bits_lock; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_1_bits_cache = io_in_1_ar_bits_cache; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_in_1_bits_qos = io_in_1_ar_bits_qos; // @[AXI4Xbar.scala 61:16]
  assign outARArbs_0_io_out_ready = io_out_0_ar_ready; // @[AXI4Xbar.scala 69:11]
  assign outAWArbs_0_io_in_0_valid = _T_34 & _T_35; // @[AXI4Xbar.scala 61:16 AXI4Xbar.scala 63:24]
  assign outAWArbs_0_io_in_0_bits_addr = io_in_0_aw_bits_addr; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_0_bits_prot = io_in_0_aw_bits_prot; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_0_bits_id = {{22'd0}, io_in_0_aw_bits_id}; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_0_bits_user = io_in_0_aw_bits_user; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_0_bits_len = io_in_0_aw_bits_len; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_0_bits_size = io_in_0_aw_bits_size; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_0_bits_burst = io_in_0_aw_bits_burst; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_0_bits_lock = io_in_0_aw_bits_lock; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_0_bits_cache = io_in_0_aw_bits_cache; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_0_bits_qos = io_in_0_aw_bits_qos; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_1_valid = _T_37 & _T_35; // @[AXI4Xbar.scala 61:16 AXI4Xbar.scala 63:24]
  assign outAWArbs_0_io_in_1_bits_addr = io_in_1_aw_bits_addr; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_1_bits_prot = io_in_1_aw_bits_prot; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_1_bits_id = {{22'd0}, io_in_1_aw_bits_id}; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_1_bits_user = io_in_1_aw_bits_user; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_1_bits_len = io_in_1_aw_bits_len; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_1_bits_size = io_in_1_aw_bits_size; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_1_bits_burst = io_in_1_aw_bits_burst; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_1_bits_lock = io_in_1_aw_bits_lock; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_1_bits_cache = io_in_1_aw_bits_cache; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_in_1_bits_qos = io_in_1_aw_bits_qos; // @[AXI4Xbar.scala 61:16]
  assign outAWArbs_0_io_out_ready = io_out_0_aw_ready; // @[AXI4Xbar.scala 69:11]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  timer = _RAND_0[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  outWBurst_0 = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  inRBurst_0 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  awDestValid_0 = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  awDestValid_1 = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      timer <= 64'h0;
    end else begin
      timer <= _T_1;
    end
    if (reset) begin
      outWBurst_0 <= 1'h0;
    end else if (_T_91) begin
      outWBurst_0 <= 1'h0;
    end else begin
      outWBurst_0 <= _GEN_2;
    end
    if (reset) begin
      inRBurst_0 <= 1'h0;
    end else if (_T_137) begin
      inRBurst_0 <= 1'h0;
    end else begin
      inRBurst_0 <= _GEN_207;
    end
    if (reset) begin
      awDestValid_0 <= 1'h0;
    end else if (_T_71) begin
      awDestValid_0 <= 1'h0;
    end else if (_T_26) begin
      awDestValid_0 <= _GEN_5;
    end
    if (reset) begin
      awDestValid_1 <= 1'h0;
    end else if (_T_84) begin
      awDestValid_1 <= 1'h0;
    end else if (_T_26) begin
      awDestValid_1 <= _GEN_6;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_0_ar_valid & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] in[%d] ar valid addr %x id %x\n",timer,1'h0,io_in_0_ar_bits_addr,io_in_0_ar_bits_id); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_0_aw_valid & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] in[%d] aw valid addr %x id %x\n",timer,1'h0,io_in_0_aw_bits_addr,io_in_0_aw_bits_id); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_0_w_valid & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] in[%d] w valid last %b\n",timer,1'h0,io_in_0_w_bits_last); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_1_ar_valid & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] in[%d] ar valid addr %x id %x\n",timer,1'h1,io_in_1_ar_bits_addr,io_in_1_ar_bits_id); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_1_aw_valid & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] in[%d] aw valid addr %x id %x\n",timer,1'h1,io_in_1_aw_bits_addr,io_in_1_aw_bits_id); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_1_w_valid & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] in[%d] w valid last %b\n",timer,1'h1,io_in_1_w_bits_last); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_out_0_r_valid & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] out[%d] r valid id %x last %b\n",timer,1'h0,io_out_0_r_bits_id,io_out_0_r_bits_last); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_out_0_b_valid & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] out[%d] b valid id %x\n",timer,1'h0,io_out_0_b_bits_id); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_42 & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] in[%d] aw routed to out[%d](%x,%x), id %x->%x\n",timer,outAWArbs_0_io_chosen,1'h0,1'h0,32'h80100000,outAWArbs_0_io_out_bits_id,io_out_0_aw_bits_id); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_26 & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] in(%d) aw destination is %d\n",timer,outAWArbs_0_io_chosen,1'h0); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_67 & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] w out port %d fired from in port %d\n",timer,1'h0,1'h0); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_71 & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] w in port %d last finished\n",timer,1'h0); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_80 & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] w out port %d fired from in port %d\n",timer,1'h0,1'h1); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_84 & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] w in port %d last finished\n",timer,1'h1); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_91 & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] out[%d] b routed to %d\n",timer,1'h0,io_out_0_b_bits_id[0]); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_112 & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] in[%d] ar routed to out[%d](%x,%x), id %x->%x\n",timer,outARArbs_0_io_chosen,1'h0,1'h0,32'h80100000,outARArbs_0_io_out_bits_id,io_out_0_ar_bits_id); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_133 & _T_3) begin
          $fwrite(32'h80000002,"cycle: %d [axi4xbar] r out port %d route to in port %d\n",timer,1'h0,io_out_0_r_bits_id[0]); // @[EmuLog.scala 16:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
