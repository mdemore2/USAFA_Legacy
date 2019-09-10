--------------------------------------------------------------------
-- Name:	Mark Demore II
-- Date:	Jan 9 2018
-- Course:	ECE383
-- File:	hw2.vhd
-- HW:		HW2 - Scancode Decoder
--
-- Purp: Decode PS2 scancode into hex equivalent
--
-- Doc:	None

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

entity scancodeDecoder is
    Port ( D : in std_logic_vector(7 downto 0);
            H : out std_logic_vector(3 downto 0));
end scancodeDecoder;

architecture Behavioral of scancodeDecoder is

begin
    H <=    x"0" when D = x"45" else
            x"1" when D = x"16" else
            x"2" when D = x"1E" else
            x"3" when D = x"26" else
            x"4" when D = x"25" else
            x"5" when D = x"2E" else
            x"6" when D = x"36" else
            x"7" when D = x"3D" else
            x"8" when D = x"3E" else
            x"9" when D = x"46" else
            x"F";


end Behavioral;
