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
--| FILENAME      : sevenSegDecoder.vhd
--| AUTHOR(S)     : C3C Mark Demore II
--| CREATED       : 01/25/2017
--| DESCRIPTION   : Create decoder to iterate through hex digits on seven-segment display using four-bit input.
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

-- entity name should match filename  
entity ssegAdditional2 is 
  port(
	i_unD  : in std_logic_vector(3 downto 0);
	o_S  : out std_logic_vector(6 downto 0)
  );
end ssegAdditional2;

architecture behavioral of ssegAdditional2 is 
	-- include components declarations and signals
	
	-- intermediate signals with initial value
	-- typically you would use names that relate to signal (e.g. c_mux_2)
	signal c_Sa : std_logic := '1';
   signal c_Sb : std_logic := '1';
   signal c_Sc : std_logic := '1';
   signal c_Sd : std_logic := '1';
   signal c_Se : std_logic := '1';
   signal c_Sf : std_logic := '1';
   signal c_Sg : std_logic := '1';
	signal i_D : std_logic_vector(3 downto 0);
	
	
  
begin

	-- CONCURRENT STATEMENTS "MODULES" ------------------
	o_S(6) <= c_Sa;
	o_S(5) <= c_Sb;
	o_S(4) <= c_Sc;
	o_S(3) <= c_Sd;
	o_S(2) <= c_Se;
	o_S(1) <= c_Sf;
	o_S(0) <= c_Sg;
	
filter : process(i_unD)
begin
	if i_unD > x"8" then
		if i_unD = x"9" then
			i_D <= x"0";
		elsif i_unD = x"A" then
			i_D <= x"1";
		elsif i_unD = x"B" then
			i_D <= x"2";
		elsif i_unD = x"C" then
			i_D <= x"3";
		elsif i_unD = x"D" then
			i_D <= x"4";
		elsif i_unD = x"E" then
			i_D <= x"5";
		elsif i_unD = x"F" then
			i_D <= x"6";
		end if;
	end if;
end process;
	
	c_Sa <= ( not i_D(3) and not i_D(2) and not i_D(1) and i_D(0) )
				or (i_D(3) and not i_D(2) and i_D(1) and i_D(0))
				or (i_D(2) and not i_D(1) and not i_D(0))
				or (i_D(3) and i_D(2) and not i_D(1));

	c_Sb <= '1' when ((i_D = x"5") or
							(i_D = x"6") or
							(i_D = x"B") or
							(i_D = x"C") or
							(i_D = x"E") or
							(i_D = x"F")) else '0';
	
	c_Sc <= '1' when ((i_D = x"2") or
							(i_D = x"C") or
							(i_D = x"E") or
							(i_D = x"F")) else '0';

	c_Sd <= '1' when ((i_D = x"1") or
							(i_D = x"4") or
							(i_D = x"7") or
							(i_D = x"9") or
							(i_D = x"A") or
							(i_D = x"F")) else '0';
							
	c_Se <= '1' when ((i_D = x"1") or
							(i_D = x"3") or
							(i_D = x"4") or
							(i_D = x"5") or
							(i_D = x"7") or
							(i_D = x"9")) else '0';
							
	c_Sf <= '1' when ((i_D = x"1") or
							(i_D = x"2") or
							(i_D = x"3") or
							(i_D = x"7") or
							(i_D = x"C") or
							(i_D = x"D"))else '0';
							
	c_Sg <= ( not i_D(1) and not i_D(2) and not i_D(3) )
				or ( i_D(0) and i_D(1) and i_D(2) and not i_D(3) );
							
  
	
end behavioral;
