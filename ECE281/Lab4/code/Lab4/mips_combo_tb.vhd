-- HDL Example 7.12 (MIPS TESTBENCH) on pg 438 of 
-- Digital Design and Computer Architecture, 2nd Edition
-- by Harris & Harris, 2013
-- 
-- This simple testbench tests a single-cycle MIPS processor.
-- The processor is reset and then run on a clock in order to execute
-- a desired machine code program loaded into instruction memory 
-- via a .dat file.
--
-- Last modified 4/2017 by Capt Phillip Warner to work with 
-- mips_combo.vhd file for ECE 281 Lab 4.

library IEEE;
use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity testbench is
end;

architecture test of testbench is
 component top
  port(clk, reset:     	 in STD_LOGIC;
     writedata, dataadr: inout STD_LOGIC_VECTOR(31 downto 0);
     memwrite:      	 inout STD_LOGIC);
 end component;
 signal writedata, dataadr:  STD_LOGIC_VECTOR(31 downto 0);
 signal clk, reset, memwrite: STD_LOGIC;
begin

 -- instantiate device to be tested
 dut: top port map(clk, reset, writedata, dataadr, memwrite);
 -- Generate clock with 10 ns period
 process begin
   clk <= '1';
   wait for 5 ns;
   clk <= '0';
   wait for 5 ns;
 end process;

 -- Generate reset for first two clock cycles
 process begin
   reset <= '1';
   wait for 22 ns;
   reset <= '0';
   wait;
 end process;

 
 -- Self check not required.  Must be edited to use.
 
 -- check that 7 gets written to address 84 at end of program
 -- process(clk) begin
   -- if (rising_edge(clk) and memwrite = '1') then
    -- if (to_integer(dataadr) = 84 and to_integer (writedata) = 7) then
     -- report "NO ERRORS: Simulation succeeded" severity failure;
    -- elsif (dataadr /= 80) then
     -- report "Simulation failed" severity failure;
    -- end if;
  -- end if;
 -- end process;

 end;