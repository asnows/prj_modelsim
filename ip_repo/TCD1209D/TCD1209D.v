// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Thu Apr  2 10:53:48 2020
// Host        : VT2OB6D7ZB52FZ0 running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub e:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/TCD1209D/TCD1209D.v -force
// Design      : TCD1209D
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module TCD1209D(sys_clk, triggerMode, extTrigger, f_cnt, f2_freq, 
  sh, f1, f2, rs, cp, Oper, Ctrl, Clamp, VGA_Gain, cfg_en, SDATA, SCK, SL, SHP, SHD, DATACLK, CLPOB, PBLK, DATA_IN, rows, 
  m_axis_tdata, m_axis_tlast, m_axis_tuser, m_axis_tvalid, m_axis_tready, m_axis_aclk)
/* synthesis syn_black_box black_box_pad_pin="sys_clk,triggerMode,extTrigger,f_cnt[24:0],f2_freq[7:0],sh,f1,f2,rs,cp,Oper[6:0],Ctrl[6:0],Clamp[7:0],VGA_Gain[9:0],cfg_en,SDATA,SCK,SL,SHP,SHD,DATACLK,CLPOB,PBLK,DATA_IN[11:0],rows[10:0],m_axis_tdata[7:0],m_axis_tlast,m_axis_tuser,m_axis_tvalid,m_axis_tready,m_axis_aclk" */;
  input sys_clk;
  input triggerMode;
  input extTrigger;
  input [24:0]f_cnt;
  input [7:0]f2_freq;
  output sh;
  output f1;
  output f2;
  output rs;
  output cp;
  input [6:0]Oper;
  input [6:0]Ctrl;
  input [7:0]Clamp;
  input [9:0]VGA_Gain;
  input cfg_en;
  output SDATA;
  output SCK;
  output SL;
  output SHP;
  output SHD;
  output DATACLK;
  output CLPOB;
  output PBLK;
  input [11:0]DATA_IN;
  input [10:0]rows;
  output [7:0]m_axis_tdata;
  output m_axis_tlast;
  output m_axis_tuser;
  output m_axis_tvalid;
  input m_axis_tready;
  output m_axis_aclk;
endmodule
