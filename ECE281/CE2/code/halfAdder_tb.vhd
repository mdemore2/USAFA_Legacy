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
--| FILENAME      : halfAdder_tb.vhd
--| AUTHOR(S)     : Mark Demore II
--| CREATED       : 01/22/2017
--| DESCRIPTION   : This file implements a half adder test bench.
--|
--| DOCUMENTATION : None
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES :
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std, unisim
--|    Files     : halfAdder.vhd
--|
--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    xb_<port name>           = off-chip bidirectional port ( _pads file )
--|    xi_<port name>           = off-chip input port         ( _pads file )
--|    xo_<port name>           = off-chip output port        ( _pads file )
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

library unisim;
  use UNISIM.Vcomponents.ALL;
  
entity halfAdder_tb is
end halfAdder_tb;

architecture test_bench of halfAdder_tb is 
	
  -- declare the component of your top-level design unit under test (UUT)
  component halfAdder is
	port(
		i_A     : in  std_logic; -- 1-bit input port
		i_B     : in  std_logic; 
		o_S     : out std_logic;  -- 1-bit output port
		o_Cout  : out std_logic
								 -- (NOTE: NO semicolon on LAST port only!)
	); -- the semicolon is here instead	
  end component;

  
  -- declare signals needed to stimulate the UUT inputs
  signal i_sw1 : std_logic := '0';
  signal i_sw0 : std_logic := '0';
 
  -- also need signals for the outputs of the UUT
  signal o_led1 : std_logic := '0';
  signal o_led0 : std_logic := '0';

  
begin
	-- PORT MAPS ----------------------------------------

	-- map ports for any component instances (port mapping is like wiring hardware)
	halfAdder_inst : halfAdder port map (
		i_A     => i_sw1, -- notice comma (not a semicolon)
		i_B     => i_sw0,
		o_S     => o_led0, -- no comma on LAST one
		o_Cout  => o_led1
	);

	-- CONCURRENT STATEMENTS ----------------------------

	
	-- PROCESSES ----------------------------------------
	
	-- Test Plan Process --------------------------------
	-- Implement the test plan here.  Body of process is continuously from time = 0  
	test_process : process 
	begin
		
		wait for 10 ns;
		i_sw1 <= '0'; i_sw0 <= '0'; 
		wait for 10 ns;
		i_sw1 <= '0'; i_sw0 <= '1'; 
		wait for 10 ns;
		i_sw1 <= '1'; i_sw0 <= '0'; 
		wait for 10 ns;
		i_sw1 <= '1'; i_sw0 <= '1'; 
		wait for 10 ns;
		
		wait; -- wait forever
	end process;	
	-----------------------------------------------------	
	
end test_bench;
