--------------------------------------------------------------------
-- Name:	C2C Mark Demore II
-- Date:	1 Feb 2018
-- Course:	ECE383
-- File:	hw7_tb.vhd
-- HW:		HW7
--
-- Purp:FSM for 2 button debouncing
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
USE ieee.numeric_std.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hw7_tb is
--  Port ( );
end hw7_tb;

architecture Behavioral of hw7_tb is

COMPONENT  hw7 is
		Port (clk: in std_logic;
            reset: in std_logic;
            L: in std_logic;
            R: in std_logic;
            count: out unsigned(3 downto 0));
    END COMPONENT;
    
   signal clk : std_logic := '0';
   signal reset : std_logic := '1';
   signal L,R: std_logic:= '0';
   signal count: unsigned(3 downto 0):="0000";
	

   -- Clock period definitions
   constant clk_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: hw7 PORT MAP (
          clk => clk,
          reset => reset,
          L => L,
          R => R,
          count => count);

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
 
 	L <= '0','1' after 10ns, '0' after 20ns, '1' after 30ns, '0' after 40ns, '1' after 90ns, '0' after 100ns;
 	R <= '0', '1' after 50ns, '0' after 60ns, '1' after 70ns, '0' after 80ns, '1' after 110ns, '0' after 120ns;
	

	--reset <= '0', '1' after 1us;


end Behavioral;
