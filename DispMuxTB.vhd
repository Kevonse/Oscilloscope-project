--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:48:56 06/17/2016
-- Design Name:   
-- Module Name:   C:/Users/Skrum_000/OneDrive/DTU/2. semester/Digitalteknik/Oscilloskop_projekt/DispMuxTB.vhd
-- Project Name:  Oscilloskop_projekt
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DispMux
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
 
ENTITY DispMuxTB IS
END DispMuxTB;
 
ARCHITECTURE behavior OF DispMuxTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DispMux
    PORT(
         Reset : IN  std_logic;
         Mclk : IN  std_logic;
         ShapeDisp : IN  std_logic_vector(1 downto 0);
         AmplDisp : IN  std_logic_vector(7 downto 0);
         FreqDisp : IN  std_logic_vector(7 downto 0);
         OK_cnt : IN  std_logic_vector(19 downto 0);
         DispOut : OUT  std_logic_vector(19 downto 0);
         Switch : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Reset : std_logic := '0';
   signal Mclk : std_logic := '0';
   signal ShapeDisp : std_logic_vector(1 downto 0) := (others => '0');
   signal AmplDisp : std_logic_vector(7 downto 0) := (others => '0');
   signal FreqDisp : std_logic_vector(7 downto 0) := (others => '0');
   signal OK_cnt : std_logic_vector(19 downto 0) := (others => '0');
   signal Switch : std_logic := '0';

 	--Outputs
   signal DispOut : std_logic_vector(19 downto 0);

   -- Clock period definitions
   constant Mclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DispMux PORT MAP (
          Reset => Reset,
          Mclk => Mclk,
          ShapeDisp => ShapeDisp,
          AmplDisp => AmplDisp,
          FreqDisp => FreqDisp,
          OK_cnt => OK_cnt,
          DispOut => DispOut,
          Switch => Switch
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
		OK_cnt <= X"00000"; --Not relevant in this simulation there just set to 0.
      wait for Mclk_period*5;
		Reset <= '0';
		wait for Mclk_period*3;
      -- Legal, random values used.
		ShapeDisp <= "01";
		AmplDisp <= "01111111";
		FreqDisp <= "11111111";
		wait for Mclk_period*3;
		Switch <= '1';
		wait for Mclk_period*3;
		Switch <= '0';
		wait for Mclk_period*3;
		Switch <= '1';
		wait for Mclk_period*3;
		Switch <= '0';
		
		

      wait;
   end process;

END;
