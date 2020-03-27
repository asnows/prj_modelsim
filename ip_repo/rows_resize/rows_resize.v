// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Fri Mar 27 08:36:47 2020
// Host        : VT2OB6D7ZB52FZ0 running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub e:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/rows_resize/rows_resize.v
//               -force
// Design      : rows_resize
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module rows_resize(pixel_clk, rows_size, s_axis_tdata, 
  s_axis_tlast, s_axis_tuser, s_axis_tvalid, m_axis_tlast, m_axis_tuser, m_axis_tvalid, 
  m_axis_tdata)
/* synthesis syn_black_box black_box_pad_pin="pixel_clk,rows_size[11:0],s_axis_tdata[7:0],s_axis_tlast,s_axis_tuser,s_axis_tvalid,m_axis_tlast,m_axis_tuser,m_axis_tvalid,m_axis_tdata[7:0]" */;
  input pixel_clk;
  input [11:0]rows_size;
  input [7:0]s_axis_tdata;
  input s_axis_tlast;
  input s_axis_tuser;
  input s_axis_tvalid;
  output m_axis_tlast;
  output m_axis_tuser;
  output m_axis_tvalid;
  output [7:0]m_axis_tdata;
endmodule
