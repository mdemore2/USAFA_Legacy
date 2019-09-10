--------------------------------------------------------------------
-- Name:	C2C Mark Demore II
-- Date:	1 Feb 2018
-- Course:	ECE383
-- File:	hw7.vhd
-- HW:		HW7
--
-- Purp:FSM for 2 button debouncing
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hw7 is
    Port (clk: in std_logic;
            reset: in std_logic;
            L: in std_logic;
            R: in std_logic;
            count: out unsigned(3 downto 0));
end hw7;

architecture Behavioral of hw7 is

component counter is
	generic (N: integer := 4);
	Port(	clk: in  STD_LOGIC;
			reset : in  STD_LOGIC;
			ctrl: in std_logic_vector(1 downto 0);
			D: in unsigned (N-1 downto 0);
			Q: out unsigned (N-1 downto 0));
end component;

type state_type is (waitL, waitR, inc);
	signal state: state_type;
	
	signal ctrl: std_logic_vector(1 downto 0);

begin

    theCount: counter
        port map(
            clk => clk,
            reset => reset,
            ctrl => ctrl,
            D => "0000",
            Q => count);

    state_process: process(clk, reset)
    begin
        if(rising_edge(clk)) then
            if(reset = '0') then
                state <= waitL;
            else
                case state is
                    when waitL =>
                        if(L = '1') then state <= waitR; end if;
                    when waitR =>
                        if(R = '1') then state <= inc; end if;
                    when inc =>
                        state <= waitL;
                end case;
            end if;
        end if;
    end process;
    
    ctrl <= "01" when state = inc else "00";
    
    


end Behavioral;
