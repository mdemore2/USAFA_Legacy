--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
--Date        : Mon Mar 19 11:05:39 2018
--Host        : c19mademore running 64-bit Service Pack 1  (build 7601)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    DDR3_0_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR3_0_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR3_0_cas_n : out STD_LOGIC;
    DDR3_0_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_0_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR3_0_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_0_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_0_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_ras_n : out STD_LOGIC;
    DDR3_0_reset_n : out STD_LOGIC;
    DDR3_0_we_n : out STD_LOGIC;
    ac_adc_sdata : in STD_LOGIC;
    ac_bclk : out STD_LOGIC;
    ac_dac_sdata : out STD_LOGIC;
    ac_lrclk : out STD_LOGIC;
    ac_mclk : out STD_LOGIC;
    reset : in STD_LOGIC;
    scl : inout STD_LOGIC;
    sda : inout STD_LOGIC;
    sys_clock : in STD_LOGIC;
    tmds : out STD_LOGIC_VECTOR ( 3 downto 0 );
    tmdsb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC;
    DDR3_0_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR3_0_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_0_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_0_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR3_0_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR3_0_ras_n : out STD_LOGIC;
    DDR3_0_cas_n : out STD_LOGIC;
    DDR3_0_we_n : out STD_LOGIC;
    DDR3_0_reset_n : out STD_LOGIC;
    DDR3_0_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_0_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    reset : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    ac_adc_sdata : in STD_LOGIC;
    ac_mclk : out STD_LOGIC;
    ac_dac_sdata : out STD_LOGIC;
    ac_bclk : out STD_LOGIC;
    ac_lrclk : out STD_LOGIC;
    scl : inout STD_LOGIC;
    sda : inout STD_LOGIC;
    tmds : out STD_LOGIC_VECTOR ( 3 downto 0 );
    tmdsb : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      DDR3_0_addr(14 downto 0) => DDR3_0_addr(14 downto 0),
      DDR3_0_ba(2 downto 0) => DDR3_0_ba(2 downto 0),
      DDR3_0_cas_n => DDR3_0_cas_n,
      DDR3_0_ck_n(0) => DDR3_0_ck_n(0),
      DDR3_0_ck_p(0) => DDR3_0_ck_p(0),
      DDR3_0_cke(0) => DDR3_0_cke(0),
      DDR3_0_dm(1 downto 0) => DDR3_0_dm(1 downto 0),
      DDR3_0_dq(15 downto 0) => DDR3_0_dq(15 downto 0),
      DDR3_0_dqs_n(1 downto 0) => DDR3_0_dqs_n(1 downto 0),
      DDR3_0_dqs_p(1 downto 0) => DDR3_0_dqs_p(1 downto 0),
      DDR3_0_odt(0) => DDR3_0_odt(0),
      DDR3_0_ras_n => DDR3_0_ras_n,
      DDR3_0_reset_n => DDR3_0_reset_n,
      DDR3_0_we_n => DDR3_0_we_n,
      ac_adc_sdata => ac_adc_sdata,
      ac_bclk => ac_bclk,
      ac_dac_sdata => ac_dac_sdata,
      ac_lrclk => ac_lrclk,
      ac_mclk => ac_mclk,
      reset => reset,
      scl => scl,
      sda => sda,
      sys_clock => sys_clock,
      tmds(3 downto 0) => tmds(3 downto 0),
      tmdsb(3 downto 0) => tmdsb(3 downto 0),
      usb_uart_rxd => usb_uart_rxd,
      usb_uart_txd => usb_uart_txd
    );
end STRUCTURE;
