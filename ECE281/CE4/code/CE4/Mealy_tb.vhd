	--------------------------------------------------------------------
	-- Name: Mark Demore II
	-- Date: 3/12/17
	-- Course: ECE 281
	-- File: Mealy_tb.vhd
	-- HW: CE4 - Elevator FSM
	--
	-- Purp: This code verifies functionality of MealyElevatorController_Shell.vhd with a series of test cases.
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
 
ENTITY Mealy_tb IS
END Mealy_tb;
 
ARCHITECTURE behavior OF Mealy_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MealyElevatorController_Shell
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         stop : IN  std_logic;
         up_down : IN  std_logic;
         floor : OUT  std_logic_vector(3 downto 0);
         nextfloor : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal stop : std_logic := '0';
   signal up_down : std_logic := '0';

 	--Outputs
   signal floor : std_logic_vector(3 downto 0);
   signal nextfloor : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MealyElevatorController_Shell PORT MAP (
          clk => clk,
          reset => reset,
          stop => stop,
          up_down => up_down,
          floor => floor,
          nextfloor => nextfloor
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '1';
		wait for 40 ns; -- test reset

		reset <= '0';
		up_down <= '1';
		stop <= '0';
		wait for clk_period; -- test up all 4 floors, stopping for two clock cycles
		stop <= '1';
		wait for clk_period*2;
		
		stop <= '0';
		wait for clk_period; -- test up all 4 floors, stopping for two clock cycles
		stop <= '1';
		wait for clk_period*2;
		
		stop <= '0';
		wait for clk_period; -- test up all 4 floors, stopping for two clock cycles
		stop <= '1';
		wait for clk_period*2;
		
		stop <= '0';
		up_down <= '0';
		wait for clk_period*4; -- test down all 4 floors
		
		up_down <= '1';
		wait for clk_period*4; -- verify up all 4 floors without stopping
		reset <= '1';
      wait for clk_period*10; -- verify reset

      wait;
   end process;

END;
