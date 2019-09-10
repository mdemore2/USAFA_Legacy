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

entity hw4 is
        port(	clk, reset: in std_logic; 
		ctrl: in std_logic;
		Q1, Q0: out unsigned(2 downto 0));
end hw4;




architecture Behavioral of hw4 is
    signal rollover,rollNull: std_logic;
    --signal Q_1: unsigned(2 downto 0);

    component counter is
            port( clk, reset, ctrl: in std_logic;
                roll: out std_logic;
                Q: out unsigned(2 downto 0));
    end component;

begin
    count1: counter 
        port map(
        clk => clk,
         reset => reset, 
         ctrl => ctrl,
          roll => rollover,
           Q => Q0);
           
    count2: counter 
        port map(
            clk => clk,
            reset => reset,
            ctrl => rollover,
            roll => rollNull,
            Q => Q1);
    
    
end Behavioral;
