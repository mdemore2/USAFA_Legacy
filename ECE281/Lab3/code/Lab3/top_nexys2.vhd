	--------------------------------------------------------------------
	-- Name:Mark Demore
	-- Date: 15 Mar 17 
	-- Course:	ECE281
	-- File: top_nexys2.vhd
	-- HW: Lab 3
	--
	-- Purp: Link all components to function
	--
	-- Doc:	None
	--
	-- Academic Integrity Statement: I certify that, while others may have 
	-- assisted me in brain storming, debugging and validating this program, 
	-- the program itself is my own work. I understand that submitting code 
	-- which is the work of other individuals is a violation of the honor   
	-- code.  I also understand that if I knowingly give my original work to 
	-- another individual is also a violation of the honor code. 
	------------------------------------------------------------------------- 

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
--| AUTHOR(S)     : Capt Phillip Warner
--| CREATED       : 03/2017
--| DESCRIPTION   : This file implements the Lab 3 top level module for a NEXYS2 in 
--|					order to drive an elevator controller and I/O.
--|
--|					Inputs: clk 	 --> 50 MHz clock from FPGA
--|							BTN(3:0) --> Rst Master, Rst FSM, Rst Clk, GO (request floor)
--|							SW(7:4)  --> Passenger location (floor select bits)
--| 						SW(3:0)  --> Desired location (floor select bits)
--| 						 - REQUIRED FUNCTIONALITY ONLY: SW(1) --> up_down, SW(2) --> stop
--|							 
--|					Outputs: LED(7:0) --> indicates elevator movement with sweeping pattern
--|							   - LED(0) --> LED(7) = MOVING UP
--|							   - LED(7) --> LED(0) = MOVING DOWN
--|							   - ALL OFF		   = NOT MOVING
--|							 AN(3:0)    --> seven-segment display anode active-low enable (AN3 ... AN0)
--|							 SSEG(6:0)	--> seven-segment display cathodes (CA ... CG.  DP unused)
--|
--| DOCUMENTATION : None
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES :
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std, unisim
--|    Files     : clock_divider.vhd, YOUR_LAB1_MODULE, YOUR_MOORE_FSM_MODULE
--|
--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    b_<port name>            = bidirectional port
--|    i_<port name>            = input port
--|    o_<port name>            = output port
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
  use ieee.std_logic_unsigned.all;

  
entity top_nexys2 is
	port(
		i_clk_50MHz : in std_logic; -- native 50MHz FPGA clock
		i_btn		: in std_logic_vector(3 downto 0);  -- Rst Master, Rst FSM, Rst Clk, GO
		i_sw  		: in std_logic_vector(3 downto 0);  -- SW(7:4) Passenger location (floor select bits)
													    -- SW(3:0) Desired location (floor select bits)
													    --    OR
													    -- SW(1) --> up_down, SW(2) --> stop
		o_led 		: out std_logic_vector(7 downto 0); -- lights to indicate elevator movement
														--   LED(0) --> LED(7) = MOVING UP
														--   LED(7) --> LED(0) = MOVING DOWN
														--   ALL OFF		   = NOT MOVING		
		o_an		: out std_logic_vector(3 downto 0); -- 7SD anode enable (active-low)
		o_sseg	: out std_logic_vector(6 downto 0) -- 7SD segment cathode (active-low)
	);
end top_nexys2;


architecture top_nexys2_arch of top_nexys2 is 
	
	
  -- declare components
component additionalElevatorController is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  go	: in std_logic;
				goto : in  STD_LOGIC_VECTOR (3 downto 0);
           floor : out  STD_LOGIC_VECTOR (3 downto 0);
			  up : out std_logic;
			  down : out std_logic
			  );
end component;

component sevenSegDecoder is 
  port(
	i_D  : in std_logic_vector(3 downto 0);
	o_S  : out std_logic_vector(6 downto 0)
  );
end  component;

component synchronizer is
	generic ( constant k_WIDTH : natural := 4); -- # bits in registers
	port ( 	i_clk    : in  std_logic;
			i_reset  : in  std_logic;		   -- asynchronous
			i_D		 : in  std_logic_vector(k_WIDTH - 1 downto 0);
			o_Q      : out std_logic_vector(k_WIDTH - 1 downto 0)
	);
end component;

component clock_divider is
	generic ( constant k_DIV : natural := 12500000	); -- how much you divide clock
	port ( 	i_clk    : in std_logic;
			i_reset  : in std_logic;		   -- asynchronous
			o_clk    : out std_logic		   -- divided (slow) clock
	);
