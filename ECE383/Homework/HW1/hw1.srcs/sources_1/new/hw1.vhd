----------------------------------------------------------------------------------
-- Company: USAFA ECE
-- Engineer: Mark Demore II
-- 
-- Create Date: 01/08/2018 09:47:33 PM
-- Design Name: HW1
-- Module Name: hw1 - Behavioral
-- Project Name: HW1
-- Target Devices: Nexys Video
-- Tool Versions: 
-- Description: output is binary encoded location of most significant 1 of input
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

entity hw1 is
  Port (i0, i1, i2, i3: in std_logic;
        o0, o1: out std_logic );
end hw1;

architecture structure of hw1 is

begin

    o0 <= i1;
    o1 <= i2 or i3;

end structure;
