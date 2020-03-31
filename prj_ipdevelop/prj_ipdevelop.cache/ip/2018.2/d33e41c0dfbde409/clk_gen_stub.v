// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Tue Mar 31 08:24:15 2020
// Host        : VT2OB6D7ZB52FZ0 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ clk_gen_stub.v
// Design      : clk_gen
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clkfb_in, clk1_f2, clk2_shd, clk3_shp, clk4_rs, 
  clk5_cp, clkfb_out, resetn, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clkfb_in,clk1_f2,clk2_shd,clk3_shp,clk4_rs,clk5_cp,clkfb_out,resetn,clk_in1" */;
  input clkfb_in;
  output clk1_f2;
  output clk2_shd;
  output clk3_shp;
  output clk4_rs;
  output clk5_cp;
  output clkfb_out;
  input resetn;
  input clk_in1;
endmodule
