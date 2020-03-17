// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Tue Mar 17 16:36:51 2020
// Host        : VT2OB6D7ZB52FZ0 running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub e:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/TCD1209D/TCD1209D.v
// Design      : TCD1209D
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module TCD1209D(sys_clk, f1_cnt, sh, f1, f2, f2b, rs, cp, Oper, Ctrl, Clamp, 
  VGA_Gain, cfg_en, SDATA, SCK, SL, SHP, SHD, DATACLK, CLPOB, PBLK, DATA_IN, tdata, tvalid)
/* synthesis syn_black_box black_box_pad_pin="sys_clk,f1_cnt[9:0],sh,f1,f2,f2b,rs,cp,Oper[6:0],Ctrl[6:0],Clamp[7:0],VGA_Gain[9:0],cfg_en,SDATA,SCK,SL,SHP,SHD,DATACLK,CLPOB,PBLK,DATA_IN[11:0],tdata[11:0],tvalid" */;
  input sys_clk;
  input [9:0]f1_cnt;
  output sh;
  output f1;
  output f2;
  output f2b;
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
  output [11:0]tdata;
  output tvalid;
endmodule
