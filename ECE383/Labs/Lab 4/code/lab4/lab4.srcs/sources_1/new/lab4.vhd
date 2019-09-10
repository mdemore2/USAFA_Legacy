----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2018 10:25:05 AM
-- Design Name: 
-- Module Name: lab4 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNIMACRO;
use UNIMACRO.VComponents.all;

entity lab4 is
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
end lab4;




architecture Behavioral of lab4 is

component Audio_Codec_Wrapper is
    Port ( clk : in STD_LOGIC;
        reset_n : in STD_LOGIC;
        ac_mclk : out STD_LOGIC;
        ac_adc_sdata : in STD_LOGIC;
        ac_dac_sdata : out STD_LOGIC;
        ac_bclk : out STD_LOGIC;
        ac_lrclk : out STD_LOGIC;
        ready : out STD_LOGIC;
        L_bus_in : in std_logic_vector(17 downto 0); -- left channel input to DAC
        R_bus_in : in std_logic_vector(17 downto 0); -- right channel input to DAC
        L_bus_out : out  std_logic_vector(17 downto 0); -- left channel output from ADC
        R_bus_out : out  std_logic_vector(17 downto 0); -- right channel output from ADC
        scl : inout STD_LOGIC;
        sda : inout STD_LOGIC);
end component;

signal adder1, adder2, adder3, nextaddr, phaseinc, indexoff, subber, nextval, baseval, deltaoff, adder4, switches: unsigned(15 downto 0):= x"0000";
signal multiply: unsigned(31 downto 0):= x"00000000";
signal bout1, bout2: std_logic_vector(15 downto 0):= x"0000";
signal reset, ready: std_logic:='0';
signal L_bus_in, L_bus_out, R_bus_in, R_bus_out :  std_logic_vector(17 downto 0):="00"&x"0000"; -- left channel input to DAC
signal raddr1, raddr2: std_logic_vector(9 downto 0):="00"&x"00";



