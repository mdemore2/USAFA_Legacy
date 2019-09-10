--------------------------------------------------------------------
-- Name:	C2C Mark Demore II
-- Date:	1 Feb 2018
-- Course:	ECE383
-- File:	counter.vhd
-- HW:		HW7
--
-- Purp: Counter from lec10
--
-- Doc:	None
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
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
	generic (N: integer := 4);
	Port(	clk: in  STD_LOGIC;
			reset : in  STD_LOGIC;
			ctrl: in std_logic_vector(1 downto 0);
			D: in unsigned (N-1 downto 0);
			Q: out unsigned (N-1 downto 0));
end counter;

architecture behavior of counter is
	
	signal processQ: unsigned (N-1 downto 0):= "0000";

begin
	
	
	-----------------------------------------------------------------------------
	--		crtl
	--		00			hold
	--		01			count up mod 10
	--		10			load D
	--		11			synch reset
	-----------------------------------------------------------------------------
	process(clk)
	--process(ctrl)
	begin
		if (rising_edge(clk)) then
			if (reset = '0') then
				processQ <= (others => '0');
			elsif (ctrl = "01") then
				processQ <= processQ + 1;
			elsif (ctrl = "10") then
				processQ <= unsigned(D);
			elsif (ctrl = "11") then
				processQ <= (others => '0');
			end if;
		end if;
	end process;
 
	Q <= processQ;
	
end behavior;