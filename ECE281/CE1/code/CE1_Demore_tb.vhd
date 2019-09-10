-- Vhdl test bench created from schematic C:\Users\C19Mark.Demore\Documents\ECE281_Repo\CE1\code\Demore_CE1_top.sch - Thu Jan 12 23:18:19 2017
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY Demore_CE1_top_Demore_CE1_top_sch_tb IS
END Demore_CE1_top_Demore_CE1_top_sch_tb;
ARCHITECTURE behavioral OF Demore_CE1_top_Demore_CE1_top_sch_tb IS 

   COMPONENT Demore_CE1_top
   PORT( led0	:	OUT	STD_LOGIC; 
          sw7	:	IN	STD_LOGIC; 
          sw5	:	IN	STD_LOGIC; 
          sw6	:	IN	STD_LOGIC);
   END COMPONENT;

   SIGNAL led0	:	STD_LOGIC;
   SIGNAL sw7	:	STD_LOGIC;
   SIGNAL sw5	:	STD_LOGIC;
   SIGNAL sw6	:	STD_LOGIC;

BEGIN

   UUT: Demore_CE1_top PORT MAP(
		led0 => led0, 
		sw7 => sw7, 
		sw5 => sw5, 
		sw6 => sw6
   );

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
	BEGIN
	
	sw7 <= '0'; sw6 <= '0'; sw5 <= '0';
      WAIT for 10 ns;
		
	sw7 <= '0'; sw6 <= '0'; sw5 <= '1';
      WAIT for 10 ns;
		
	sw7 <= '0'; sw6 <= '1'; sw5 <= '0';
      WAIT for 10 ns;
		
	sw7 <= '0'; sw6 <= '1'; sw5 <= '1';
      WAIT for 10 ns;
		
	sw7 <= '1'; sw6 <= '0'; sw5 <= '0';
      WAIT for 10 ns;
		
	sw7 <= '1'; sw6 <= '0'; sw5 <= '1';
      WAIT for 10 ns;
		
	sw7 <= '1'; sw6 <= '1'; sw5 <= '0';
      WAIT for 10 ns;
		
	sw7 <= '1'; sw6 <= '1'; sw5 <= '1';
      WAIT for 10 ns;
		
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
