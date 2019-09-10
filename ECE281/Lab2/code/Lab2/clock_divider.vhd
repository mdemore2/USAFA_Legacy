----------------------------------------------------------------------------------
-- Name:	Mark Demore II (file provided)
-- Date:	Spring 2017
-- Course: ECE 281
-- File: clock_divider.vhd
-- HW:	Lab 2
-- Purp:	FSM for 1965 Ford Thunderbird tail lights, create component to slow down on-board clock of FPGA
-- Doc:	None
-- Academic Integrity Statement: I certify that, while others may have 
-- assisted me in brain storming, debugging and validating this program, 
-- the program itself is my own work. I understand that submitting code 
-- which is the work of other individuals is a violation of the honor   
-- code.  I also understand that if I knowingly give my original work to 
-- another individual is also a violation of the honor code. 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_divider is
	port(
		i_clk    : in std_logic;
		i_reset  : in std_logic;
		o_clk    : out std_logic
	);
end clock_divider;

architecture horrible_method of clock_divider is
	signal clk_bus : unsigned(23 downto 0);
begin

	process (i_clk, i_reset) is
	begin
		if i_reset = '1' then
			clk_bus <= (others => '0');
		elsif rising_edge(i_clk) then
			clk_bus <= clk_bus + 1;
		end if;
	end process;
	
	o_clk <= clk_bus(23);
end horrible_method;