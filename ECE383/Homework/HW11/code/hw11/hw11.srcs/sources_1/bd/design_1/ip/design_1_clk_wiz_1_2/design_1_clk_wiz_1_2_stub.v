// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Wed Feb 28 11:08:38 2018
// Host        : c19mademore running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Homework/HW11/hw11/hw11.srcs/sources_1/bd/design_1/ip/design_1_clk_wiz_1_2/design_1_clk_wiz_1_2_stub.v
// Design      : design_1_clk_wiz_1_2
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module design_1_clk_wiz_1_2(clk_out1, clk_out2, resetn, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,clk_out2,resetn,locked,clk_in1" */;
  output clk_out1;
  output clk_out2;
  input resetn;
  output locked;
  input clk_in1;
endmodule
