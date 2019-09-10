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
--| AUTHOR(S)     : C3C Mark Demore
--| CREATED       : 01/27/2017
--| DESCRIPTION   : This file implements the top level module for a NEXYS2 to utilize 
--|					a seven-segment decoder for displaying hex values on seven-segment 
--|					displays (7SD) according to 4-bit inputs provided by switches.
--|
--|					Inputs:  SW3 (MSB), SW2, SW1, SW0 --> control 7SD value to be diplayed
--|							 BTN3, BTN2, BTN1, BTN0	  --> control which 7SD to activate
--|					Output:  one of four 7SDs will show a 4-bit hex value (0x0 - 0xF)
--|
--| DOCUMENTATION : Uses base file from Capt Warner
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES :
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std, unisim
--|    Files     : sevenSegDecoder.vhd
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
  
entity top_nexys2 is
	port(
		-- 7-segment display segments (cathodes CA ... CG)
		sseg_a  :   out	std_logic;
		sseg_b  :   out	std_logic;
		sseg_c  :   out	std_logic;
		sseg_d  :   out	std_logic;
		sseg_e  :   out	std_logic;
		sseg_f  :   out	std_logic;
		sseg_g  :   out	std_logic;

		-- 7-segment display active-low enable (anode)
		AN0     :	out std_logic;
		AN1     :	out std_logic;
		AN2     :	out std_logic;
		AN3     :	out std_logic;

		-- Switches
		SW0		:	in std_logic;
		SW1		:	in std_logic;
		SW2		:	in std_logic;
		SW3		:	in std_logic;
		
		-- Buttons
		BTN0	:	in	std_logic;
		BTN1	:	in	std_logic;
		BTN2	:	in	std_logic;
		BTN3	:	in	std_logic	
	);
end top_nexys2;

architecture top_nexys2_arch of top_nexys2 is 
	
  -- declare the component of your top-level design unit under test (UUT)
  component sevenSegDecoder is
    port(
			i_D  : in std_logic_vector(3 downto 0);
			o_S  : out std_logic_vector(6 downto 0)
    );	
  end component;

  -- declare wire bus signal for connecting Nexys2 switch inputs to your component inputs
	signal w_SW0,w_SW1,w_SW2,w_SW3 : std_logic;
  
  -- declare wires to connect to component outputs to Nexys2 7SD segment inputs
  signal w_7SD_Sa,w_7SD_Sb,w_7SD_Sc,w_7SD_Sd,w_7SD_Se,w_7SD_Sf,w_7SD_Sg : std_logic;
  
  -- create wires to connect buttons to 7SD enables (active-low)
  signal w_7SD_EN0_n, w_7SD_EN1_n, w_7SD_EN2_n, w_7SD_EN3_n	  : std_logic;

  
begin
	-- PORT MAPS ----------------------------------------

	--	Port map: wire your component up to the switch wires and seven-segment display segment wires
	uut_inst : sevenSegDecoder port map (
		i_D(3) => w_SW3,
		i_D(2) => w_SW2, 
		i_D(1) => w_SW1, 
		i_D(0) => w_SW0, 
		o_S(6) => w_7SD_Sa,
		o_S(5) => w_7SD_Sb,
		o_S(4) => w_7SD_Sc,
		o_S(3) => w_7SD_Sd,
		o_S(2) => w_7SD_Se,
		o_S(1) => w_7SD_Sf,
		o_S(0) => w_7SD_Sg
	);


	
	
	-- CONCURRENT STATEMENTS ----------------------------
	
	-- connect the switches wires to the Nexys2 switches
	w_SW0 <= SW0;
	w_SW1 <= SW1;
	w_SW2 <= SW2;
	w_SW3 <= SW3;
	

	
	-- connect component outputs to Nexys2 7SD segment cathodes
	sseg_a <= w_7SD_Sa;
	sseg_b <= w_7SD_Sb;
	sseg_c <= w_7SD_Sc;
	sseg_d <= w_7SD_Sd;
	sseg_e <= w_7SD_Se;
	sseg_f <= w_7SD_Sf;
	sseg_g <= w_7SD_Sg;


	
	
	-- wire up active-low 7SD anodes to buttons (active-high)
	-- display 7SD only when button pushed
	w_7SD_EN0_n	<= not BTN0;
	w_7SD_EN1_n	<= not BTN1;
	w_7SD_EN2_n	<= not BTN2;
	w_7SD_EN3_n	<= not BTN3;
	
	AN0  <= w_7SD_EN0_n;
	AN1  <= w_7SD_EN1_n;
	AN2  <= w_7SD_EN2_n;
	AN3  <= w_7SD_EN3_n;
	
end top_nexys2_arch;
