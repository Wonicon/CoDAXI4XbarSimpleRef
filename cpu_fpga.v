/* =========================================
* Custom CPU coupled with Zynq MPSoC PS part 
* for full-system evaluation
*
* Author: Yisong Chang (changyisong@ict.ac.cn)
* Date: 29/02/2020
* Version: v0.0.1
*===========================================
*/

`timescale 10 ns / 1 ns

module cpu_fpga ();

  wire [48:0]	axi_hp0_araddr;
  wire [1:0]	axi_hp0_arburst;
  wire [3:0]	axi_hp0_arcache;
  wire [7:0]	axi_hp0_arlen;
  wire [0:0]	axi_hp0_arlock;
  wire [2:0]	axi_hp0_arprot;
  wire [3:0]	axi_hp0_arqos;
  wire			  axi_hp0_arready;
  wire [3:0]	axi_hp0_arregion;
  wire [2:0]	axi_hp0_arsize;
  wire		    axi_hp0_arvalid;
  wire [5:0]  axi_hp0_arid;
  wire [48:0]	axi_hp0_awaddr;
  wire [1:0]	axi_hp0_awburst;
  wire [3:0]	axi_hp0_awcache;
  wire [7:0]	axi_hp0_awlen;
  wire [0:0]	axi_hp0_awlock;
  wire [2:0]	axi_hp0_awprot;
  wire [3:0]	axi_hp0_awqos;
  wire			  axi_hp0_awready;
  wire [3:0]	axi_hp0_awregion;
  wire [2:0]	axi_hp0_awsize;
  wire		    axi_hp0_awvalid;
  wire [5:0]  axi_hp0_awid;
  wire        axi_hp0_bready;
  wire [1:0]  axi_hp0_bresp;
  wire        axi_hp0_bvalid;
  wire [5:0]  axi_hp0_bid;
  wire [63:0] axi_hp0_rdata;
  wire        axi_hp0_rlast;
  wire        axi_hp0_rready;
  wire [1:0]  axi_hp0_rresp;
  wire [5:0]  axi_hp0_rid;
  wire        axi_hp0_rvalid;
  wire [63:0] axi_hp0_wdata;
  wire        axi_hp0_wlast;
  wire        axi_hp0_wready;
  wire [3:0]  axi_hp0_wstrb;
  wire        axi_hp0_wvalid;
  wire [5:0]  axi_hp0_wid;

  wire [31:0]	cpu_axi_data_araddr;
  wire [1:0]	cpu_axi_data_arburst;
  wire [3:0]	cpu_axi_data_arcache;
  wire [7:0]	cpu_axi_data_arlen;
  wire [0:0]	cpu_axi_data_arlock;
  wire [2:0]	cpu_axi_data_arprot;
  wire [3:0]	cpu_axi_data_arqos;
  wire			cpu_axi_data_arready;
  wire [3:0]	cpu_axi_data_arregion;
  wire [2:0]	cpu_axi_data_arsize;
  wire		cpu_axi_data_arvalid;
  wire [31:0]	cpu_axi_data_awaddr;
  wire [1:0]	cpu_axi_data_awburst;
  wire [3:0]	cpu_axi_data_awcache;
  wire [7:0]	cpu_axi_data_awlen;
  wire [0:0]	cpu_axi_data_awlock;
  wire [2:0]	cpu_axi_data_awprot;
  wire [3:0]	cpu_axi_data_awqos;
  wire			cpu_axi_data_awready;
  wire [3:0]	cpu_axi_data_awregion;
  wire [2:0]	cpu_axi_data_awsize;
  wire		cpu_axi_data_awvalid;
  wire cpu_axi_data_bready;
  wire [1:0]cpu_axi_data_bresp;
  wire cpu_axi_data_bvalid;
  wire [31:0]cpu_axi_data_rdata;
  wire cpu_axi_data_rlast;
  wire cpu_axi_data_rready;
  wire [1:0]cpu_axi_data_rresp;
  wire cpu_axi_data_rvalid;
  wire [31:0]cpu_axi_data_wdata;
  wire cpu_axi_data_wlast;
  wire cpu_axi_data_wready;
  wire [3:0]cpu_axi_data_wstrb;
  wire cpu_axi_data_wvalid;

  wire [31:0]cpu_axi_inst_araddr;
  wire [1:0]cpu_axi_inst_arburst;
  wire [3:0]cpu_axi_inst_arcache;
  wire [7:0]cpu_axi_inst_arlen;
  wire [0:0]cpu_axi_inst_arlock;
  wire [2:0]cpu_axi_inst_arprot;
  wire [3:0]cpu_axi_inst_arqos;
  wire cpu_axi_inst_arready;
  wire [3:0]cpu_axi_inst_arregion;
  wire [2:0]cpu_axi_inst_arsize;
  wire cpu_axi_inst_arvalid;
  wire [31:0]cpu_axi_inst_rdata;
  wire cpu_axi_inst_rlast;
  wire cpu_axi_inst_rready;
  wire [1:0]cpu_axi_inst_rresp;
  wire cpu_axi_inst_rvalid;

  wire [31:0]cpu_axi_mmio_araddr;
  wire [2:0]cpu_axi_mmio_arprot;
  wire cpu_axi_mmio_arready;
  wire cpu_axi_mmio_arvalid;
  wire [31:0]cpu_axi_mmio_awaddr;
  wire [2:0]cpu_axi_mmio_awprot;
  wire cpu_axi_mmio_awready;
  wire cpu_axi_mmio_awvalid;
  wire cpu_axi_mmio_bready;
  wire [1:0]cpu_axi_mmio_bresp;
  wire cpu_axi_mmio_bvalid;
  wire [31:0]cpu_axi_mmio_rdata;
  wire cpu_axi_mmio_rready;
  wire [1:0]cpu_axi_mmio_rresp;
  wire cpu_axi_mmio_rvalid;
  wire [31:0]cpu_axi_mmio_wdata;
  wire cpu_axi_mmio_wready;
  wire [3:0]cpu_axi_mmio_wstrb;
  wire cpu_axi_mmio_wvalid;

  wire [31:0]cpu_axi_uart_araddr;
  wire [2:0]cpu_axi_uart_arprot;
  wire cpu_axi_uart_arready;
  wire cpu_axi_uart_arvalid;
  wire [31:0]cpu_axi_uart_awaddr;
  wire [2:0]cpu_axi_uart_awprot;
  wire cpu_axi_uart_awready;
  wire cpu_axi_uart_awvalid;
  wire cpu_axi_uart_bready;
  wire [1:0]cpu_axi_uart_bresp;
  wire cpu_axi_uart_bvalid;
  wire [31:0]cpu_axi_uart_rdata;
  wire cpu_axi_uart_rready;
  wire [1:0]cpu_axi_uart_rresp;
  wire cpu_axi_uart_rvalid;
  wire [31:0]cpu_axi_uart_wdata;
  wire cpu_axi_uart_wready;
  wire [3:0]cpu_axi_uart_wstrb;
  wire cpu_axi_uart_wvalid;
  
  wire system_reset_n;
  wire sys_port_reset_n;
  wire system_clk;

mpsoc_wrapper	u_mpsoc_wrapper (
  .axi_hp0_araddr   ({'d0,axi_hp0_araddr[31:0]}  ),      //49
  .axi_hp0_arburst  (axi_hp0_arburst ),
  .axi_hp0_arcache  (axi_hp0_arcache ),
  .axi_hp0_arlen    (axi_hp0_arlen   ),
  .axi_hp0_arlock   (axi_hp0_arlock  ),
  .axi_hp0_arprot   (axi_hp0_arprot  ),
  .axi_hp0_arqos    (axi_hp0_arqos   ),
  .axi_hp0_arready  (axi_hp0_arready ),
  .axi_hp0_arsize   (axi_hp0_arsize  ),
  .axi_hp0_arvalid  (axi_hp0_arvalid ),
  .axi_hp0_awaddr   ({'d0,axi_hp0_awaddr[31:0]}  ),
  .axi_hp0_awburst  (axi_hp0_awburst ),
  .axi_hp0_awcache  (axi_hp0_awcache ),
  .axi_hp0_awlen   (axi_hp0_awlen   ),
  .axi_hp0_awlock  (axi_hp0_awlock  ),
  .axi_hp0_awprot  (axi_hp0_awprot  ),
  .axi_hp0_awqos   (axi_hp0_awqos   ),
  .axi_hp0_awready (axi_hp0_awready ),
  .axi_hp0_awsize  (axi_hp0_awsize  ),
  .axi_hp0_awvalid (axi_hp0_awvalid ),
  .axi_hp0_bready (axi_hp0_bready ),
  .axi_hp0_bresp  (axi_hp0_bresp  ),
  .axi_hp0_bvalid (axi_hp0_bvalid ),
  .axi_hp0_rdata  (axi_hp0_rdata  ),         //64
  .axi_hp0_rlast  (axi_hp0_rlast  ),
  .axi_hp0_rready (axi_hp0_rready ),
  .axi_hp0_rresp  (axi_hp0_rresp  ),
  .axi_hp0_rvalid (axi_hp0_rvalid ),
  .axi_hp0_wdata  (axi_hp0_wdata  ),
  .axi_hp0_wlast  (axi_hp0_wlast  ),
  .axi_hp0_wready (axi_hp0_wready ),
  .axi_hp0_wstrb  ({'d0,axi_hp0_wstrb[3:0]}  ),
  .axi_hp0_wvalid (axi_hp0_wvalid ),
  // .cpu_axi_inst_araddr (cpu_axi_inst_araddr ),
  // .cpu_axi_inst_arburst(cpu_axi_inst_arburst),
  // .cpu_axi_inst_arcache(cpu_axi_inst_arcache),
  // .cpu_axi_inst_arlen  (cpu_axi_inst_arlen  ),
  // .cpu_axi_inst_arlock  (cpu_axi_inst_arlock  ),
  // .cpu_axi_inst_arprot  (cpu_axi_inst_arprot  ),
  // .cpu_axi_inst_arqos   (cpu_axi_inst_arqos   ),
  // .cpu_axi_inst_arready (cpu_axi_inst_arready ),
  // .cpu_axi_inst_arsize  (cpu_axi_inst_arsize  ),
  // .cpu_axi_inst_arvalid (cpu_axi_inst_arvalid ),
  // .cpu_axi_inst_rdata   (cpu_axi_inst_rdata   ),
  // .cpu_axi_inst_rlast   (cpu_axi_inst_rlast   ),
  // .cpu_axi_inst_rready  (cpu_axi_inst_rready  ),
  // .cpu_axi_inst_rresp   (cpu_axi_inst_rresp   ),
  // .cpu_axi_inst_rvalid  (cpu_axi_inst_rvalid  ),
   .cpu_axi_mmio_araddr  (cpu_axi_mmio_araddr  ),
   .cpu_axi_mmio_arprot  (cpu_axi_mmio_arprot  ),
   .cpu_axi_mmio_arready (cpu_axi_mmio_arready ),
   .cpu_axi_mmio_arvalid (cpu_axi_mmio_arvalid ),
   .cpu_axi_mmio_awaddr  (cpu_axi_mmio_awaddr  ),
   .cpu_axi_mmio_awprot  (cpu_axi_mmio_awprot  ),
   .cpu_axi_mmio_awready (cpu_axi_mmio_awready ),
   .cpu_axi_mmio_awvalid (cpu_axi_mmio_awvalid ),
   .cpu_axi_mmio_bready  (cpu_axi_mmio_bready  ),
   .cpu_axi_mmio_bresp   (cpu_axi_mmio_bresp   ),
   .cpu_axi_mmio_bvalid  (cpu_axi_mmio_bvalid  ),
   .cpu_axi_mmio_rdata   (cpu_axi_mmio_rdata   ),
   .cpu_axi_mmio_rready  (cpu_axi_mmio_rready  ),
   .cpu_axi_mmio_rresp   (cpu_axi_mmio_rresp   ),
   .cpu_axi_mmio_rvalid  (cpu_axi_mmio_rvalid  ),
   .cpu_axi_mmio_wdata   (cpu_axi_mmio_wdata   ),
   .cpu_axi_mmio_wready  (cpu_axi_mmio_wready  ),
   .cpu_axi_mmio_wstrb   (cpu_axi_mmio_wstrb   ),
   .cpu_axi_mmio_wvalid  (cpu_axi_mmio_wvalid  ),
   .cpu_axi_uart_araddr  (cpu_axi_uart_araddr  ),
   .cpu_axi_uart_arready (cpu_axi_uart_arready ),
   .cpu_axi_uart_arvalid (cpu_axi_uart_arvalid ),
   .cpu_axi_uart_awaddr  (cpu_axi_uart_awaddr  ),
   .cpu_axi_uart_awready (cpu_axi_uart_awready ),
   .cpu_axi_uart_awvalid (cpu_axi_uart_awvalid ),
   .cpu_axi_uart_bready  (cpu_axi_uart_bready  ),
   .cpu_axi_uart_bresp   (cpu_axi_uart_bresp   ),
   .cpu_axi_uart_bvalid  (cpu_axi_uart_bvalid  ),
   .cpu_axi_uart_rdata   (cpu_axi_uart_rdata   ),
   .cpu_axi_uart_rready  (cpu_axi_uart_rready  ),
   .cpu_axi_uart_rresp   (cpu_axi_uart_rresp   ),
   .cpu_axi_uart_rvalid  (cpu_axi_uart_rvalid  ),
   .cpu_axi_uart_wdata   (cpu_axi_uart_wdata   ),
   .cpu_axi_uart_wready  (cpu_axi_uart_wready  ),
   .cpu_axi_uart_wstrb   (cpu_axi_uart_wstrb   ),
   .cpu_axi_uart_wvalid  (cpu_axi_uart_wvalid  ),
   .system_reset_n  (system_reset_n),
   .sys_port_reset_n  (sys_port_reset_n),
   .system_clk (system_clk)
);

AXI4Xbar  u_AXI4Xbar(
    .clock    (system_clk),
    .reset    (~sys_port_reset_n),
    .io_in_0_aw_ready       (cpu_axi_data_awready),
    .io_in_0_aw_valid       (cpu_axi_data_awvalid),
    .io_in_0_aw_bits_addr   (cpu_axi_data_awaddr),
    .io_in_0_aw_bits_prot   (cpu_axi_data_awprot),
    .io_in_0_aw_bits_id     ('d0),
    //.io_in_0_aw_bits_user,
    .io_in_0_aw_bits_len    (cpu_axi_data_awlen),
    .io_in_0_aw_bits_size   (cpu_axi_data_awsize),
    .io_in_0_aw_bits_burst  (cpu_axi_data_awburst),
    .io_in_0_aw_bits_lock   (cpu_axi_data_awlock),
    .io_in_0_aw_bits_cache  (cpu_axi_data_awcache),
    .io_in_0_aw_bits_qos    (cpu_axi_data_awqos),
    .io_in_0_w_ready        (cpu_axi_data_wready),
    .io_in_0_w_valid        (cpu_axi_data_wvalid),
    .io_in_0_w_bits_data    (cpu_axi_data_wdata),
    .io_in_0_w_bits_strb    (cpu_axi_data_wstrb),
    .io_in_0_w_bits_last    (cpu_axi_data_wlast),
    .io_in_0_b_ready        (cpu_axi_data_bready),
    .io_in_0_b_valid        (cpu_axi_data_bvalid),
    .io_in_0_b_bits_resp    (cpu_axi_data_bresp),
    //.io_in_0_b_bits_id,
    //.io_in_0_b_bits_user,
    .io_in_0_ar_ready       (cpu_axi_data_arready),
    .io_in_0_ar_valid       (cpu_axi_data_arvalid),
    .io_in_0_ar_bits_addr   (cpu_axi_data_araddr),
    .io_in_0_ar_bits_prot   (cpu_axi_data_arprot),
    .io_in_0_ar_bits_id     ('d0),
    //.io_in_0_ar_bits_user,
    .io_in_0_ar_bits_len    (cpu_axi_data_arlen),
    .io_in_0_ar_bits_size   (cpu_axi_data_arsize),
    .io_in_0_ar_bits_burst  (cpu_axi_data_arburst),
    .io_in_0_ar_bits_lock   (cpu_axi_data_arlock),
    .io_in_0_ar_bits_cache  (cpu_axi_data_arcache),
    .io_in_0_ar_bits_qos    (cpu_axi_data_arqos),
    .io_in_0_r_ready        (cpu_axi_data_rready),
    .io_in_0_r_valid        (cpu_axi_data_rvalid),
    .io_in_0_r_bits_resp    (cpu_axi_data_rresp),
    .io_in_0_r_bits_data    (cpu_axi_data_rdata),
    .io_in_0_r_bits_last    (cpu_axi_data_rlast),
    //.io_in_0_r_bits_id,
    //.io_in_0_r_bits_user,
    //.io_in_1_aw_ready,
    .io_in_1_aw_valid       ('d0),
    //.io_in_1_aw_bits_addr,
    //.io_in_1_aw_bits_prot,
    //.io_in_1_aw_bits_id,
    //.io_in_1_aw_bits_user,
    //.io_in_1_aw_bits_len,
    //.io_in_1_aw_bits_size,
    //.io_in_1_aw_bits_burst,
    //.io_in_1_aw_bits_lock,
    //.io_in_1_aw_bits_cache,
    //.io_in_1_aw_bits_qos,
    //.io_in_1_w_ready,
    .io_in_1_w_valid        ('d0),
    //.io_in_1_w_bits_data,
    //.io_in_1_w_bits_strb,
    //.io_in_1_w_bits_last,
    .io_in_1_b_ready        ('d0),
    //.io_in_1_b_valid,
    //.io_in_1_b_bits_resp,
    //.io_in_1_b_bits_id,
    //.io_in_1_b_bits_user,
    .io_in_1_ar_ready       (cpu_axi_inst_arready),
    .io_in_1_ar_valid       (cpu_axi_inst_arvalid),
    .io_in_1_ar_bits_addr   (cpu_axi_inst_araddr),
    .io_in_1_ar_bits_prot   (cpu_axi_inst_arprot),
    .io_in_1_ar_bits_id      ('d1),
    //.io_in_1_ar_bits_user,
    .io_in_1_ar_bits_len    (cpu_axi_inst_arlen),
    .io_in_1_ar_bits_size   (cpu_axi_inst_arsize),
    .io_in_1_ar_bits_burst  (cpu_axi_inst_arburst),
    .io_in_1_ar_bits_lock   (cpu_axi_inst_arlock),
    .io_in_1_ar_bits_cache  (cpu_axi_inst_arcache),
    .io_in_1_ar_bits_qos    (cpu_axi_inst_arqos),
    .io_in_1_r_ready        (cpu_axi_inst_rready),
    .io_in_1_r_valid        (cpu_axi_inst_rvalid),
    .io_in_1_r_bits_resp    (cpu_axi_inst_rresp),
    .io_in_1_r_bits_data    (cpu_axi_inst_rdata),
    .io_in_1_r_bits_last     (cpu_axi_inst_rlast),
    //.io_in_1_r_bits_id        (),
    //.io_in_1_r_bits_user,
    .io_out_0_aw_ready        (axi_hp0_awready),
    .io_out_0_aw_valid        (axi_hp0_awvalid),
    .io_out_0_aw_bits_addr    (axi_hp0_awaddr[31:0]),
    .io_out_0_aw_bits_prot    (axi_hp0_awprot),
    .io_out_0_aw_bits_id      (axi_hp0_awid),
    //.io_out_0_aw_bits_user,
    .io_out_0_aw_bits_len     (axi_hp0_awlen),  
    .io_out_0_aw_bits_size    (axi_hp0_awsize),
    .io_out_0_aw_bits_burst   (axi_hp0_awburst),
    .io_out_0_aw_bits_lock    (axi_hp0_awlock),
    .io_out_0_aw_bits_cache   (axi_hp0_awcache),
    .io_out_0_aw_bits_qos     (axi_hp0_awqos),
    .io_out_0_w_ready         (axi_hp0_wready),
    .io_out_0_w_valid         (axi_hp0_wvalid),
    .io_out_0_w_bits_data     (axi_hp0_wdata[31:0]),
    .io_out_0_w_bits_strb     (axi_hp0_wstrb[3:0]),
    .io_out_0_w_bits_last     (axi_hp0_wlast),
    .io_out_0_b_ready         (axi_hp0_bready),
    .io_out_0_b_valid         (axi_hp0_bvalid),
    .io_out_0_b_bits_resp     (axi_hp0_bresp),
    .io_out_0_b_bits_id       (axi_hp0_bid),
    //.io_out_0_b_bits_user,
    .io_out_0_ar_ready        (axi_hp0_arready),
    .io_out_0_ar_valid        (axi_hp0_arvalid),
    .io_out_0_ar_bits_addr    (axi_hp0_araddr[31:0]),
    .io_out_0_ar_bits_prot    (axi_hp0_arprot),
    .io_out_0_ar_bits_id      (axi_hp0_arid),
    //.io_out_0_ar_bits_user,
    .io_out_0_ar_bits_len     (axi_hp0_arlen),
    .io_out_0_ar_bits_size    (axi_hp0_arsize),
    .io_out_0_ar_bits_burst   (axi_hp0_arburst),
    .io_out_0_ar_bits_lock    (axi_hp0_arlock),
    .io_out_0_ar_bits_cache   (axi_hp0_arcache),
    .io_out_0_ar_bits_qos     (axi_hp0_arqos),
    .io_out_0_r_ready         (axi_hp0_rready),
    .io_out_0_r_valid         (axi_hp0_rvalid),
    .io_out_0_r_bits_resp     (axi_hp0_rresp),
    .io_out_0_r_bits_data     (axi_hp0_rdata[31:0]),
    .io_out_0_r_bits_last     (axi_hp0_rlast),
    .io_out_0_r_bits_id       (axi_hp0_rid)
    //.io_out_0_r_bits_user
  );

cpu_top	u_cpu_top (
  .cpu_axi_data_araddr   (cpu_axi_data_araddr  ),
  .cpu_axi_data_arburst  (cpu_axi_data_arburst ),
  .cpu_axi_data_arcache  (cpu_axi_data_arcache ),
  .cpu_axi_data_arlen    (cpu_axi_data_arlen   ),
  .cpu_axi_data_arlock   (cpu_axi_data_arlock  ),
  .cpu_axi_data_arprot   (cpu_axi_data_arprot  ),
  .cpu_axi_data_arqos    (cpu_axi_data_arqos   ),
  .cpu_axi_data_arready  (cpu_axi_data_arready ),
  .cpu_axi_data_arregion (cpu_axi_data_arregion),
  .cpu_axi_data_arsize   (cpu_axi_data_arsize  ),
  .cpu_axi_data_arvalid  (cpu_axi_data_arvalid ),
  .cpu_axi_data_awaddr   (cpu_axi_data_awaddr  ),
  .cpu_axi_data_awburst  (cpu_axi_data_awburst ),
  .cpu_axi_data_awcache  (cpu_axi_data_awcache ),
  .cpu_axi_data_awlen   (cpu_axi_data_awlen   ),
  .cpu_axi_data_awlock  (cpu_axi_data_awlock  ),
  .cpu_axi_data_awprot  (cpu_axi_data_awprot  ),
  .cpu_axi_data_awqos   (cpu_axi_data_awqos   ),
  .cpu_axi_data_awready (cpu_axi_data_awready ),
  .cpu_axi_data_awregion(cpu_axi_data_awregion),
  .cpu_axi_data_awsize  (cpu_axi_data_awsize  ),
  .cpu_axi_data_awvalid (cpu_axi_data_awvalid ),
   .cpu_axi_data_bready (cpu_axi_data_bready ),
   .cpu_axi_data_bresp  (cpu_axi_data_bresp  ),
   .cpu_axi_data_bvalid (cpu_axi_data_bvalid ),
   .cpu_axi_data_rdata  (cpu_axi_data_rdata  ),
   .cpu_axi_data_rlast  (cpu_axi_data_rlast  ),
   .cpu_axi_data_rready (cpu_axi_data_rready ),
   .cpu_axi_data_rresp  (cpu_axi_data_rresp  ),
   .cpu_axi_data_rvalid (cpu_axi_data_rvalid ),
   .cpu_axi_data_wdata  (cpu_axi_data_wdata  ),
   .cpu_axi_data_wlast  (cpu_axi_data_wlast  ),
   .cpu_axi_data_wready (cpu_axi_data_wready ),
   .cpu_axi_data_wstrb  (cpu_axi_data_wstrb  ),
   .cpu_axi_data_wvalid (cpu_axi_data_wvalid ),
   .cpu_axi_inst_araddr (cpu_axi_inst_araddr ),
   .cpu_axi_inst_arburst(cpu_axi_inst_arburst),
   .cpu_axi_inst_arcache(cpu_axi_inst_arcache),
   .cpu_axi_inst_arlen  (cpu_axi_inst_arlen  ),
   .cpu_axi_inst_arlock  (cpu_axi_inst_arlock  ),
   .cpu_axi_inst_arprot  (cpu_axi_inst_arprot  ),
   .cpu_axi_inst_arqos   (cpu_axi_inst_arqos   ),
   .cpu_axi_inst_arready (cpu_axi_inst_arready ),
   .cpu_axi_inst_arregion(cpu_axi_inst_arregion),
   .cpu_axi_inst_arsize  (cpu_axi_inst_arsize  ),
   .cpu_axi_inst_arvalid (cpu_axi_inst_arvalid ),
   .cpu_axi_inst_rdata   (cpu_axi_inst_rdata   ),
   .cpu_axi_inst_rlast   (cpu_axi_inst_rlast   ),
   .cpu_axi_inst_rready  (cpu_axi_inst_rready  ),
   .cpu_axi_inst_rresp   (cpu_axi_inst_rresp   ),
   .cpu_axi_inst_rvalid  (cpu_axi_inst_rvalid  ),
   .cpu_axi_mmio_araddr  (cpu_axi_mmio_araddr  ),
   .cpu_axi_mmio_arprot  (cpu_axi_mmio_arprot  ),
   .cpu_axi_mmio_arready (cpu_axi_mmio_arready ),
   .cpu_axi_mmio_arvalid (cpu_axi_mmio_arvalid ),
   .cpu_axi_mmio_awaddr  (cpu_axi_mmio_awaddr  ),
   .cpu_axi_mmio_awprot  (cpu_axi_mmio_awprot  ),
   .cpu_axi_mmio_awready (cpu_axi_mmio_awready ),
   .cpu_axi_mmio_awvalid (cpu_axi_mmio_awvalid ),
   .cpu_axi_mmio_bready  (cpu_axi_mmio_bready  ),
   .cpu_axi_mmio_bresp   (cpu_axi_mmio_bresp   ),
   .cpu_axi_mmio_bvalid  (cpu_axi_mmio_bvalid  ),
   .cpu_axi_mmio_rdata   (cpu_axi_mmio_rdata   ),
   .cpu_axi_mmio_rready  (cpu_axi_mmio_rready  ),
   .cpu_axi_mmio_rresp   (cpu_axi_mmio_rresp   ),
   .cpu_axi_mmio_rvalid  (cpu_axi_mmio_rvalid  ),
   .cpu_axi_mmio_wdata   (cpu_axi_mmio_wdata   ),
   .cpu_axi_mmio_wready  (cpu_axi_mmio_wready  ),
   .cpu_axi_mmio_wstrb   (cpu_axi_mmio_wstrb   ),
   .cpu_axi_mmio_wvalid  (cpu_axi_mmio_wvalid  ),
   .cpu_axi_uart_araddr  (cpu_axi_uart_araddr  ),
   .cpu_axi_uart_arprot  (cpu_axi_uart_arprot  ),
   .cpu_axi_uart_arready (cpu_axi_uart_arready ),
   .cpu_axi_uart_arvalid (cpu_axi_uart_arvalid ),
   .cpu_axi_uart_awaddr  (cpu_axi_uart_awaddr  ),
   .cpu_axi_uart_awprot  (cpu_axi_uart_awprot  ),
   .cpu_axi_uart_awready (cpu_axi_uart_awready ),
   .cpu_axi_uart_awvalid (cpu_axi_uart_awvalid ),
   .cpu_axi_uart_bready  (cpu_axi_uart_bready  ),
   .cpu_axi_uart_bresp   (cpu_axi_uart_bresp   ),
   .cpu_axi_uart_bvalid  (cpu_axi_uart_bvalid  ),
   .cpu_axi_uart_rdata   (cpu_axi_uart_rdata   ),
   .cpu_axi_uart_rready  (cpu_axi_uart_rready  ),
   .cpu_axi_uart_rresp   (cpu_axi_uart_rresp   ),
   .cpu_axi_uart_rvalid  (cpu_axi_uart_rvalid  ),
   .cpu_axi_uart_wdata   (cpu_axi_uart_wdata   ),
   .cpu_axi_uart_wready  (cpu_axi_uart_wready  ),
   .cpu_axi_uart_wstrb   (cpu_axi_uart_wstrb   ),
   .cpu_axi_uart_wvalid  (cpu_axi_uart_wvalid  ),
   .system_reset_n  (system_reset_n),
   .sys_port_reset_n  (sys_port_reset_n),
   .system_clk (system_clk)
);

 endmodule
