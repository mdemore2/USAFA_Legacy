	--------------------------------------------------------------------
	-- Name:		Mark Demore
	-- Date:		15 Feb 2017
	-- Course:	ECE281
	-- File:		alu.vhd
	-- HW:		CE3
	--
	-- Purp:		This program describes a 32-bit ALU.
	--
	-- Doc:		Debugging assisted by C3C's McFadden and Do
	--
	-- Academic Integrity Statement: I certify that, while others may have 
	-- assisted me in brain storming, debugging and validating this program, 
	-- the program itself is my own work. I understand that submitting code 
	-- which is the work of other individuals is a violation of the honor   
	-- code.  I also understand that if I knowingly give my original work to 
	-- another individual is also a violation of the honor code. 
	------------------------------------------------------------------------- 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
	port(
		a, b : in std_logic_vector(31 downto 0);
		alucontrol    : in std_logic_vector(2 downto 0);
		result    : out std_logic_vector(31 downto 0);
		zero : out std_logic
	);
end alu;


architecture alu of alu is

--signal b_not 			: std_logic_vector(31 downto 0)	:= not b(31 downto 0);
--signal b_mux 			: std_logic_vector(31 downto 0)	:= x"00000000";
--signal inter_and 		: std_logic_vector(31 downto 0)	:= x"00000000";
--signal inter_or 		: std_logic_vector(31 downto 0)	:= x"00000000";
--signal adder_out 		: std_logic_vector(31 downto 0)	:= x"00000000";
--signal extender_out	: std_logic_vector(31 downto 0)	:= x"00000000";
signal y_wire			: std_logic_vector(31 downto 0)	:= x"00000000";



begin

--b_mux 			<= b_not when (f(2) = '1')
--						else b;
--inter_and 		<= b_mux and a;
--inter_or 		<= b_mux or a;
--adder_out		<= a + b + f(2);
--extender_out	<= x"0000000" & "000" & adder_out(31);
--
--y_wire			<= inter_and when (f(1) = '0' and f(0) = '0');
--y_wire			<= inter_or when (f(1) = '0' and f(0) = '1');	not sure why this commented method wasn't working, so used simplified version below
--y_wire			<= adder_out when (f(1) = '1' and f(0) = '0');
--y_wire			<= extender_out when (f(1) = '1' and f(0) = '1');
--
--y					<= y_wire;
--zero				<= '1' when (y_wire = x"00000000")
--						else '0';

result <= y_wire;
zero <= '1' when (y_wire = x"00000000")
					else '0';
					
y_wire <= (a and b) when alucontrol="000" else
			 (a or b) when alucontrol="001" else
			 (a + b) when alucontrol="010" else
			 (a and not b) when alucontrol="100" else
			 (a or not b) when alucontrol="101" else
			 (a - b) when alucontrol="110" else
			 x"00000001" when alucontrol="111" and (a < b) else
			 x"00000000";

end alu;

