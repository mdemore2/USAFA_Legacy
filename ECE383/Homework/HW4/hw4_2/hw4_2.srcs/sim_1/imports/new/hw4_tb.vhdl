--------------------------------------------------------------------
-- Name:	Mark Demore
-- Date:	16 Jan 2018
-- Course:	ECE383
-- File:	hw4.vhd
-- HW:		HW4
--
-- Purp:A brief description of what this program does and 
--	the general solution strategy. 
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

entity hw4_tb is
 -- Port ( );
end hw4_tb;

architecture Behavioral2 of hw4_tb is

component hw4 is
        port(	clk, reset: in std_logic; 
		ctrl: in std_logic;
		Q1, Q0: out unsigned(2 downto 0));
end component;

    signal clk, reset : std_logic;
    signal Q0, Q1: unsigned(2 downto 0);
    
    constant clk_period : time := 10 ns;

begin

    uut: hw4 port map(
        clk =>clk,
        reset => reset,
        ctrl => '1',
        Q1 => Q1,
        Q0 => Q0);
        
    clk_process: process
          begin
               clk <= '0';
               wait for clk_period/2;
               clk <= '1';
               wait for clk_period/2;
          end process;
        
          reset <= '0', '1' after 30nS;

end Behavioral2;
