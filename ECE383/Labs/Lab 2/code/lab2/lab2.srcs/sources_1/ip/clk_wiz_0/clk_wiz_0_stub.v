// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Thu Feb  8 10:51:20 2018
// Host        : c19mademore running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab
//               2/lab2/lab2.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v}
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_out1, clk_out2, clk_out3, resetn, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,clk_out2,clk_out3,resetn,clk_in1" */;
  output clk_out1;
  output clk_out2;
  output clk_out3;
  input resetn;
  input clk_in1;
endmodule
