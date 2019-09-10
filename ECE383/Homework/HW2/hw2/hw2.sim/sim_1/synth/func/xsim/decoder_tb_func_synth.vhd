-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
-- Date        : Tue Jan  9 11:01:41 2018
-- Host        : c19mademore running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Homework/HW2/hw2/hw2.sim/sim_1/synth/func/xsim/decoder_tb_func_synth.vhd
-- Design      : scancodeDecoder
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a200tsbg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity scancodeDecoder is
  port (
    D : in STD_LOGIC_VECTOR ( 7 downto 0 );
    H : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of scancodeDecoder : entity is true;
end scancodeDecoder;

architecture STRUCTURE of scancodeDecoder is
  signal D_IBUF : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal H_OBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \H_OBUF[0]_inst_i_2_n_0\ : STD_LOGIC;
  signal \H_OBUF[1]_inst_i_2_n_0\ : STD_LOGIC;
  signal \H_OBUF[2]_inst_i_2_n_0\ : STD_LOGIC;
  signal \H_OBUF[3]_inst_i_2_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \H_OBUF[0]_inst_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \H_OBUF[1]_inst_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \H_OBUF[2]_inst_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \H_OBUF[3]_inst_i_1\ : label is "soft_lutpair0";
begin
\D_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => D(0),
      O => D_IBUF(0)
    );
\D_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => D(1),
      O => D_IBUF(1)
    );
\D_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => D(2),
      O => D_IBUF(2)
    );
\D_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => D(3),
      O => D_IBUF(3)
    );
\D_IBUF[4]_inst\: unisim.vcomponents.IBUF
     port map (
      I => D(4),
      O => D_IBUF(4)
    );
\D_IBUF[5]_inst\: unisim.vcomponents.IBUF
     port map (
      I => D(5),
      O => D_IBUF(5)
    );
\D_IBUF[6]_inst\: unisim.vcomponents.IBUF
     port map (
      I => D(6),
      O => D_IBUF(6)
    );
\D_IBUF[7]_inst\: unisim.vcomponents.IBUF
     port map (
      I => D(7),
      O => D_IBUF(7)
    );
\H_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => H_OBUF(0),
      O => H(0)
    );
\H_OBUF[0]_inst_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
        port map (
      I0 => D_IBUF(2),
      I1 => \H_OBUF[0]_inst_i_2_n_0\,
      I2 => D_IBUF(7),
      O => H_OBUF(0)
    );
\H_OBUF[0]_inst_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFEEFFF37FFFF"
    )
        port map (
      I0 => D_IBUF(3),
      I1 => D_IBUF(4),
      I2 => D_IBUF(5),
      I3 => D_IBUF(6),
      I4 => D_IBUF(1),
      I5 => D_IBUF(0),
      O => \H_OBUF[0]_inst_i_2_n_0\
    );
\H_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => H_OBUF(1),
      O => H(1)
    );
\H_OBUF[1]_inst_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
        port map (
      I0 => D_IBUF(2),
      I1 => \H_OBUF[1]_inst_i_2_n_0\,
      I2 => D_IBUF(7),
      O => H_OBUF(1)
    );
\H_OBUF[1]_inst_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFEFEFFFF5BEFFF"
    )
        port map (
      I0 => D_IBUF(3),
      I1 => D_IBUF(4),
      I2 => D_IBUF(5),
      I3 => D_IBUF(0),
      I4 => D_IBUF(1),
      I5 => D_IBUF(6),
      O => \H_OBUF[1]_inst_i_2_n_0\
    );
\H_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => H_OBUF(2),
      O => H(2)
    );
\H_OBUF[2]_inst_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
        port map (
      I0 => D_IBUF(2),
      I1 => \H_OBUF[2]_inst_i_2_n_0\,
      I2 => D_IBUF(7),
      O => H_OBUF(2)
    );
\H_OBUF[2]_inst_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFEFEFFFF63FFFF"
    )
        port map (
      I0 => D_IBUF(3),
      I1 => D_IBUF(4),
      I2 => D_IBUF(5),
      I3 => D_IBUF(0),
      I4 => D_IBUF(1),
      I5 => D_IBUF(6),
      O => \H_OBUF[2]_inst_i_2_n_0\
    );
\H_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => H_OBUF(3),
      O => H(3)
    );
\H_OBUF[3]_inst_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
        port map (
      I0 => D_IBUF(2),
      I1 => \H_OBUF[3]_inst_i_2_n_0\,
      I2 => D_IBUF(7),
      O => H_OBUF(3)
    );
\H_OBUF[3]_inst_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFE6FFF83FFFF"
    )
        port map (
      I0 => D_IBUF(3),
      I1 => D_IBUF(4),
      I2 => D_IBUF(5),
      I3 => D_IBUF(6),
      I4 => D_IBUF(1),
      I5 => D_IBUF(0),
      O => \H_OBUF[3]_inst_i_2_n_0\
    );
end STRUCTURE;
