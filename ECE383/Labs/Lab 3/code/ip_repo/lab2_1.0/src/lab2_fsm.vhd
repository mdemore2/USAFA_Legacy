----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2018 10:59:49 AM
-- Design Name: 
-- Module Name: lab2_fsm - Behavioral
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

entity lab2_fsm is
  Port (clk : in  STD_LOGIC;
		reset_n : in  STD_LOGIC;
		sw : in std_logic_vector(2 downto 0);
		cw: out std_logic_vector (2 downto 0) );
end lab2_fsm;

architecture Behavioral of lab2_fsm is

type state_type is (RST, WAIT_TRIGGER, STORE_SAMPLE, WAIT_SAMPLE);
	signal state: state_type;

begin

    state_process: process(clk, reset_n)
    begin                       
        if(rising_edge(clk)) then
            if(reset_n = '0') then
                state <= RST;
            else
                if (sw(2) = '1') then
                    state <= RST;
                elsif(sw(1) = '1') then
                    state <= WAIT_SAMPLE;
                    if (sw(0) = '1' and state = WAIT_SAMPLE) then
                        state <= STORE_SAMPLE;
                    else
                        state <= WAIT_SAMPLE;
                    end if;
                else
                    state <= WAIT_TRIGGER;
                end if;
            end if;
        end if;
    end process;
    
    cw <= "010" when (state = RST) else 
        "111" when (state = STORE_SAMPLE) 
        else "011";



-- cw
--cw(2) = '1' when sw(0) = '1'
--cw(1 downto 0) = "10" when sw(2) = '1'
-- sw(1) = trigger, not there yet

end Behavioral;