begin


    blockMem1: BRAM_SDP_MACRO
           generic map (
               BRAM_SIZE => "18Kb",             -- Target BRAM, "18Kb" or "36Kb"
               DEVICE => "7SERIES",             -- Target device: "VIRTEX5", "VIRTEX6", "SPARTAN6, 7SERIES"
               DO_REG => 0,                     -- Optional output register disabled
               INIT => X"000000000000000000",    -- Initial values on output port
               INIT_FILE => "NONE",            -- Not sure how to initialize the RAM from a file
               WRITE_WIDTH => 16,                 -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
               READ_WIDTH => 16,                 -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
               SIM_COLLISION_CHECK => "NONE",             -- Collision check enable "ALL", "WARNING_ONLY", "GENERATE_X_ONLY" or "NONE"
               SRVAL => X"000000000000000000",          -- Set/Reset value for port output
               INIT_00 => X"55F551334C3F471C41CE3C5636BA30FB2B1F25281F1A18F912C80C8C06480000",
               INIT_01 => X"7FD87F617E9C7D897C297A7C7884764173B570E26DC96A6D66CF62F15ED75A82",
               INIT_02 => X"5ED762F166CF6A6D6DC970E273B5764178847A7C7C297D897E9C7F617FD87FFF",
               INIT_03 => X"06480C8C12C818F91F1A25282B1F30FB36BA3C5641CE471C4C3F513355F55A82",
               INIT_04 => X"AA0BAECDB3C1B8E4BE32C3AAC946CF05D4E1DAD8E0E6E707ED38F374F9B80000",
               INIT_05 => X"8028809F8164827783D78584877C89BF8C4B8F1E9237959399319D0FA129A57E",
               INIT_06 => X"A1299D0F9931959392378F1E8C4B89BF877C858483D782778164809F80288001",
               INIT_07 => X"F9B8F374ED38E707E0E6DAD8D4E1CF05C946C3AABE32B8E4B3C1AECDAA0BA57E")
           port map (
               DO => bout1,                -- Output read data port, width defined by READ_WIDTH parameter
               RDADDR => raddr1,            -- Input address, width defined by port depth
               RDCLK => clk,                     -- 1-bit input clock
               RST => reset,                    -- active high reset
               RDEN => '1',                    -- read enable 
               REGCE => '1',                    -- 1-bit input read output register enable - ignored
               DI => x"0000",                -- Input data port, width defined by WRITE_WIDTH parameter
               WE => "00",            -- since RAM is byte read, this determines high or low byte
               WRADDR => "0000000000",            -- Input write address, width defined by write port depth
               WRCLK => clk,                     -- 1-bit input write clock
               WREN => '0'); --cw(2)                    -- 1-bit input write port enable


 blockMem2: BRAM_SDP_MACRO
           generic map (
               BRAM_SIZE => "18Kb",             -- Target BRAM, "18Kb" or "36Kb"
               DEVICE => "7SERIES",             -- Target device: "VIRTEX5", "VIRTEX6", "SPARTAN6, 7SERIES"
               DO_REG => 0,                     -- Optional output register disabled
               INIT => X"000000000000000000",    -- Initial values on output port
               INIT_FILE => "NONE",            -- Not sure how to initialize the RAM from a file
               WRITE_WIDTH => 16,                 -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
               READ_WIDTH => 16,                 -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
               SIM_COLLISION_CHECK => "NONE",             -- Collision check enable "ALL", "WARNING_ONLY", "GENERATE_X_ONLY" or "NONE"
               SRVAL => X"000000000000000000",          -- Set/Reset value for port output
               INIT_00 => X"55F551334C3F471C41CE3C5636BA30FB2B1F25281F1A18F912C80C8C06480000",
               INIT_01 => X"7FD87F617E9C7D897C297A7C7884764173B570E26DC96A6D66CF62F15ED75A82",
               INIT_02 => X"5ED762F166CF6A6D6DC970E273B5764178847A7C7C297D897E9C7F617FD87FFF",
               INIT_03 => X"06480C8C12C818F91F1A25282B1F30FB36BA3C5641CE471C4C3F513355F55A82",
               INIT_04 => X"AA0BAECDB3C1B8E4BE32C3AAC946CF05D4E1DAD8E0E6E707ED38F374F9B80000",
               INIT_05 => X"8028809F8164827783D78584877C89BF8C4B8F1E9237959399319D0FA129A57E",
               INIT_06 => X"A1299D0F9931959392378F1E8C4B89BF877C858483D782778164809F80288001",
               INIT_07 => X"F9B8F374ED38E707E0E6DAD8D4E1CF05C946C3AABE32B8E4B3C1AECDAA0BA57E")
           port map (
               DO => bout2,                -- Output read data port, width defined by READ_WIDTH parameter
               RDADDR => raddr2,            -- Input address, width defined by port depth
               RDCLK => clk,                     -- 1-bit input clock
               RST => reset,                    -- active high reset
               RDEN => '1',                    -- read enable 
               REGCE => '1',                    -- 1-bit input read output register enable - ignored
               DI => x"0000",                -- Input data port, width defined by WRITE_WIDTH parameter
               WE => "00",            -- since RAM is byte read, this determines high or low byte
               WRADDR => "0000000000",            -- Input write address, width defined by write port depth
               WRCLK => clk,                     -- 1-bit input write clock
               WREN => '0'); --cw(2)                    -- 1-bit input write port enable

     audioWrapper: Audio_Codec_Wrapper
        port map(
        clk => clk,
        reset_n => reset_n,
        ac_mclk => ac_mclk,
        ac_adc_sdata => ac_adc_sdata,
        ac_dac_sdata => ac_dac_sdata,
        ac_bclk => ac_bclk,
        ac_lrclk => ac_lrclk,
        ready => ready,
        L_bus_in => L_bus_in,
        R_bus_in => R_bus_in,
        L_bus_out => L_bus_out,
        R_bus_out => R_bus_out,
        scl => scl,
        sda => sda);
        
        
        switches <= x"00" & unsigned(sw(7 downto 0));
        
         adder1 <= phaseinc + switches;
         adder2 <= phaseinc + indexoff;
         adder3 <= indexoff + 1;
         subber <= nextval - baseval;
         multiply <= indexoff * subber;
         adder4 <= deltaoff + baseval;
         
        process(clk)        
            begin
                if(rising_edge(clk)) then
                   phaseinc <= adder1;
                   indexoff <= adder2;
                   nextaddr <= adder3;
                   deltaoff <= multiply(31 downto 16);
                   nextval <= unsigned(bout1);
                   baseval <= unsigned(bout2);
                end if;
            end process;
            
<<<<<<< HEAD
        L_bus_in <= "00" & std_logic_vector(baseval);    

        reset <= not reset_n;
        
        raddr1 <= "000" & std_logic_vector(indexoff(15 downto 9));
=======
        --unsign2sign <= baseval - "1000000000000000";
        --L_bus_out <= test;
        L_bus_in <= bout1 & "00";
        test <= std_logic_vector(baseval - deltaoff) & "00";

        reset <= not reset_n;
                
         raddr1 <= "000" & std_logic_vector(phaseinc(15 downto 9));
        --raddr1 <= "000" & std_logic_vector(indexoff(15 downto 9));
>>>>>>> master
        raddr2 <= "000" & std_logic_vector(nextaddr(15 downto 9));
        
        
end Behavioral;