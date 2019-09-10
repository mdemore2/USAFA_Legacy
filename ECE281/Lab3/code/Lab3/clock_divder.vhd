--+----------------------------------------------------------------------------
--| 
--| COPYRIGHT 2017 United States Air Force Academy All rights reserved.
--| 
--| United States Air Force Academy     __  _______ ___    _________ 
--| Dept of Electrical &               / / / / ___//   |  / ____/   |
--| Computer Engineering              / / / /\__ \/ /| | / /_  / /| |
--| 2354 Fairchild Drive Ste 2F6     / /_/ /___/ / ___ |/ __/ / ___ |
--| USAF Academy, CO 80840           \____//____/_/  |_/_/   /_/  |_|
--| 
--| ---------------------------------------------------------------------------
--|
--| FILENAME      : clock_divider.vhd
--| AUTHOR(S)     : Capt Phillip Warner
--| CREATED       : 03/2017
--| DESCRIPTION   : This file implements a generic clock divider that uses a counter and comparator.
--|					This provides more flexibility than simpler designs that use a bit from a 
--|					clk bus (they only provide divisors of powers of 2).
--|  
--| DOCUMENTATION : None
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES :
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std, unisim
--|    Files     : None
--|
--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    b_<port name>            = on-chip bidirectional port
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    c_<signal name>          = combinatorial signal
--|    f_<signal name>          = synchronous signal
--|    ff_<signal name>         = pipeline stage (ff_, fff_, etc.)
--|    <signal name>_n          = active low signal
--|    w_<signal name>          = top level wiring signal
--|    g_<generic name>         = generic
--|    k_<constant name>        = constant
--|    v_<variable name>        = variable
--|    sm_<state machine type>  = state machine type definition
--|    s_<signal name>          = state name
--|
--+----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity clock_divider is
	generic ( constant k_DIV : natural := 12500000	); -- how much you divide clock
	port ( 	i_clk    : in std_logic;
			i_reset  : in std_logic;		   -- asynchronous
			o_clk    : out std_logic		   -- divided (slow) clock
	);
end clock_divider;

architecture countCompare of clock_divider is
	signal f_count	:	natural		:= 0;
	signal f_clk	:	std_logic	:= '0';
	
begin
	-- CONCURRENT STATEMENTS ----------------------------
	
	o_clk <= f_clk;
	
	
	-- PROCESSES ----------------------------------------
	
	-- Clock count and divide Process -------------------
	--   increment and compare f_count to k_DIV
	--   rollover and toggle f_clk when count reaches k_DIV
	countClock_proc : process(i_clk, i_reset)
	begin
		if i_reset = '1' then
			f_count <= 0;
			f_clk	<= '0';
		else
			if rising_edge(i_clk) then			
				if f_count = k_DIV - 1 then
					f_count <= 0;
					f_clk <= not f_clk;
				else
					f_count <= f_count + 1;
				end if;
			end if;
		end if;
	end process countClock_proc;
	-----------------------------------------------------
	
end countCompare;

