----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2018 10:56:08 AM
-- Design Name: 
-- Module Name: lab2_datapath - Behavioral
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
library UNIMACRO;		-- This contains links to the Xilinx block RAM
	use UNIMACRO.vcomponents.all;
	
	
    use IEEE.STD_LOGIC_UNSIGNED.ALL;
    
    use work.lab2Parts.all;        


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity lab2_datapath is
    Port(
	clk : in  STD_LOGIC;
	reset_n : in  STD_LOGIC;
	ac_mclk : out STD_LOGIC;
	ac_adc_sdata : in STD_LOGIC;
	ac_dac_sdata : out STD_LOGIC;
	ac_bclk : out STD_LOGIC;
	ac_lrclk : out STD_LOGIC;
	scl : inout STD_LOGIC;
	sda : inout STD_LOGIC;	
	tmds : out  STD_LOGIC_VECTOR (3 downto 0);
	tmdsb : out  STD_LOGIC_VECTOR (3 downto 0);
	sw: out std_logic_vector(2 downto 0); -- bit 2 = counter rollover, bit 1 = trigger, bit 0 = sample
	cw: in std_logic_vector (2 downto 0);  -- bit 2 = write enable, bit 1-0 = counter control
	btn: in	STD_LOGIC_VECTOR(4 downto 0);
	switch: in std_logic;
	exWrAddr: in std_logic_vector(9 downto 0);
	exWen, exSel: in std_logic;
	Lbus_out, Rbus_out: out std_logic_vector(15 downto 0);
	exLbus, exRbus: in std_logic_vector(15 downto 0);
	flagQ: out std_logic_vector(7 downto 0);
	flagClear: in std_logic_vector(7 downto 0));
end lab2_datapath;

architecture Behavioral of lab2_datapath is

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

component lab1 is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           --left: in std_logic;
           --right: in std_logic;
           --up: in std_logic;
           --down: in std_logic;
			 ch1_wave: in std_logic;
             ch2_wave: in std_logic;
             btn: in    STD_LOGIC_VECTOR(4 downto 0);
             trigger_time : in unsigned(9 downto 0);
             trigger_volt : in unsigned(9 downto 0);
             row: out unsigned(9 downto 0);
             column: out unsigned(9 downto 0);
           tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component addrCounter is
  Port ( clk, reset: in std_logic;
               ctrl: in std_logic_vector(1 downto 0);
               roll: out std_logic;
               Q: out unsigned(9 downto 0) );
end component;



signal ready: std_logic;
signal L_bus_in, L_bus_out, R_bus_in, R_bus_out : std_logic_vector(17 downto 0);

signal readOutput, writeInput: std_logic_vector(17 downto 0);
signal vecAddrRead, vecAddrWrite: std_logic_vector(9 downto 0);
signal castCol: unsigned (9 downto 0);
signal readCast: unsigned (17 downto 0);
signal reset: std_logic;
signal write_cntr: unsigned(9 downto 0);
signal compareColRead: std_logic;
signal row: unsigned(9 downto 0);

signal clk_div: unsigned(23 downto 0);
signal trigger_time : unsigned(9 downto 0) := "0000010100";
signal trigger_volt : unsigned(9 downto 0) := "0011010010";
signal prevL, newL: unsigned(17 downto 0);

signal toStore: unsigned(17 downto 0);

--voice stripping signals
signal Radc, Ladc:  STD_LOGIC_VECTOR (17 downto 0);
signal R_done, L_done: std_logic;
signal Radc_lpf1000, Ladc_lpf1000: STD_LOGIC_VECTOR (17 downto 0);
signal l_r, r_l: STD_LOGIC_VECTOR (17 downto 0);
signal L_amp, R_amp: std_logic_vector(17 downto 0);

-- plotting signals
signal sum, s170, s340, s510, s680, s850, s1020, last: unsigned(17 downto 0) := x"0000" & "11";

signal cycle: std_logic;

