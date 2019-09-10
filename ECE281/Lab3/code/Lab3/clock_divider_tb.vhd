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
--| FILENAME      : clock_divider_tb.vhd (TEST BENCH)
--| AUTHOR(S)     : Capt Phillip Warner
--| CREATED       : 03/2017
--| DESCRIPTION   : This file tests the generic clock divider.
--|
--| DOCUMENTATION : None
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES :
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std, unisim
--|    Files     : clock_divider.vhd
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
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  
entity clock_divider_tb is
end clock_divider_tb;

architecture test_bench of clock_divider_tb is 	
  
	component clock_divider is
		generic ( constant k_DIV : natural := 3	); -- how much you divide clock
		port ( 	i_clk    : in std_logic;
				i_reset  : in std_logic;		   -- asynchronous
				o_clk    : out std_logic		   -- divided (slow) clock
		);
	end component clock_divider;

	-- Setup test clk (20 ns --> 50 MHz)
	constant k_clk_period	: time 		:= 20 ns;
	signal clk			 	: std_logic	:= '0';

	signal reset, slow_clk	: std_logic	:= '0';
	
	-- Set clk divide amount here
	constant k_clock_divs	: natural	:= 12500000;
	
begin
	-- PORT MAPS ----------------------------------------

	-- map ports for any component instances (port mapping is like wiring hardware)
	uut_inst : clock_divider 
	generic map ( k_DIV => k_clock_divs )
	port map (
		i_clk   => clk,
		i_reset => reset,
		o_clk	=> slow_clk
	);

	
	-- PROCESSES ----------------------------------------
	
	-- Clock Process ------------------------------------
	clk_process : process
	begin
		clk <= '0';
		wait for k_clk_period/2;
		
		clk <= '1';
		wait for k_clk_period/2;
	end process clk_process;
	-----------------------------------------------------	
	
	-- Test Plan Process --------------------------------
	test_process : process 
	begin
		-- clock should have good initial state, so let it divide at least twice
		wait for k_clk_period * k_clock_divs * 2;
		
		-- now hold it in reset to verify that works correctly
		reset <= '1';
		wait for k_clk_period * k_clock_divs * 2;
		
		-- let the clock divide for rest of sim
		reset <= '0';		
		wait;
	end process;	
	-----------------------------------------------------	
	
end test_bench;
