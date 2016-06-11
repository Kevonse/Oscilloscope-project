--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:40:18 06/09/2016
-- Design Name:   
-- Module Name:   D:/skole/DTU/2. semester/digitalteknik/SigGenTop/SigGenTopTB.vhd
-- Project Name:  SigGenTop
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SigGenTop
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY SigGenTopTB IS
END SigGenTopTB;
 
ARCHITECTURE behavior OF SigGenTopTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SigGenTop
    PORT(
         Reset : IN  std_logic;
         Mclk : IN  std_logic;
         SCK : IN  std_logic;
         SS : IN  std_logic;
         MOSI : IN  std_logic;
         PWMOut : OUT  std_logic;
         MISO : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Reset : std_logic := '0';
   signal Mclk : std_logic := '0';
   signal SCK : std_logic := '0';
   signal SS : std_logic := '0';
   signal MOSI : std_logic := '0';

 	--Outputs
   signal PWMOut : std_logic;
   signal MISO : std_logic;

   -- Clock period definitions
   constant Mclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SigGenTop PORT MAP (
          Reset => Reset,
          Mclk => Mclk,
          SCK => SCK,
          SS => SS,
          MOSI => MOSI,
          PWMOut => PWMOut,
          MISO => MISO
        );

   -- Clock process definitions
   Mclk_process :process
   begin
		Mclk <= '0';
		wait for Mclk_period/2;
		Mclk <= '1';
		wait for Mclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      Reset <= '1';
		wait for 10 ns;	
		Reset <= '0';
      wait for Mclk_period;
		SS <='1';
		SCK <= '0';
		MOSI <= '0';
		wait for Mclk_period;
		SS <='0';
		SCK <= '1';
		MOSI <= '1';
		wait for Mclk_period;
		SS <='0';
		SCK <= '0';
		MOSI <= '1';
		wait for Mclk_period;
		SS <='0';
		SCK <= '1';
		MOSI <= '0';
		wait for Mclk_period;
		SS <='0';
		SCK <= '0';
		MOSI <= '0';
		wait for Mclk_period;
		SS <='0';
		SCK <= '1';
		MOSI <= '1';
		wait for Mclk_period;
		SS <='1';
		SCK <= '0';
		MOSI <= '1';
		      wait for Mclk_period;
		SS <='1';
		SCK <= '1';
		MOSI <= '0';
		      wait for Mclk_period;
		SS <='0';
		SCK <= '0';
		MOSI <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
