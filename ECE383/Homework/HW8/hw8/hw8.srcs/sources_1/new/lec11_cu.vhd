--------------------------------------------------------------------
-- Name:	C2C Mark Demore II
-- Date:	2 Feb 2018
-- Course:	ECE383
-- File:	lec11_cu.vhd
-- HW:		HW8
--
-- Purp: I have no purpose.
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lec11_cu is
    Port (clk: in  STD_LOGIC;
			reset : in  STD_LOGIC;
			kbClk: in std_logic;
			cw: out STD_LOGIC_VECTOR(2 downto 0);
			sw: in STD_LOGIC;
			busy: out std_logic);
end lec11_cu;

architecture Behavioral of lec11_cu is

begin

    process(kbClk)    
    begin
        if(sw = '1') then
            cw <= "011";
        elsif (rising_edge(kbClk)) then
            cw <= "101";
        else
            cw <= "000";
        end if;
    end process;


end Behavioral;