end component;

component TDM4 is
	generic ( constant k_WIDTH : natural  := 4); -- bits in input and output
    Port ( i_CLK     	: in  STD_LOGIC;
           i_RESET	 	: in  STD_LOGIC; -- asynchronous
           i_D3 		: in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
		   i_D2 		: in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
		   i_D1 		: in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
		   i_D0 		: in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
		   o_DATA		: out STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
		   o_SEL		: out STD_LOGIC_VECTOR (3 downto 0)	-- selected data line (one-cold)
	);
end component;

component thunderbird_fsm is
	port(
			i_clk,  i_reset : in  std_logic;
			i_up, i_down : in  std_logic;
			o_lights      : out std_logic_vector(7 downto 0)
		);

end component;

  -- create wires to connect components
  signal w_slow, w_clkRes, w_MooreRes, w_masterRes, w_or_clkRes, w_or_MooreRes, w_go, w_clkTDM, w_up, w_down, w_clkTbird : std_logic;
  signal w_goto, w_floor, w_dig1, w_dig2, w_TDM, w_sel : std_logic_vector(3 downto 0);
  constant k_port_DIV : natural := 12500000;
  constant k_btn_WIDTH : natural := 4;
  constant k_sw_WIDTH : natural :=4;
	

  
begin
	-- PORT MAPS / COMPONENT INSTANTIATION --------------
	
	inst : additionalElevatorController port map(
		reset => w_or_MooreRes,
		clk => w_slow,
		go => w_go,
		goto => w_goto,
		floor => w_floor,
		up => w_up,
		down => w_down
	);
	
	dec_inst : sevenSegDecoder port map(
		i_D => w_TDM,
		o_S => o_sseg
	);
	
	button_inst : synchronizer
	generic map(k_WIDTH => k_btn_WIDTH)
	port map(
		i_clk => i_clk_50MHz,
		i_reset => '0',
		i_D => i_btn,
		o_Q(3) => w_go,
		o_Q(2) => w_clkRes,
		o_Q(1) => w_MooreRes,
		o_Q(0) => w_masterRes
	);
	
	switch_inst : synchronizer 
	generic map(k_WIDTH => k_sw_WIDTH)
	port map(
		i_clk => i_clk_50MHz,
		i_reset => '0',
		i_D => i_sw,
		o_Q => w_goto
	);
	
	clk_inst : clock_divider 
	generic map (k_DIV => k_port_DIV)
	port map(
		i_clk => i_clk_50MHz,
		i_reset => w_or_clkRes,
		o_clk => w_slow
	);
	
	clkTDM_inst : clock_divider 
	generic map (k_DIV => 100000)
	port map(
		i_clk => i_clk_50MHz,
		i_reset => w_masterRes,
		o_clk => w_clkTDM
	);
	
	tdm_inst : TDM4
	generic map (k_WIDTH => 4)
	port map (
	i_CLK => w_clkTDM,
	i_reset => w_masterRes,
	i_D3 => w_dig1,
	i_D2 => w_dig2,
	i_D1 => x"0",
	i_D0 => x"1",
	o_DATA => w_TDM,
	o_SEL => w_sel
	);
	
	clkTBird : clock_divider 
	generic map (k_DIV => 800000)
	port map(
		i_clk => i_clk_50MHz,
		i_reset => w_or_clkRes,
		o_clk => w_clkTbird
	);
	
	
	tbird_inst : thunderbird_fsm
	port map(
			i_clk => w_clkTbird, 
			i_reset => w_masterRes,
			i_up =>  w_up,
			i_down => w_down,
			o_lights => o_led
		);

	
	
	-- CONCURRENT STATEMENTS ----------------------------
	
	w_or_MooreRes <= w_masterRes or w_MooreRes;
	w_or_clkRes <= w_masterRes or w_clkRes;
	w_dig1 <= x"1" when (w_floor > x"8") else x"0";
	w_dig2 <= (w_floor + x"1") when (w_floor < x"9") else
					x"0" when (w_floor = x"9") else
					x"1" when (w_floor = x"A") else
					x"2" when (w_floor = x"B") else
					x"3" when (w_floor = x"C") else
					x"4" when (w_floor = x"D") else
					x"5" when (w_floor = x"E") else
					x"6" when (w_floor = x"F") else
					x"0";
	o_an <= w_SEL;	
	

	
	-- PROCESSES ----------------------------------------



	
end top_nexys2_arch;
