	--------------------------------------------------------------------
	-- Name:		Mark Demore
	-- Date:		15 Feb 2017
	-- Course:	ECE281
	-- File:		alu_tb.vhd
	-- HW:		CE3
	--
	-- Purp:		This program establishes test cases for a 32-bit ALU.
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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY alu_tb IS
END alu_tb;
 
ARCHITECTURE testbench OF alu_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         a : IN  std_logic_vector(31 downto 0);
         b : IN  std_logic_vector(31 downto 0);
         f : IN  std_logic_vector(2 downto 0);
         y : OUT  std_logic_vector(31 downto 0);
         zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
--   signal a : std_logic_vector(31 downto 0) := (others => '0');
	signal c_a : std_logic_vector(31 downto 0) := x"00000000";
   signal c_b : std_logic_vector(31 downto 0) := x"00000000";
   signal c_f : std_logic_vector(2 downto 0)  := "000";

 	--Outputs
   signal c_y : std_logic_vector(31 downto 0) := x"00000000";
   signal c_zero : std_logic := '0';
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          a => c_a,
          b => c_b,
          f => c_f,
          y => c_y,
          zero => c_zero
        );

 process
   begin		
			c_a <= x"00000000" ; c_b <= x"00000000" ; c_f <= "010" ; wait for 10 ns;
			assert c_y = x"00000000" report "Case 1 Failed.";
			
			c_a <= x"00000000" ; c_b <= x"FFFFFFFF" ; c_f <= "010" ; wait for 10 ns;
			assert c_y = x"FFFFFFFF" report "Case 2 Failed.";
			
			c_a <= x"00000001" ; c_b <= x"FFFFFFFF" ; c_f <= "010" ; wait for 10 ns;
			assert c_y = x"00000000" report "Case 3 Failed.";
			
			c_a <= x"000000FF" ; c_b <= x"00000001" ; c_f <= "010" ; wait for 10 ns;
			assert c_y = x"00000100" report "Case 4 Failed.";
			
			c_a <= x"00000000" ; c_b <= x"00000000" ; c_f <= "110" ; wait for 10 ns;
			assert c_y = x"00000000" report "Case 5 Failed.";
			
			c_a <= x"00000000" ; c_b <= x"FFFFFFFF" ; c_f <= "110" ; wait for 10 ns;
			assert c_y = x"00000001" report "Case 6 Failed.";
			
			c_a <= x"00000001" ; c_b <= x"00000001" ; c_f <= "110" ; wait for 10 ns;
			assert c_y = x"00000000" report "Case 7 Failed.";
			
			c_a <= x"00000100" ; c_b <= x"00000001" ; c_f <= "110" ; wait for 10 ns;
			assert c_y = x"000000FF" report "Case 8 Failed.";
			
			c_a <= x"00000000" ; c_b <= x"00000000" ; c_f <= "111" ; wait for 10 ns;
			assert c_y = x"00000000" report "Case 9 Failed.";
			
			c_a <= x"00000000" ; c_b <= x"00000001" ; c_f <= "111" ; wait for 10 ns;
			assert c_y = x"00000001" report "Case 10 Failed.";
			
			c_a <= x"00000000" ; c_b <= x"FFFFFFFF" ; c_f <= "111" ; wait for 10 ns;
			assert c_y = x"00000000" report "Case 11 Failed.";
			
			c_a <= x"00000001" ; c_b <= x"00000000" ; c_f <= "111" ; wait for 10 ns;
			assert c_y = x"00000000" report "Case 12 Failed.";
			
			c_a <= x"FFFFFFFF" ; c_b <= x"00000000" ; c_f <= "111" ; wait for 10 ns;
			assert c_y = x"00000001" report "Case 13 Failed.";
			
			c_a <= x"FFFFFFFF" ; c_b <= x"FFFFFFFF" ; c_f <= "000" ; wait for 10 ns;
			assert c_y = x"FFFFFFFF" report "Case 14 Failed.";
			
			c_a <= x"FFFFFFFF" ; c_b <= x"12345678" ; c_f <= "000" ; wait for 10 ns;
			assert c_y = x"12345678" report "Case 15 Failed.";
			
			c_a <= x"12345678" ; c_b <= x"02040608" ; c_f <= "100" ; wait for 10 ns;
			assert c_y = x"10305070" report "Case 16 Failed.";
			
			c_a <= x"AAAAAAAA" ; c_b <= x"FFFF0000" ; c_f <= "100" ; wait for 10 ns;
			assert c_y = x"0000AAAA" report "Case 17 Failed.";
			
			c_a <= x"FFFFFFFF" ; c_b <= x"FFFFFFFF" ; c_f <= "001" ; wait for 10 ns;
			assert c_y = x"FFFFFFFF" report "Case 18 Failed.";
			
			c_a <= x"12345678" ; c_b <= x"87654321" ; c_f <= "001" ; wait for 10 ns;
			assert c_y = x"97755779" report "Case 19 Failed.";
			
			c_a <= x"00000000" ; c_b <= x"FFFFFFFF" ; c_f <= "001" ; wait for 10 ns;
			assert c_y = x"FFFFFFFF" report "Case 20 Failed.";
			
			c_a <= x"00000000" ; c_b <= x"00000000" ; c_f <= "001" ; wait for 10 ns;
			assert c_y = x"00000000" report "Case 21 Failed.";
			
			c_a <= x"00000000" ; c_b <= x"00000000" ; c_f <= "101" ; wait for 10 ns;
			assert c_y = x"FFFFFFFF" report "Case 22 Failed.";
			
			c_a <= x"00000000" ; c_b <= x"00000000" ; c_f <= "011" ; wait for 10 ns;
			assert c_y = x"00000000" report "Case 23 Failed.";
			
			c_a <= x"00000001" ; c_b <= x"FFFFFFFF" ; c_f <= "111" ; wait for 10 ns;
			assert c_y = x"00000000" report "Case 24 Failed.";
			
			c_a <= x"FFFFFFFF" ; c_b <= x"FFFFFFFF" ; c_f <= "110" ; wait for 10 ns;
			assert c_y = x"00000000" report "Case 25 Failed.";
			
      wait;
   end process;

END;
