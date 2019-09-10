--------------------------------------------------------------------
-- Name:	C2C Mark Demore II
-- Date:	11 Jan 2018
-- Course:	ECE383
-- File:	hw3.vhd
-- HW:		HW3
--
-- Purp: Turn on an LED if input is divisible by 17.
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hw3 is
    Port (d: in std_logic_vector(7 downto 0);
            f: out std_logic );
end hw3;

architecture Behavioral of hw3 is

begin

    f <= '1' when (d = x"11") 
            or (d = x"22") 
            or (d = x"33")
            or (d = x"44")
            or (d = x"55")
            or (d = x"66")
            or (d = x"77")
            or (d = x"88")
            or (d = x"99")
            or (d = x"AA")
            or (d = x"BB")
            or (d = x"CC")
            or (d = x"DD")
            or (d = x"EE")
            or (d = x"FF")
            else '0';

end Behavioral;
