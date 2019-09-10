--------------------------------------------------------------------
-- Name:	C2C Mark Demore II
-- Date:	22 Jan 2018
-- Course:	ECE383
-- File:	vga.vhdl
-- HW:		Lab 1
--
-- Purp: Make counters and scopefaces
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga is
  Port ( clk: in  STD_LOGIC;
			reset_n : in  STD_LOGIC;
			h_sync : out  STD_LOGIC;
			v_sync : out  STD_LOGIC; 
			blank : out  STD_LOGIC;
			r: out STD_LOGIC_VECTOR(7 downto 0);
			g: out STD_LOGIC_VECTOR(7 downto 0);
			b: out STD_LOGIC_VECTOR(7 downto 0);
			trigger_time: in unsigned(9 downto 0);
			trigger_volt: in unsigned (9 downto 0);
			row: out unsigned(9 downto 0);
			column: out unsigned(9 downto 0);
			ch1: in std_logic;
			ch1_enb: in std_logic;
			ch2: in std_logic;
			ch2_enb: in std_logic);
end vga;

architecture Behavioral of vga is

    component counter is
            port( clk, reset, ctrl: in std_logic;
                roll: out std_logic;
                Q: out unsigned(9 downto 0));
    end component;
    
    component counterVert is 
        port( clk, reset, ctrl: in std_logic;
                    roll: out std_logic;
                    Q: out unsigned(9 downto 0));
    end component;
    
    component scopeface is
        Port ( row : in  unsigned(9 downto 0);
               column : in  unsigned(9 downto 0);
                  trigger_volt: in unsigned (9 downto 0);
                  trigger_time: in unsigned (9 downto 0);
               r : out  std_logic_vector(7 downto 0);
               g : out  std_logic_vector(7 downto 0);
               b : out  std_logic_vector(7 downto 0);
                  ch1: in std_logic;
                  ch1_enb: in std_logic;
                  ch2: in std_logic;
                  ch2_enb: in std_logic;
                  blnk: in std_logic);
    end component;
    
    signal clkIn, resetIn, ctrlIn, roll2ctrl, blanker: std_logic;
    signal hCount, vCount: unsigned(9 downto 0);

begin    

    cntH: counter
        port map(
            clk => clk,
            reset => reset_n,
            ctrl => '1',
            roll => roll2ctrl,
            Q => hCount);
        
    cntV: counterVert
        port map(
            clk => clk,
            reset => reset_n,
             ctrl => roll2ctrl,
            Q => vCount);
     
     scpFace: scopeface
        port map(
            row => vCount,
            column => hCount,
            trigger_volt => trigger_volt,
            trigger_time => trigger_time,
                       r => r,
                       g => g,
                       b => b,
            ch1 => ch1,
            ch1_enb => ch1_enb,
            ch2 => ch2,
            ch2_enb => ch2_enb,
            blnk => blanker);
            
     column <= hCount;
     row <= vCount;
            
     h_sync <= '1' when (hCount < 656 or hCount > 751) else '0';
     v_sync <= '1' when (vCount < 490 or vCount > 491) else '0';
     blanker <= '1' when (hCount > 639 or vCount > 439) else '0';
     blank <= blanker;
                   


end Behavioral;
