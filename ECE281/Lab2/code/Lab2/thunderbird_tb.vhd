	--------------------------------------------------------------------
	-- Name: Mark Demore II
	-- Date: 1 Mar 17
	-- Course:	ECE281 - Comp Architecture
	-- File: thunderbird_tb.vhd
	-- HW: Lab #2 Thunderbird FSM
	--
	-- Purp: Establishes test cases for simulation of thunderbird tail light FSM design.
	--
	-- Doc: None
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
 
ENTITY thunderbird_tb IS
END thunderbird_tb;
 
ARCHITECTURE thunderbird OF thunderbird_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT thunderbird_fsm
    PORT(
         i_clk : IN  std_logic;
         i_reset : IN  std_logic;
         i_left : IN  std_logic;
         i_right : IN  std_logic;
         o_lights_L : OUT  std_logic_vector(2 downto 0);
         o_lights_R : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i_clk : std_logic := '0';
   signal i_reset : std_logic := '0';
   signal i_left : std_logic := '0';
   signal i_right : std_logic := '0';

 	--Outputs
   signal o_lights_L : std_logic_vector(2 downto 0);
   signal o_lights_R : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant i_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: thunderbird_fsm PORT MAP (
          i_clk => i_clk,
          i_reset => i_reset,
          i_left => i_left,
          i_right => i_right,
          o_lights_L => o_lights_L,
          o_lights_R => o_lights_R
        );

   -- Clock process definitions
   i_clk_process :process
   begin
		i_clk <= '0';
		wait for i_clk_period/2;
		i_clk <= '1';
		wait for i_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for clk_period.
      i_reset <= '1';
		wait for i_clk_period;	--test reset
		i_reset <= '0';
		
      -- insert stimulus here 
		i_left <= '1';
		wait for i_clk_period*4;	-- test left
		
		i_left <= '0';
		i_right <= '1';
		wait for i_clk_period*4;	--test right
		
		i_left <= '1';
		wait for i_clk_period*4;	--test hazards
		
		i_left <= '0';
		wait for 5 ns;
		i_right <= '0';
		i_left <= '1';				--test mid-state change
		wait for i_clk_period*2;
		
		wait for 5 ns;
		i_left <= '0';
		i_right <= '1';
		wait for i_clk_period*2;	--test alternate mid-state change
	
		i_reset <= '1';
      wait;
		
   end process;

END;
