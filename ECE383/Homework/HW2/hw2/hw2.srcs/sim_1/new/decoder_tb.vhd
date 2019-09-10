--------------------------------------------------------------------
-- Name:	Mark Demore II
-- Date:	Jan 9 2018
-- Course:	ECE383
-- File:	decoder_tb.vhd
-- HW:		HW2
--
-- Purp: Test scancodeDecoder
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

entity decoder_tb is
End decoder_tb;

architecture Behavioral of decoder_tb is

    component scancodeDecoder is
        Port ( D : in std_logic_vector(7 downto 0);
            H : out std_logic_vector(3 downto 0));
    end component;

    signal D: std_logic_vector(7 downto 0);
    signal H: std_logic_vector(3 downto 0);

    CONSTANT TEST_ELEMENTS:integer:=10;
	SUBTYPE INPUT is std_logic_vector(7 downto 0);
	TYPE TEST_INPUT_VECTOR is array (1 to TEST_ELEMENTS) of INPUT;
	SIGNAL TEST_IN: TEST_INPUT_VECTOR := (	x"45", x"16", x"1E", x"26", x"25", x"2E", x"36", x"3D", x"3E", x"46");

	TYPE TEST_OUTPUT_VECTOR is array (1 to TEST_ELEMENTS) of std_logic_vector(3 downto 0);
	SIGNAL TEST_OUT: TEST_OUTPUT_VECTOR := (x"0", x"1", x"2", x"3", x"4", x"5", x"6", x"7", x"8", x"9");

	SIGNAL i : integer;
		
begin
    uut: scancodeDecoder port map(D, H);	
    tb: process
    BEGIN
    
    for i in 1 to TEST_ELEMENTS loop
        D <= test_in(i);
        wait for 10 ns;
        assert H = test_out(i)
            report "error! input:"
            severity failure;
    end loop;
    
    assert TRUE = FALSE
        report "Testbench complete."
        severity failure;
        
    end process tb;
    
end architecture Behavioral;
