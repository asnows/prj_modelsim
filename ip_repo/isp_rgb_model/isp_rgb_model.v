// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sat Apr 18 11:42:22 2020
// Host        : VT2OB6D7ZB52FZ0 running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub
//               e:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/isp_rgb_model/isp_rgb_model.v -force
// Design      : isp_rgb_model
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module isp_rgb_model(pixel_clk, s_axis_tdata, s_axis_tlast, 
  s_axis_tready, s_axis_tuser, s_axis_tvalid, debug_cmd, bayerType, m_axis_tlast, 
  m_axis_tready, m_axis_tuser, m_axis_tvalid, m_axis_tdata)
/* synthesis syn_black_box black_box_pad_pin="pixel_clk,s_axis_tdata[7:0],s_axis_tlast,s_axis_tready,s_axis_tuser,s_axis_tvalid,debug_cmd[3:0],bayerType[1:0],m_axis_tlast,m_axis_tready,m_axis_tuser,m_axis_tvalid,m_axis_tdata[23:0]" */;
  input pixel_clk;
  input [7:0]s_axis_tdata;
  input s_axis_tlast;
  output s_axis_tready;
  input s_axis_tuser;
  input s_axis_tvalid;
  input [3:0]debug_cmd;
  input [1:0]bayerType;
  output m_axis_tlast;
  input m_axis_tready;
  output m_axis_tuser;
  output m_axis_tvalid;
  output [23:0]m_axis_tdata;
endmodule
