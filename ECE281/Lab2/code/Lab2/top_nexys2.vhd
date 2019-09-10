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
--| FILENAME      : top_nexys2.vhd
--| AUTHOR(S)     : Capt Phillip Warner, C3C Mark Demore II
--| CREATED       : 02/22/2017
--| DESCRIPTION   : This file implements the top level module for a NEXYS2 in 
--|					order to drive a Thunderbird taillight controller.
--|
--|					Inputs:  sw(3:0)  --> clk reset, FSM reset, left, and right turn signals
--|							 clk 	  --> 50 MHz clock from FPGA
--|					Output:  led(5:0) --> left and right turn signal lights (three per side)
--|
--| DOCUMENTATION : None
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES : clock_divider.vhd, thunderbird_fsm.vhd
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std, unisim
--|    Files     : thunderbird_fsm.vhd, clock_divider.vhd
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
  
entity top_nexys2 is
	port(
		i_clk_50MHz : in std_logic; -- native 50MHz FPGA clock
		i_sw  		: in std_logic_vector(3 downto 0); -- clk_reset, fsm_reset, 
													   -- left, right
		o_led 		: out std_logic_vector(5 downto 0) -- taillights 
													   -- (LC, LB, LA, RA, RB, RC)
	);
end top_nexys2;

architecture top_nexys2_arch of top_nexys2 is 
	
  -- declare components
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
	
	component clock_divider is
	port(
		i_reset : in STD_LOGIC;
		i_clk : in STD_LOGIC;
		o_clk : out STD_LOGIC
	);
	end component;

  -- create wires to connect components
  signal w_clk_reset, w_fsm_reset, w_left, w_right, w_slow_clk, w_clk : std_logic;
  signal w_out : std_logic_vector(5 downto 0);

  
begin
	-- PORT MAPS / COMPONENT INSTANTIATION --------------
	inst : thunderbird_fsm port map (
	i_clk => w_slow_clk,
	i_reset => w_fsm_reset,
	i_left => w_left,
	i_right => w_right,
	o_lights_L => w_out(5 downto 3),
	o_lights_R => w_out(2 downto 0)
	);
	
	instance : clock_divider port map (
	i_reset => w_clk_reset,
	i_clk => w_clk,
	o_clk => w_slow_clk
	);

	
	
	-- CONCURRENT STATEMENTS ----------------------------
	w_clk_reset <= i_sw(0);
	w_fsm_reset <= i_sw(1);
	w_left <= i_sw(3);
	w_right <= i_sw(2);
	w_clk <= i_clk_50MHz;
	
	o_led(0) <= w_out(2);
	o_led(1) <= w_out(1);
	o_led(2) <= w_out(0);
	o_led(3) <= w_out(3);
	o_led(4) <= w_out(4);
	o_led(5) <= w_out(5);
	
		
	
end top_nexys2_arch;
