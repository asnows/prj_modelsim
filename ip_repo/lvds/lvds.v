// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Fri Dec 20 14:18:10 2019
// Host        : VT2OB6D7ZB52FZ0 running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub E:/WorkSpace/project/FPGA/prj_modelsim/ip_repo/lvds/lvds.v -force
// Design      : lvds
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module lvds(clrl_refclk, reset, bit_align_en, bitslip_en, 
  rx_clkin_p, rx_clkin_n, datain_p, datain_n, pattern, tx_data, tx_clkdiv, tx_clk_p, tx_clk_n, 
  dataout_p, dataout_n, rx_data_clk, rx_data)
/* synthesis syn_black_box black_box_pad_pin="clrl_refclk,reset,bit_align_en,bitslip_en,rx_clkin_p,rx_clkin_n,datain_p[0:0],datain_n[0:0],pattern[7:0],tx_data[7:0],tx_clkdiv,tx_clk_p,tx_clk_n,dataout_p[0:0],dataout_n[0:0],rx_data_clk,rx_data[7:0]" */;
  input clrl_refclk;
  input reset;
  input bit_align_en;
  input bitslip_en;
  input rx_clkin_p;
  input rx_clkin_n;
  input [0:0]datain_p;
  input [0:0]datain_n;
  input [7:0]pattern;
  input [7:0]tx_data;
  output tx_clkdiv;
  output tx_clk_p;
  output tx_clk_n;
  output [0:0]dataout_p;
  output [0:0]dataout_n;
  output rx_data_clk;
  output [7:0]rx_data;
endmodule
