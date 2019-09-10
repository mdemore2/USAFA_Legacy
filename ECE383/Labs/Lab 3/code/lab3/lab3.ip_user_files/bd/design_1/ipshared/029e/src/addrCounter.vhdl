--------------------------------------------------------------------
-- Name:	C2C Mark Demore II
-- Date:	22 Jan 2018
-- Course:	ECE383
-- File:	counter.vhdl
-- HW:		Lab 1
--
-- Purp: Make counters
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

entity addrCounter is
  Port ( clk, reset: in std_logic;
               ctrl: in std_logic_vector(1 downto 0); -- 11 = count 10 = reset
               roll: out std_logic;
               Q: out unsigned(9 downto 0) );
end addrCounter;

architecture Behavioral of addrCounter is
    signal processQ: unsigned(9 downto 0);

begin
    process(clk)
    begin
    
        if(rising_edge(clk)) then
            if (reset = '0') then
                processQ <= (others => '0');
            elsif (ctrl = "11") then
                if(processQ < 1023) then
                    processQ <= processQ + 1;
                else
                    processQ <= (others => '0');
                end if;
            elsif (ctrl = "10") then
                processQ <= (others => '0');
            end if;
        end if;
     end process;

        roll <= '1' when (processQ = 1023) else '0';
        Q <= processQ;


end Behavioral;
