// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Wed Apr 25 09:58:17 2018
// Host        : c19mademore running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Final
//               Project/code/fpgaKaraoke/fpgaKaraoke.srcs/sources_1/ip/dft_0/dft_0_stub.v}
// Design      : dft_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dft_v4_0_14,Vivado 2017.3" *)
module dft_0(CLK, SCLR, XN_RE, XN_IM, FD_IN, FWD_INV, SIZE, RFFD, 
  XK_RE, XK_IM, BLK_EXP, FD_OUT, DATA_VALID)
/* synthesis syn_black_box black_box_pad_pin="CLK,SCLR,XN_RE[17:0],XN_IM[17:0],FD_IN,FWD_INV,SIZE[5:0],RFFD,XK_RE[17:0],XK_IM[17:0],BLK_EXP[3:0],FD_OUT,DATA_VALID" */;
  input CLK;
  input SCLR;
  input [17:0]XN_RE;
  input [17:0]XN_IM;
  input FD_IN;
  input FWD_INV;
  input [5:0]SIZE;
  output RFFD;
  output [17:0]XK_RE;
  output [17:0]XK_IM;
  output [3:0]BLK_EXP;
  output FD_OUT;
  output DATA_VALID;
endmodule
