-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
-- Date        : Wed Feb 21 11:00:51 2018
-- Host        : c19mademore running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson
--               Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_clk_wiz_1_2/design_1_clk_wiz_1_2_stub.vhdl}
-- Design      : design_1_clk_wiz_1_2
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tsbg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_clk_wiz_1_2 is
  Port ( 
    clk_out1 : out STD_LOGIC;
    clk_out2 : out STD_LOGIC;
    resetn : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end design_1_clk_wiz_1_2;

architecture stub of design_1_clk_wiz_1_2 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,clk_out2,resetn,locked,clk_in1";
begin
end;