begin

    adCount: addrCounter
        port map(
              clk=> clk,
              reset => reset_n,
              ctrl => cw(1 downto 0),
              Q => write_cntr);
    firstLab: lab1
        port map (
        clk => clk,
        reset_n => reset_n,
        ch1_wave => compareColRead,
        ch2_wave => cycle,
        btn => btn,
        trigger_time => trigger_time,
        trigger_volt => trigger_volt,
        row => row,
        column => castCol,
        tmds => tmds,
        tmdsb => tmdsb);
        
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
     
    blockMem: BRAM_SDP_MACRO
           generic map (
               BRAM_SIZE => "18Kb",             -- Target BRAM, "18Kb" or "36Kb"
               DEVICE => "7SERIES",             -- Target device: "VIRTEX5", "VIRTEX6", "SPARTAN6, 7SERIES"
               DO_REG => 0,                     -- Optional output register disabled
               INIT => X"000000000000000000",    -- Initial values on output port
               INIT_FILE => "NONE",            -- Not sure how to initialize the RAM from a file
               WRITE_WIDTH => 18,                 -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
               READ_WIDTH => 18,                 -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
               SIM_COLLISION_CHECK => "NONE",             -- Collision check enable "ALL", "WARNING_ONLY", "GENERATE_X_ONLY" or "NONE"
               SRVAL => X"000000000000000000")    -- Set/Reset value for port output
           port map (
               DO => readOutput,                -- Output read data port, width defined by READ_WIDTH parameter
               RDADDR => vecAddrRead,            -- Input address, width defined by port depth
               RDCLK => clk,                     -- 1-bit input clock
               RST => reset,                    -- active high reset
               RDEN => '1',                    -- read enable 
               REGCE => '1',                    -- 1-bit input read output register enable - ignored
               DI => writeInput,                -- Input data port, width defined by WRITE_WIDTH parameter
               WE => "11",            -- since RAM is byte read, this determines high or low byte
               WRADDR => vecAddrWrite,            -- Input write address, width defined by write port depth
               WRCLK => clk,                     -- 1-bit input write clock
               WREN => cw(2)); --cw(2)                    -- 1-bit input write port enable
               
    left_filter_lpf500: entity work.IIR_Biquad(arch)
                       generic map(
                           Coef_b0 => B"00_00_0000_0000_0010_1100_0001_1001_0000",    -- +0.00016822    
                           Coef_b1 => B"00_00_0000_0000_0101_1000_0011_0010_1100",    -- +0.00033645   
                           Coef_b2 => B"00_00_0000_0000_0010_1100_0001_1001_0000",    -- +0.00016822    
                           Coef_a1 => B"10_00_0010_0101_1110_1000_1000_1100_0011",    -- -1.962980089    
                           Coef_a2 => B"00_11_1101_1010_1100_0111_1101_1001_0000")    -- +0.963652984
                       port map (
                           clk => clk,             -- Normal 100Mhz clock
                           n_reset => reset,         -- Our normal active low reset
                           sample_trig => ready,         -- This is the ready signal from the AC'97 wrapper
                           X_in => Ladc,             -- The adc output from the ac'97 wrapper
                           filter_done => L_done,         -- A status signal from the filter block
                           Y_out => Ladc_lpf1000);        -- The 18-bit filtered output
                           
        right_filter_lpf500: entity work.IIR_Biquad(arch)
                           generic map(
                               Coef_b0 => B"00_00_0000_0000_0010_1100_0001_1001_0000",    -- +0.00016822    
                               Coef_b1 => B"00_00_0000_0000_0101_1000_0011_0010_1100",    -- +0.00033645   
                               Coef_b2 => B"00_00_0000_0000_0010_1100_0001_1001_0000",    -- +0.00016822    
                               Coef_a1 => B"10_00_0010_0101_1110_1000_1000_1100_0011",    -- -1.962980089    
                               Coef_a2 => B"00_11_1101_1010_1100_0111_1101_1001_0000")    -- +0.963652984
                           port map (
                               clk => clk,             -- Normal 100Mhz clock
                               n_reset => reset,         -- Our normal active low reset
                               sample_trig => ready,         -- This is the ready signal from the AC'97 wrapper
                               X_in => Radc,             -- The adc output from the ac'97 wrapper
                               filter_done => R_done,         -- A status signal from the filter block
                               Y_out => Radc_lpf1000);        -- The 18-bit filtered output
      
    
    process(clk)
    begin
        if(rising_edge(clk)) then
            clk_div <= clk_div + 1;
            if(ready = '1') then
               newL <= toStore;
            end if;
            if(vecAddrRead > 1020) then
                --last <= x"0000" & "00";
                sum <= x"0000" & "00";
            else
                --last <= sum;
                sum <= sum + unsigned(readOutput);
            end if;
