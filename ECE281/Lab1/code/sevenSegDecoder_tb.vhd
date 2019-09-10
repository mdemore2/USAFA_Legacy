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
--| FILENAME      : sevenSegDecoder_tb.vhd (TEST BENCH)
--| AUTHOR(S)     : C3C Mark Demore
--| CREATED       : 01/26/2017
--| DESCRIPTION   : This implements a decoder for use with a seven-segment display based on 4-bit input.
--|
--| DOCUMENTATION : None
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES :
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std, unisim
--|    Files     : LIST ANY DEPENDENCIES
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
  
entity sevenSegDecoder_tb is
end sevenSegDecoder_tb;

architecture test_bench of sevenSegDecoder_tb is 
	
  -- declare the component of your top-level design unit under test (UUT)
  component sevenSegDecoder is
    port(
			i_D  : in std_logic_vector(3 downto 0);
			o_S  : out std_logic_vector(6 downto 0)
    );	
  end component;

  -- declare any additional components required
  
  -- declare signals needed to stimulate the UUT inputs
  signal sseg_a : std_logic := '1';
  signal sseg_b : std_logic := '1';
  signal sseg_c : std_logic := '1';
  signal sseg_d : std_logic := '1';
  signal sseg_e : std_logic := '1';
  signal sseg_f : std_logic := '1';
  signal sseg_g : std_logic := '1';
  signal SW0 : std_logic := '1';
  signal SW1 : std_logic := '1';
  signal SW2 : std_logic := '1';
  signal SW3 : std_logic := '1';
  
begin
	-- PORT MAPS ----------------------------------------

	-- map ports for any component instances (port mapping is like wiring hardware)
	uut_inst : sevenSegDecoder port map (
		i_D(3) => SW0,
		i_D(2) => SW1, 
		i_D(1) => SW2, 
		i_D(0) => SW3, 
		o_S(6) => sseg_a,
		o_S(5) => sseg_b,
		o_S(4) => sseg_c,
		o_S(3) => sseg_d,
		o_S(2) => sseg_e,
		o_S(1) => sseg_f,
		o_S(0) => sseg_g
	);


	-- CONCURRENT STATEMENTS ----------------------------

	
	-- PROCESSES ----------------------------------------
	
	-- Provide a comment that describes each process
	-- block them off like the modules above and separate with SPACE
	-- You will at least have a test process
	
	
	-- Test Plan Process --------------------------------
	-- Implement the test plan here.  Body of process is continuously from time = 0  
	test_process : process 
	begin
		-- assign '0' for first 100 ns, then '1' for next 100 ns, then '0'
		SW3 <= '0', '1' after 100 ns, '0' after 200 ns, '1' after 300 ns, '0' after 400 ns, '1' after 500 ns, '0' after 600 ns, '1' after 700 ns, '0' after 800 ns, '1' after 900 ns, '0' after 1000 ns, '0' after 1100 ns, '1' after 1200 ns, '0' after 1300 ns, '1' after 1400 ns;
		SW2 <= '0', '0' after 100 ns, '1' after 200 ns, '1' after 300 ns, '0' after 400 ns, '0' after 500 ns, '1' after 600 ns, '1' after 700 ns, '0' after 800 ns, '0' after 900 ns, '1' after 1000 ns, '0' after 1100 ns, '0' after 1200 ns, '1' after 1300 ns, '1' after 1400 ns;
		SW1 <= '0', '0' after 100 ns, '0' after 200 ns, '0' after 300 ns, '1' after 400 ns, '1' after 500 ns, '1' after 600 ns, '1' after 700 ns, '0' after 800 ns, '0' after 900 ns, '0' after 1000 ns, '1' after 1100 ns, '1' after 1200 ns, '1' after 1300 ns, '1' after 1400 ns;
		SW0 <= '0', '0' after 100 ns, '0' after 200 ns, '0' after 300 ns, '0' after 400 ns, '0' after 500 ns, '0' after 600 ns, '0' after 700 ns, '1' after 800 ns, '1' after 900 ns, '1' after 1000 ns, '1' after 1100 ns, '1' after 1200 ns, '1' after 1300 ns, '1' after 1400 ns;
		wait; -- wait forever
	end process;	
	-----------------------------------------------------	
	
end test_bench;
