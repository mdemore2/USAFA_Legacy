----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/11/2018 09:37:27 PM
-- Design Name: 
-- Module Name: flagRegister - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity flagRegister is
	Generic (N: integer := 8);
	Port(	clk: in  STD_LOGIC;
			reset_n : in  STD_LOGIC;
			set, clear: in std_logic_vector(N-1 downto 0);
			Q: out std_logic_vector(N-1 downto 0));
end flagRegister;

architecture Behavioral of flagRegister is

begin
    
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(reset_n = '1') then
                Q <= x"00";
            elsif(clear = x"01") then
                Q <= x"00";
            elsif (set = x"01") then
                Q <= x"01";
            else
                Q <= x"00";
            end if;
        end if;
    end process;

end Behavioral;