--            if(vecAddrRead < 171) then
--                s170 <= sum;
--                s340 <= sum;
--                s510 <= sum;
--                s680 <= sum;
--                s850 <= sum;
--                s1020 <= sum;    
--            elsif (vecAddrRead < 341) then
--                s170 <= s170;
--                s340 <= sum;
--                s510 <= sum;
--                s680 <= sum;
--                s850 <= sum;
--                s1020 <= sum;
--            elsif (vecAddrRead < 511) then
--                s170 <= s170;
--                s340 <= s340;
--                s510 <= sum;
--                s680 <= sum;
--                s850 <= sum;
--                s1020 <= sum; 
--            elsif (vecAddrRead < 681) then
--                s170 <= s170;
--                s340 <= s340;
--                s510 <= s510;
--                s680 <= sum;
--                s850 <= sum;
--                s1020 <= sum;
--            elsif (vecAddrRead < 851) then
--                s170 <= s170;
--                s340 <= s340;
--                s510 <= s510;
--                s680 <= s680;
--                s850 <= sum;
--                s1020 <= sum;
--            elsif (vecAddrRead < 1021) then
--                s170 <= s170;
--                s340 <= s340;
--                s510 <= s510;
--                s680 <= s680;
--                s850 <= s850;
--                s1020 <= sum;        
--            else
--                s170 <= s170;
--                s340 <= s340;
--                s510 <= s510;
--                s680 <= s680;
--                s850 <= s850;
--                s1020 <= s1020;                 
--            end if;   
--            s170 <= sum when (vecAddrRead < 171) else s170;
--            s340 <= sum when (vecAddrRead < 341) else s340;
--            s510 <= sum when (vecAddrRead < 511) else s510;
--            s680 <= sum when (vecAddrRead < 681) else s680;
--            s850 <= sum when (vecAddrRead < 851) else s850;
--            s1020 <= sum when (vecAddrRead < 1021) else s1020;
        end if;
    end process;
    
    --monitor refresh rate = 200Hz - should only need 19bit clock div to match from 100MHz
    
    process(clk_div)
    begin
        if(rising_edge(clk_div(21))) then
         if(vecAddrRead < 171) then
                       s170 <= sum;
                       s340 <= sum;
                       s510 <= sum;
                       s680 <= sum;
                       s850 <= sum;
                       s1020 <= sum;    
                   elsif (vecAddrRead < 341) then
                       s170 <= s170;
                       s340 <= sum;
                       s510 <= sum;
                       s680 <= sum;
                       s850 <= sum;
                       s1020 <= sum;
                   elsif (vecAddrRead < 511) then
                       s170 <= s170;
                       s340 <= s340;
                       s510 <= sum;
                       s680 <= sum;
                       s850 <= sum;
                       s1020 <= sum; 
                   elsif (vecAddrRead < 681) then
                       s170 <= s170;
                       s340 <= s340;
                       s510 <= s510;
                       s680 <= sum;
                       s850 <= sum;
                       s1020 <= sum;
                   elsif (vecAddrRead < 851) then
                       s170 <= s170;
                       s340 <= s340;
                       s510 <= s510;
                       s680 <= s680;
                       s850 <= sum;
                       s1020 <= sum;
                   elsif (vecAddrRead < 1021) then
                       s170 <= s170;
                       s340 <= s340;
                       s510 <= s510;
                       s680 <= s680;
                       s850 <= s850;
                       s1020 <= sum;        
                   else
                       s170 <= s170;
                       s340 <= s340;
                       s510 <= s510;
                       s680 <= s680;
                       s850 <= s850;
                       s1020 <= s1020;                 
                   end if;   
--            if(btn(1) = '1') then
--               trigger_time <= trigger_time - 1;
--            elsif(btn(3) = '1') then
--               trigger_time <= trigger_time + 1;
--            elsif(btn(0) = '1') then
--               trigger_volt <= trigger_volt - 1;
--            elsif(btn(2) = '1') then
--               trigger_volt <= trigger_volt + 1;
--            end if;
          if(ready = '1') then
            prevL <= toStore;
          end if;  
        end if;
    end process;
    
              
    
    Ladc <= L_bus_out;
        Radc <= R_bus_out;
    
        l_r <= std_logic_vector(unsigned(L_bus_out) - unsigned(R_bus_out));
        r_l <= std_logic_vector(unsigned(R_bus_out) - unsigned(L_bus_out));
                  
        L_amp <= std_logic_vector(unsigned(Ladc_lpf1000) + unsigned(l_r));
        R_amp <= std_logic_vector(unsigned(Radc_lpf1000) + unsigned(r_l));
        
        L_bus_in <= L_amp(17 downto 2) & "00" when (switch = '0') else L_bus_out;
        R_bus_in <= R_amp(17 downto 2) & "00" when (switch = '0') else R_bus_out;
    
    toStore <= unsigned(L_bus_out) + "100000000000000000"; -- sign2unsigned
        
    vecAddrWrite <= std_logic_vector(write_cntr);
    --vecAddrRead <= std_logic_vector(write_cntr - 1);
    writeInput <= std_logic_vector(toStore);
    
    vecAddrRead <= std_logic_vector(castCol);
    --"00" & x"0F" when (castCol < 100) else "00" & x"FF" when (castCol < 200) else "0101110110" when (castCol < 300) else "0110101110" when (castCol < 400) else "00" & x"17" when (castCol < 500) else "00" & x"0A";  -- read from column location    
        
    readCast <= (s170/170) when (castCol < 120) else (s340/340) when (castCol < 220) else (s510/510) when (castCol < 320) else (s680/680) when (castCol < 420) else (s850/850) when (castCol < 520) else (s1020/1020);
    --unsigned(readOutput(17 downto 8)); --take top 10 bits
    cycle <= '1' when ((s510/510) > 500) else '0';
    
    compareColRead <= '1' when (400 - ((readCast(9 downto 0)/2)) <= row) else '0'; -- if match, print   --readCast-290
    --should probably make this like -500 or something???
    --maybe even 600-readcast
    --maybe even take upper bits now??
    sw(2) <= '1' when (write_cntr = x"3FF") else '0'; --reset
    sw(0) <= ready; -- sample ready
    sw(1) <= '1' when (prevL < trigger_volt and trigger_volt < newL) else '0'; --trigger
    
    reset <= not reset_n; -- setup reset

end Behavioral;