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
--| FILENAME      : synchronizer.vhd
--| AUTHOR(S)     : Capt Phillip Warner
--| CREATED       : 03/2017
--| DESCRIPTION   : This file implements a generic two FF synchronizer with asynchronous reset
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

entity synchronizer is
	generic ( constant k_WIDTH : natural := 1	); -- # bits in registers
	port ( 	i_clk    : in  std_logic;
			i_reset  : in  std_logic;		   -- asynchronous
			i_D		 : in  std_logic_vector(k_WIDTH - 1 downto 0);
			o_Q      : out std_logic_vector(k_WIDTH - 1 downto 0)
	);
end synchronizer;

architecture twoFFsynchronizer_arch of synchronizer is

	-- registered signals pipelined
	signal f_d, ff_d	:	std_logic_vector(k_WIDTH - 1 downto 0) := (others => '0');
	
begin
	-- CONCURRENT STATEMENTS ----------------------------
	
	o_Q <= ff_d;
	
	
	-- PROCESSES ----------------------------------------
	
	-- Synchronizer Process -----------------------------
	twoFFsynchronizer_proc : process(i_clk, i_reset)
	begin
		if i_reset = '1' then
			f_d  <= (others => '0');
			ff_d <= (others => '0');
		else
			if rising_edge(i_clk) then			
				f_d  <= i_D;
				ff_d <= f_d;
			end if;
		end if;
	end process twoFFsynchronizer_proc;
	-----------------------------------------------------
	
end twoFFsynchronizer_arch;

