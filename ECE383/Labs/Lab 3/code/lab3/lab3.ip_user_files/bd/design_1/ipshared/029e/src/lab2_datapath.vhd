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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
	exWrAddr: in std_logic_vector(9 downto 0);
	exWen, exSel: in std_logic;
	Lbus_out, Rbus_out: out std_logic_vector(15 downto 0);
	exLbus, exRbus: in std_logic_vector(15 downto 0);
	flagQ: out std_logic_vector(7 downto 0);
	flagClear: in std_logic_vector(7 downto 0);
	trigger_time : in unsigned(9 downto 0);
    trigger_volt : in unsigned(9 downto 0);
    ready: out std_logic);
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

component flagRegister is
	Generic (N: integer := 8);
	Port(	clk: in  STD_LOGIC;
			reset_n : in  STD_LOGIC;
			set, clear: in std_logic_vector(N-1 downto 0);
			Q: out std_logic_vector(N-1 downto 0));
end component;

signal reddy: std_logic;
signal L_bus_in, L_bus_out, R_bus_in, R_bus_out, toConv : std_logic_vector(17 downto 0);

signal readOutput, writeInput: std_logic_vector(17 downto 0);
signal vecAddrRead, vecAddrWrite: std_logic_vector(9 downto 0);
signal castCol: unsigned (9 downto 0);
signal readCast: unsigned (9 downto 0);
signal reset: std_logic;
signal write_cntr: unsigned(9 downto 0);
signal compareColRead: std_logic;
signal row: unsigned(9 downto 0);

signal clk_div: unsigned(19 downto 0);
--signal trigger_time : unsigned(9 downto 0) := "0010010100";
--signal trigger_volt : unsigned(9 downto 0) := "0011010010";
signal prevL, newL: unsigned(17 downto 0);

signal toStore: unsigned(17 downto 0);
signal wr_enb: std_logic;
signal flagSet: std_logic_vector(7 downto 0);

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
        ch2_wave => '0',
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
        ready => reddy,
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
               WREN => wr_enb); --cw(2)                    -- 1-bit input write port enable
    
    flagger: flagRegister
            port map(
            clk => clk,
            reset_n => reset_n,
            set => flagSet,
            clear => flagClear,
            Q => flagQ);  
    
    process(clk)        --make clock div
    begin
        if(rising_edge(clk)) then
            clk_div <= clk_div + 1;
            if(reddy = '1') then
               newL <= toStore;
            end if;  
        end if;
    end process;
    
    ready <= reddy;
    
--    process(clk_div)        --debounce buttons
--    begin
--        if(rising_edge(clk_div(19))) then
--            if(btn(1) = '1') then
--               trigger_time <= trigger_time - 1;
--            elsif(btn(3) = '1') then
--               trigger_time <= trigger_time + 1;
--            elsif(btn(0) = '1') then
--               trigger_volt <= trigger_volt - 1;
--            elsif(btn(2) = '1') then
--               trigger_volt <= trigger_volt + 1;
--            end if;
--        end if;
--    end process;
    
    process(reddy)      --ready registers
    begin
        if(reddy = '1') then
           prevL <= toStore;
           toConv <= L_bus_out;
        end if;
    end process; 
              
    L_bus_out <= L_bus_in;  --audio loopback
    Lbus_out <= L_bus_in(17 downto 2);   --push out for c
    
    
    R_bus_out <= R_bus_in;
    
    flagSet <= x"0" & "000" & reddy;
    
    toStore <= unsigned(toConv) + "100000000000000000"; -- sign2unsigned
        
    vecAddrWrite <= std_logic_vector(write_cntr)when (exSel = '0') else exWrAddr;
    --vecAddrRead <= std_logic_vector(write_cntr - 1);
    writeInput <= std_logic_vector(toStore) when (exSel = '0') else  exLBus & "00" ;
    
    vecAddrRead <= std_logic_vector(castCol);  -- read from column location    
    
    readCast <= unsigned(readOutput(17 downto 8)); --take top 10 bits        JUST MESSED WITH THIS TO TAKE LOWER 10
    
    compareColRead <= '1' when ((readCast) = row) else '0'; -- if match, print   --readCast-290  JUST TOOK OUT THE MINUS 290
    
    wr_enb <= cw(2) when (exSel = '0') else exWen;
    
    sw(2) <= '1' when (write_cntr = x"3FF") else '0'; --reset
    sw(0) <= reddy; -- sample ready
    sw(1) <= '1'; -- when (prevL < trigger_volt and trigger_volt < newL) else '0'; --trigger
    
    reset <= not reset_n; -- setup reset
    

end Behavioral;
