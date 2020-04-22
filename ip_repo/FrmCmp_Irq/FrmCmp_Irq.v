// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Wed Apr  8 16:39:17 2020
// Host        : VT2OB6D7ZB52FZ0 running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub e:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/FrmCmp_Irq/FrmCmp_Irq.v
// Design      : FrmCmp_Irq
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module FrmCmp_Irq(s_axis_aclk, s_axis_tlast, s_axis_tuser, 
  img_vsize, FrmCmp_Irq)
/* synthesis syn_black_box black_box_pad_pin="s_axis_aclk,s_axis_tlast,s_axis_tuser,img_vsize[11:0],FrmCmp_Irq" */;
  input s_axis_aclk;
  input s_axis_tlast;
  input s_axis_tuser;
  input [11:0]img_vsize;
  output FrmCmp_Irq;
endmodule
