--------------------------------------------------------------------
-- Name:	C2C Mark Demore II
-- Date:	24 Jan 2018
-- Course:	ECE383
-- File:	scopeface.vhdl
-- HW:		Lab 1
--
-- Purp: Make scopeface
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

entity scopeface is
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
end scopeface;

--when (row = 20 or row = 70 or row = 120 or row = 170 or row = 220 or row = 270 or row = 320 or row = 370 or row = 420 
--                             or column = 20 or column = 80 or column = 140 or column = 200 or column = 260 or column = 320 or column = 380 
--                             or column = 440 or column = 500 or column = 560 or column = 620) else x"00";

architecture Behavioral of scopeface is
    
    signal white, yellow, green, hash, grid, black, trigV, trigT, red, blue : std_logic;
    signal cycle, last: unsigned(1 downto 0):= "00";
    signal divider: unsigned(23 downto 0);
    
begin

    process(ch2)
    begin
        if(ch2 = '1') then
            divider <= divider + 1;
        end if;
    end process;
    
    process(divider)
    begin
        if(rising_edge(divider(23))) then
            cycle <= cycle + 1;
        end if;
    end process;   

   --process(row, column, blnk)
    --begin
    
    --white <= '0';
    --yellow <= '0';
    --green <= '0';
    --hash <= '0';
    --grid <= '0';
    
    --trigV <= '1' when ((column = 21 and (row > trigger_volt - 3 and row < trigger_volt +3)) or (column = 22 and (row > trigger_volt - 2 and row < trigger_volt + 2)) 
                --or (column = 23 and row = trigger_volt)) else '0';
                
    --trigT <= '1' when ((row = 21 and (column > trigger_time - 3 and column < trigger_time + 3)) or (row = 22 and (column > trigger_time - 2 and column < trigger_time + 2)) 
                               --or (row = 23 and column = trigger_time)) else '0';                
   
    --grid <= '1' when (row = 20 or row = 70 or row = 120 or row = 170 or row = 220 or row = 270 or row = 320 or row = 370 or row = 420 or column = 20 
                --or column = 80 or column = 140 or column = 200 or column = 260 or column = 320 or column = 380 
                --or column = 440 or column = 500 or column = 560 or column = 620) else '0' ;
   
    
    
        --hash <= '1' when (row < 222 and row > 218 and ((column + 10) mod 15) = 0) or (column < 322 and column > 318 and (row mod 10) = 0) else '0';
    
        --((row + 30) mod 50) = 0 or ((column + 40) mod 60) = 0
    
        blue <= ch1 when cycle = 3 else '0';
        
        yellow <= ch1 when cycle = 2 else '0';
        
        green <= ch1 when cycle = 1 else '0';
        
        red <= ch1 when cycle = 0 else '0';
        
     
    --or column > 420
    -- blank = '1'
    -- column 420
    -- row 620
   black <= '1' when (blnk = '1' or row < 20 or row > 420 or column < 20 or column > 620) else '0';
   
   
        r <= x"00" when black = '1' else x"FF" when (white = '1' or yellow = '1' or red = '1') else x"00";
        g <= x"00" when black = '1' else x"FF" when(white = '1' or yellow = '1' or green = '1') else x"00";
        b <= x"00" when black = '1' else x"FF" when (white = '1' or blue = '1') else x"00";
        
     --end process;
    

    
end Behavioral;
