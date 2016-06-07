--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:27:15 06/07/2016
-- Design Name:   
-- Module Name:   C:/Users/Skrum_000/OneDrive/DTU/2. semester/Digitalteknik/Oscilloskop_projekt/shiftregTB.vhd
-- Project Name:  Oscilloskop_projekt
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: shiftreg
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
 
ENTITY shiftregTB IS
END shiftregTB;
 
ARCHITECTURE behavior OF shiftregTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT shiftreg
    PORT(
         reset : IN  std_logic;
         SCK : IN  std_logic;
         Mclk : IN  std_logic;
         MOSI : IN  std_logic;
         SS : IN  std_logic;
         LED : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal SCK : std_logic := '0';
   signal Mclk : std_logic := '0';
   signal MOSI : std_logic := '0';
   signal SS : std_logic := '0';

 	--Outputs
   signal LED : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant Mclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: shiftreg PORT MAP (
          reset => reset,
          SCK => SCK,
          Mclk => Mclk,
          MOSI => MOSI,
          SS => SS,
          LED => LED
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
      wait for 100 ns;	

      wait for Mclk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;