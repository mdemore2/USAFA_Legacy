----------------------------------------------------------------------------------
--	Put proper documentation here
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity lab1 is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           --left: in std_logic;
           --right: in std_logic;           -- add channels and row column to entity
           --up: in std_logic;
           --down: in std_logic;
           ch1_wave: in std_logic;
           ch2_wave: in std_logic;
			  btn: in	STD_LOGIC_VECTOR(4 downto 0);
			  trigger_time : in unsigned(9 downto 0);
                trigger_volt : in unsigned(9 downto 0);
			  row: out unsigned(9 downto 0);
			  column: out unsigned(9 downto 0);
           tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0));
end lab1;

architecture structure of lab1 is

	--signal row, column: unsigned(9 downto 0);
	--signal trigger_time : unsigned(9 downto 0) := "0000010100";
	--signal trigger_volt : unsigned(9 downto 0) := "0000010100";
	--signal old: unsigned(2 downto 0) := "000";
	--signal old_button, button_activity: std_logic_vector(4 downto 0);
	--signal ch1_wave, ch2_wave: std_logic;
	

	
	component video is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0);
			  trigger_time: in unsigned(9 downto 0);
			  trigger_volt: in unsigned (9 downto 0);
			  row: out unsigned(9 downto 0);
			  column: out unsigned(9 downto 0);
			  ch1: in std_logic;
			  ch1_enb: in std_logic;
			  ch2: in std_logic;
			  ch2_enb: in std_logic);
	end component;
	
	type state_type is (waitC, waitR, move);
        signal state: state_type;

begin


	------------------------------------------------------------------------------
	-- the variable button_activity will contain a '1' in any position which 
	-- has been pressed or released.  The buttons are all nominally 0
	-- and equal to 1 when pressed.
	------------------------------------------------------------------------------
    --button_activity <= btn;

	------------------------------------------------------------------------------
	-- If a button has been pressed then increment of decrement the trigger vars
	------------------------------------------------------------------------------
	--state_process: process(clk, reset_n)
      --  begin
        --    if(rising_edge(clk)) then
          --      if(reset_n = '0') then
             --       state <= waitC;
            --    else
              --      case state is
                --        when waitC =>
                  --          if(C = '1') then state <= waitR; end if;
                    --    when waitR =>
                      --      if(R = '1' or L = '1' or U = '1' or D = '1') then state <= shift; end if;
                     --   when shift =>
                       --     state <= waitC;
            --        end case;
             --   end if;
           -- end if;
       -- end process;
	
	
	
--	process(btn)
--	begin
	
--	if(btn(1) = '1') then
--	   old <= "001";
--	elsif(btn(3) = '1') then
--	   old <= "010";
--	elsif(btn(0) = '1') then
--	   old <= "011";
--	elsif(btn(2) = '1') then
--	   old <= "111";
--	end if;
	
--	if(btn(1) = '1' and old = "001") then
--	   trigger_time <= trigger_time - 1;
--	elsif(btn(3) = '1' and old = "010") then
--	   trigger_time <= trigger_time + 1;
--	elsif(btn(0) = '1' and old = "011") then
--       trigger_volt <= trigger_volt - 1;
--	elsif(btn(2) = '1' and old = "100") then
--       trigger_volt <= trigger_volt + 1;
--	end if;
	
	
	--if(trigger_time < 20 or trigger_time > 620) then
	 --  trigger_time <= "0000010100";
	--end if;
	
	--if(trigger_volt < 20 or trigger_volt > 420) then
	--   trigger_volt <= "0000010100";
	--end if;
--	end process;
	
	
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------
	video_inst: video port map( 
		clk => clk,
		reset_n => reset_n,
		tmds => tmds,
		tmdsb => tmdsb,
		trigger_time => trigger_time,
		trigger_volt => trigger_volt,
		row => row, 
		column => column,
		ch1 => ch1_wave,
		ch1_enb => '1',
		ch2 => ch2_wave,
		ch2_enb => '1'); 

	
end structure;
