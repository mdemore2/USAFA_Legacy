	--------------------------------------------------------------------
	-- Name:Mark Demore
	-- Date: 15 Mar 17 
	-- Course:	ECE281
	-- File: additionalElevatorController.vhd
	-- HW: Lab 3
	--
	-- Purp: Adapted elevator controller to add floors and use go button
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
----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: Silva
-- 
-- Create Date:    	10:33:47 07/07/2012 
-- Design Name:		CE3
-- Module Name:    	MooreElevatorController_Shell - Behavioral 
-- Description: 		Code completed by C3C Demore
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity additionalElevatorController is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  go : in std_logic;
           goto : in  STD_LOGIC_VECTOR (3 downto 0);
           floor : out  STD_LOGIC_VECTOR (3 downto 0);
			  up : out std_logic;
			  down : out std_logic);
end additionalElevatorController;

architecture Behavioral of additionalElevatorController is

--Below you create a new variable type! You also define what values that 
--variable type can take on. Now you can assign a signal as 
--"floor_state_type" the same way you'd assign a signal as std_logic 
type floor_state_type is (floor1, floor2, floor3, floor4, floor5, floor6, floor7, floor8, floor9, floor10, floor11, floor12, floor13, floor14, floor15, floor16);

--Here you create a variable "floor_state" that can take on the values
--defined above. Neat-o!
signal floor_state, desFloor : STD_LOGIC_VECTOR(3 downto 0);

begin
---------------------------------------------
--Below you will code your next-state process
---------------------------------------------
--reset_proc : process (reset)
--begin
--	if reset = '1' then
--		floor_state <= floor1;
--	end if;
--end process;

go_btn : process(go)
begin
	if reset = '1' then
		desFloor <= x"0";
	elsif go = '1' then
		desFloor <= goto;
	end if;
end process;

--This line will set up a process that is sensitive to the clock
floor_state_machine: process(clk)
begin
	--clk'event and clk='1' is VHDL-speak for a rising edge
	
	if reset ='1' then
		floor_state <= x"0";
	else
		if clk'event and clk='1' then
		--reset is active high and will return the elevator to floor1
		--Question: is reset synchronous or asynchronous?
			if reset='1' then
				floor_state <= x"0";
		--now we will code our next-state logic
			else
				if floor_state = desFloor then
					floor_state <= floor_state;
					up <= '0';
					down <= '0';
				elsif floor_state < desFloor then
					floor_state <= (floor_state + x"1");
					up <= '1';
				elsif floor_state > desFloor then
					floor_state <= (floor_state - x"1");
					down <= '1';
				else
					floor_state <= x"1";
				end if;
			end if;
		end if;
	end if;
end process;

-- Here you define your output logic. Finish the statements below
--floor <= x"1" when (floor_state = floor1) else
--			x"2" when (floor_state = floor2) else
--			x"3" when (floor_state = floor3) else
--			x"4" when (floor_state = floor4) else
--			x"5" when (floor_state = floor5) else
--			x"1";

floor <= floor_state;

end Behavioral;

