-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
-- Date        : Wed Apr 25 09:58:17 2018
-- Host        : c19mademore running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Final
--               Project/code/fpgaKaraoke/fpgaKaraoke.srcs/sources_1/ip/dft_0/dft_0_stub.vhdl}
-- Design      : dft_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tsbg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dft_0 is
  Port ( 
    CLK : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    XN_RE : in STD_LOGIC_VECTOR ( 17 downto 0 );
    XN_IM : in STD_LOGIC_VECTOR ( 17 downto 0 );
    FD_IN : in STD_LOGIC;
    FWD_INV : in STD_LOGIC;
    SIZE : in STD_LOGIC_VECTOR ( 5 downto 0 );
    RFFD : out STD_LOGIC;
    XK_RE : out STD_LOGIC_VECTOR ( 17 downto 0 );
    XK_IM : out STD_LOGIC_VECTOR ( 17 downto 0 );
    BLK_EXP : out STD_LOGIC_VECTOR ( 3 downto 0 );
    FD_OUT : out STD_LOGIC;
    DATA_VALID : out STD_LOGIC
  );

end dft_0;

architecture stub of dft_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK,SCLR,XN_RE[17:0],XN_IM[17:0],FD_IN,FWD_INV,SIZE[5:0],RFFD,XK_RE[17:0],XK_IM[17:0],BLK_EXP[3:0],FD_OUT,DATA_VALID";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dft_v4_0_14,Vivado 2017.3";
begin
end;
