----------------------------------------------------------------------------------
-- Name:	Mark Demore II
-- Date:	Spring 2017
-- Course: ECE 281
-- File: thunderbird_fsm.vhd
-- HW:	Lab 2
-- Purp:	FSM for 1965 Ford Thunderbird tail lights
-- Doc:	None
-- Academic Integrity Statement: I certify that, while others may have 
-- assisted me in brain storming, debugging and validating this program, 
-- the program itself is my own work. I understand that submitting code 
-- which is the work of other individuals is a violation of the honor   
-- code.  I also understand that if I knowingly give my original work to 
-- another individual is also a violation of the honor code. 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity thunderbird_fsm is
	port(
			i_clk,  i_reset : in  std_logic;
			i_left, i_right : in  std_logic;
			o_lights_L      : out std_logic_vector(2 downto 0);
			o_lights_R      : out std_logic_vector(2 downto 0)
		);

end thunderbird_fsm;

architecture thunderbird of thunderbird_fsm is
type sm_tbird is (S0, S1, S2, S3, S4, S5, S6, S7);
signal next_state, current_state : sm_tbird;

begin

next_state <= S1 when i_left = '1' and current_state = S0  and not i_right = '1' else
					S2 when current_state = S1 else
					S3 when current_State = S2 else
					S4 when i_right = '1' and current_state = S0 and not i_left = '1' else
					S5 when current_state = S4 else
					S6 when current_state = S5 else
					S7 when i_left = '1' and i_right = '1'  and current_state /= S7 else 
					S0;
					
					
state_process : process (i_clk, i_reset)
	begin						
		if (i_reset = '1') then
			current_state <= S0;
		elsif (rising_edge (i_clk)) then
			current_state <= next_state;
		end if;		
end process;
	
o_lights_L(0) <= '1' when current_state = S1 or current_state = S2 or current_state = S3 or current_state = S7 else '0';
o_lights_L(1) <= '1' when current_state = S2 or current_state = S3 or current_state = S7 else '0';
o_lights_L(2) <= '1' when current_state = S3 or current_state = S7 else '0';
o_lights_R(0) <= '1' when current_state = S4 or current_state = S5 or current_state = S6 or current_state = S7 else '0';
o_lights_R(1) <= '1' when current_state = S5 or current_state = S6 or current_state = S7 else '0';
o_lights_R(2) <= '1' when current_state = S6 or current_state = S7 else '0';


end thunderbird;

