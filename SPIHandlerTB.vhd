--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:48:57 06/13/2016
-- Design Name:   
-- Module Name:   C:/Users/Skrum_000/OneDrive/DTU/2. semester/Digitalteknik/Oscilloskop_projekt/SPIHandlerTB.vhd
-- Project Name:  Oscilloskop_projekt
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SPIHandler
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
 
ENTITY SPIHandlerTB IS
END SPIHandlerTB;
 
ARCHITECTURE behavior OF SPIHandlerTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SPIHandler
    PORT(
         Reset : IN  std_logic;
         Mclk : IN  std_logic;
         SS : IN  std_logic;
         DataIn : IN  std_logic_vector(7 downto 0);
         LED : OUT  std_logic_vector(7 downto 0);
         Shape : OUT  std_logic_vector(1 downto 0);
         Ampl : OUT  std_logic_vector(7 downto 0);
         Freq : OUT  std_logic_vector(7 downto 0);
         SigEn : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Reset : std_logic := '0';
   signal Mclk : std_logic := '0';
   signal SS : std_logic := '0';
   signal DataIn : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal LED : std_logic_vector(7 downto 0);
   signal Shape : std_logic_vector(1 downto 0);
   signal Ampl : std_logic_vector(7 downto 0);
   signal Freq : std_logic_vector(7 downto 0);
   signal SigEn : std_logic;

   -- Clock period definitions
   constant Mclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SPIHandler PORT MAP (
          Reset => Reset,
          Mclk => Mclk,
          SS => SS,
          DataIn => DataIn,
          LED => LED,
          Shape => Shape,
          Ampl => Ampl,
          Freq => Freq,
          SigEn => SigEn
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
		Reset <= '1';
		SS <= '1'; --No transmission

      wait for Mclk_period*5;
		Reset <= '0';
		
		--1st package transmitted
		DataIn <= "10101010"; --Sync byte
		SS <= '1';
		wait for Mclk_period*3;
		SS <= '0'; --Transmit 1st byte
		wait for Mclk_period*3;
		SS <= '1';
		DataIn <= "00000001"; --Address byte. Indicating Shape register
		wait for Mclk_period*3;
		SS <= '0';--Transmit 2nd byte
		wait for Mclk_period*3;
		SS <= '1';
		DataIn <= "00000001"; --Data byte. Shape data. Square pulse
		wait for Mclk_period*3;
		SS <= '0';--Transmit 3rd byte
		wait for Mclk_period*3;
		SS <= '1'; --Stop transmission
		DataIn <= "10101011"; --Checksum byte
		wait for Mclk_period*3;
		SS <= '0';--Transmit 4th byte
		wait for Mclk_period*3;
		SS <= '1'; --Transmission stop
		
		wait for Mclk_period*5;
		
		--2nd package transmitted
		DataIn <= "10101010"; --Sync byte
		wait for Mclk_period*3;
		SS <= '0'; --Transmit 1st byte
		wait for Mclk_period*3;
		SS <= '1';
		DataIn <= "00000010"; --Address byte. Indicating amplitude register.
		wait for Mclk_period*3;
		SS <= '0'; --Transmit 2nd byte
		wait for Mclk_period*3;
		SS <= '1';
		DataIn <= "01111111"; --Data byte. Half amplitude, 1.65 V.
		wait for Mclk_period*3;
		SS <= '0'; --Transmit 3rd byte
		wait for Mclk_period*3;
		SS <= '1';
		DataIn <= "11010100"; --Checksum byte
		wait for Mclk_period*3;
		SS <= '0'; --Transmit 4th byte
		wait for Mclk_period*3;
		SS <= '1'; --Package has been transferred
		
		wait for Mclk_period*5;
		
		--3rd package transmitted
		DataIn <= "10101010"; --Sync byte
		wait for Mclk_period*3;
		SS <= '0'; --Transmit 1st byte
		wait for Mclk_period*3;
		SS <= '1';
		DataIn <= "00000011"; --Address byte. Indicating frequency register
		wait for Mclk_period*3;
		SS <= '0'; --Transmit 2nd byte
		wait for Mclk_period*3;
		SS <= '1';
		DataIn <= "01111111"; --Data byte. 11.5 kHz
		wait for Mclk_period*3;
		SS <= '0'; --Transmit 3rd byte
		wait for Mclk_period*3;
		SS <= '1';
		DataIn <= "11010111"; --Checksum byte
		wait for Mclk_period*3;
		SS <= '0'; --Transmit 4th byte
		wait for Mclk_period*3;
		SS <= '1'; --Package has been transmitted
		
		wait for Mclk_period*5;
		
		--4th package transmitted
		DataIn <= "10101010"; --Sync byte
		wait for Mclk_period*3;
		SS <= '0'; --Transmit 1st byte
		wait for Mclk_period*3;
		SS <= '1';
		DataIn <= "00001111"; --Address byte
		wait for Mclk_period*3;
		SS <= '0'; --Transmit 2nd byte
		wait for Mclk_period*3;
		SS <= '1';
		DataIn <= "00000000"; --Data byte- Checksum byte
		wait for Mclk_period*3;
		SS <= '0'; --Transmit 3rd byte
		wait for Mclk_period*3;
		SS <= '1';
		DataIn <= "10100100"; --Checksum byte
		wait for Mclk_period*3;
		SS <= '0'; --Transmit 4th byte
		wait for Mclk_period*3;
		SS <= '1'; --Package has been transmitted
		
		wait for Mclk_period*5;
		Reset <= '1';
		
      wait;
   end process;

END;
