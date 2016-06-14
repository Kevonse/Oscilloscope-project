--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:25:33 06/14/2016
-- Design Name:   
-- Module Name:   C:/Users/Skrum_000/OneDrive/DTU/2. semester/Digitalteknik/Oscilloskop_projekt/DatapathTB.vhd
-- Project Name:  Oscilloskop_projekt
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SigGenDatapath
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
 
ENTITY DatapathTB IS
END DatapathTB;
 
ARCHITECTURE behavior OF DatapathTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SigGenDatapath
    PORT(
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         SigEN : IN  std_logic;
         Shape : IN  std_logic_vector(1 downto 0);
         Ampl : IN  std_logic_vector(7 downto 0);
         Freq : IN  std_logic_vector(7 downto 0);
         PWMOut : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
   signal SigEN : std_logic := '0';
   signal Shape : std_logic_vector(1 downto 0) := (others => '0');
   signal Ampl : std_logic_vector(7 downto 0) := (others => '0');
   signal Freq : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal PWMOut : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SigGenDatapath PORT MAP (
          Reset => Reset,
          Clk => Clk,
          SigEN => SigEN,
          Shape => Shape,
          Ampl => Ampl,
          Freq => Freq,
          PWMOut => PWMOut
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		Reset <= '1';
		SigEn <= '0';
      wait for Clk_period*10;
		Reset <= '0';
      -- insert stimulus here
		wait for Clk_period*3;
		Shape <= "01";
		Ampl <= "00000001";
		Freq <= "01111111";
		wait for Clk_period*3;
		SigEn <= '1';
		wait for Clk_period*100;
		SigEn <= '0';
		
		

      wait;
   end process;

END;
