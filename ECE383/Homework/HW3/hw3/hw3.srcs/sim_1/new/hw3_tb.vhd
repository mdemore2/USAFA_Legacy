--------------------------------------------------------------------
-- Name:	C2C Mark Demore II
-- Date:	11 Jan 2018
-- Course:	ECE383
-- File:	hw3_tb.vhd
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

entity hw3_tb is
end hw3_tb;

architecture Behavioral of hw3_tb is

    component hw3 is
        Port (d : in std_logic_vector(7 downto 0);
                f : out std_logic );
    end component;

    signal d: std_logic_vector(7 downto 0);
    signal f: std_logic;

    CONSTANT TEST_ELEMENTS:integer:=15;
	SUBTYPE INPUT is std_logic_vector(7 downto 0);
	TYPE TEST_INPUT_VECTOR is array (1 to TEST_ELEMENTS) of INPUT;
	SIGNAL TEST_IN: TEST_INPUT_VECTOR := (	x"11", x"22", x"33", x"44", x"55", x"66", x"77", x"88", x"99", x"AA", x"BB", x"CC", x"DD", x"EE", x"FF");

	TYPE TEST_OUTPUT_VECTOR is array (1 to TEST_ELEMENTS) of std_logic;
	SIGNAL TEST_OUT: TEST_OUTPUT_VECTOR := ('1', '1', '1', '1', '1', '1','1','1','1','1','1','1','1','1','1');

	SIGNAL i : integer;
		
begin
    uut: hw3 port map(d, f);	
    tb: process
    BEGIN
    
    for i in 1 to TEST_ELEMENTS loop
        d <= test_in(i);
        wait for 10 ns;
        assert f = test_out(i)
            report "error! input:"
            severity failure;
    end loop;
    
    assert TRUE = FALSE
        report "Testbench complete."
        severity failure;
        
    end process tb;


end Behavioral;
