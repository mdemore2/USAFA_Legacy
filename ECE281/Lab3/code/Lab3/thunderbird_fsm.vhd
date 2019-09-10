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
			i_up, i_down : in  std_logic;
			o_lights      : out std_logic_vector(7 downto 0)
		);

end thunderbird_fsm;

architecture thunderbird of thunderbird_fsm is
type sm_tbird is (S0, U0, U1, U2, U3, U4, U5, U6, U7, D0, D1, D2, D3, D4, D5, D6, D7);
signal next_state, current_state : sm_tbird;

begin

next_state <= U0 when i_up = '1' and current_state = S0  and not i_down = '1' else
					U1 when current_state = U0 else
					U2 when current_state = U1 else
					U3 when current_State = U2 else
					U4 when current_State = U3 else
					U5 when current_State = U4 else
					U6 when current_State = U5 else
					U7 when current_State = U6 else
					D0 when i_down = '1' and current_state = S0 and not i_up = '1' else
					D1 when current_state = D0 else
					D2 when current_state = D1 else
					D3 when current_state = D2 else
					D4 when current_state = D3 else
					D5 when current_state = D4 else
					D6 when current_state = D5 else
					D7 when current_state = D6 else
					S0;
					
					
state_process : process (i_clk, i_reset)
	begin						
		if (i_reset = '1') then
			current_state <= S0;
		elsif (rising_edge (i_clk)) then
			current_state <= next_state;
		end if;		
end process;
	
o_lights(0) <= '1' when current_state = U0 or current_state = U1 or current_state = U2 or current_state = U3 or current_state = U4 
								or current_state = U5 or current_state = U6 or current_state = U7 or current_state = D7 else '0';
								
o_lights(1) <= '1' when current_state = D6 or current_state = U1 or current_state = U2 or current_state = U3 or current_state = U4 
								or current_state = U5 or current_state = U6 or current_state = U7 or current_state = D7 else '0';
								
o_lights(2) <= '1' when current_state = D6 or current_state = D5 or current_state = U2 or current_state = U3 or current_state = U4 
								or current_state = U5 or current_state = U6 or current_state = U7 or current_state = D7 else '0';	
								
o_lights(3) <= '1' when current_state = D6 or current_state = D5 or current_state = D4 or current_state = U3 or current_state = U4 
								or current_state = U5 or current_state = U6 or current_state = U7 or current_state = D7 else '0';
								
o_lights(4) <= '1' when current_state = D6 or current_state = D5 or current_state = D4 or current_state = D3 or current_state = U4 
								or current_state = U5 or current_state = U6 or current_state = U7 or current_state = D7 else '0';
								
o_lights(5) <= '1' when current_state = D6 or current_state = D5 or current_state = D4 or current_state = D3 or current_state = D2 
								or current_state = U5 or current_state = U6 or current_state = U7 or current_state = D7 else '0';	
								
o_lights(6) <= '1' when current_state = D6 or current_state = D5 or current_state = D4 or current_state = D3 or current_state = D2 
								or current_state = D1 or current_state = U6 or current_state = U7 or current_state = D7 else '0';	
								
o_lights(7) <= '1' when current_state = D6 or current_state = D5 or current_state = D4 or current_state = D3 or current_state = D2 
								or current_state = D1 or current_state = D0 or current_state = U7 or current_state = D7 else '0';								
end thunderbird;

