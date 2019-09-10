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
--| FILENAME      : halfAdder.vhd
--| AUTHOR(S)     : Mark Demore II
--| CREATED       : 01/22/2017
--| DESCRIPTION   : This file implements a one bit half adder.
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
entity halfAdder is 
  port(
	i_A     : in  std_logic; -- 1-bit input port
	i_B     : in  std_logic; 
	o_S     : out std_logic;  -- 1-bit output port
	o_Cout  : out std_logic
							 -- (NOTE: NO semicolon on LAST port only!)
  ); -- the semicolon is here instead
end halfAdder;

architecture halfAdder_arch of halfAdder is 
	-- this is where you would include components declarations and signals if you needed them
	  
begin
	-- this is where you would map ports for any component instantiations if you needed to

	-- *concurrent* signal assignments
	o_S    <= i_A xor i_B;
	o_Cout <= i_A and i_B;
	-- TODO:  Carry signal assignment
	
end halfAdder_arch;
