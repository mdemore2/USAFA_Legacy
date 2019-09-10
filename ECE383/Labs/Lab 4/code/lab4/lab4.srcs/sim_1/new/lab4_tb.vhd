----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2018 11:19:46 AM
-- Design Name: 
-- Module Name: lab4_tb - Behavioral
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

entity lab4_tb is
--  Port ( );
end lab4_tb;

architecture Behavioral of lab4_tb is

component lab4
  Port (
      clk: in std_logic;
      reset_n: in std_logic;
      ac_mclk : out STD_LOGIC;
      ac_adc_sdata : in STD_LOGIC;
      ac_dac_sdata : out STD_LOGIC;
      ac_bclk : out STD_LOGIC;
      ac_lrclk : out STD_LOGIC;
      scl : inout STD_LOGIC;
      sda : inout STD_LOGIC;
      btn: in std_logic_vector(4 downto 0);
      sw: in std_logic_vector(7 downto 0));
 end component;
 
  --Inputs
   signal clk : std_logic := '0';
   signal reset_n : std_logic := '0';
   signal ac_adc_sdata : std_logic := '0';
   signal sda : std_logic := '0';
   signal BIT_CLK : std_logic := '0';
   signal btn : std_logic_vector(4 downto 0) := (others => '0');
 
 --Outputs
      signal ac_mclk : std_logic;
      signal ac_dac_sdata : std_logic;
      signal ac_bclk : std_logic;
      signal ac_lrclk : std_logic;
      signal scl : std_logic;
   --   signal AC97_n_RESET : std_logic;
     
      signal sw : std_logic_vector(7 downto 0);
      signal Lbus_out : std_logic_vector(15 downto 0);
      signal Rbus_out : std_logic_vector(15 downto 0);
      
       -- Clock period definitions
        constant clk_period : time := 10 ns;  -- Sets clock to ~ 100MHz
     --   constant BIT_CLK_period : time := 80 ns;  -- Sets Bit Clock for AC'97 to the necessary 12.288 MHz
        constant BIT_CLK_period : time := 40 ns;  -- Sets Bit Clock for Audio Codec to the necessary 25 MHz
 
begin

    uut: lab4
    Port map (
          clk => clk,
          reset_n => reset_n,
          ac_mclk => ac_mclk,
          ac_adc_sdata => ac_adc_sdata,
          ac_dac_sdata => ac_dac_sdata,
          ac_bclk => ac_bclk,
          ac_lrclk => ac_lrclk,
          scl => scl,
          sda => sda,
          btn => btn,
          sw => sw);


    -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
   
   SDATA_process :process  -- Inputs alternating 1's and 0's on each Bit Clock
       begin
            ac_adc_sdata <= '0';
            wait for BIT_CLK_period;
            ac_adc_sdata <= '1';
            wait for BIT_CLK_period*2;
       end process;
       
         -- Stimulus process
        stim_proc: process 
        begin        
           -- hold reset state for 100 ns.
             reset_n <= '0', '1' after 100 ns;
             sw(7 downto 0) <= "00001001";
                 -- insert stimulus here 
             wait;
        end process;
 

end Behavioral;