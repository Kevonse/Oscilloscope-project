--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:10:36 06/17/2016
-- Design Name:   
-- Module Name:   C:/Users/Skrum_000/OneDrive/DTU/2. semester/Digitalteknik/Oscilloskop_projekt/SigGenControlTB.vhd
-- Project Name:  Oscilloskop_projekt
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SigGenControl
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
 
ENTITY SigGenControlTB IS
END SigGenControlTB;
 
ARCHITECTURE behavior OF SigGenControlTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SigGenControl
    PORT(
         Reset : IN  std_logic;
         Mclk : IN  std_logic;
         SCK : IN  std_logic;
         MOSI : IN  std_logic;
         SS : IN  std_logic;
         Shape : OUT  std_logic_vector(1 downto 0);
         Ampl : OUT  std_logic_vector(7 downto 0);
         Freq : OUT  std_logic_vector(7 downto 0);
         LED : OUT  std_logic_vector(7 downto 0);
         SigEn : OUT  std_logic;
         DispSelect : IN  std_logic;
         cat : OUT  std_logic_vector(7 downto 0);
         an : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Reset : std_logic := '0';
   signal Mclk : std_logic := '0';
   signal SCK : std_logic := '0';
   signal MOSI : std_logic := '0';
   signal SS : std_logic := '0';
   signal DispSelect : std_logic := '0';

 	--Outputs
   signal Shape : std_logic_vector(1 downto 0);
   signal Ampl : std_logic_vector(7 downto 0);
   signal Freq : std_logic_vector(7 downto 0);
   signal LED : std_logic_vector(7 downto 0);
   signal SigEn : std_logic;
   signal cat : std_logic_vector(7 downto 0);
   signal an : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant Mclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SigGenControl PORT MAP (
          Reset => Reset,
          Mclk => Mclk,
          SCK => SCK,
          MOSI => MOSI,
          SS => SS,
          Shape => Shape,
          Ampl => Ampl,
          Freq => Freq,
          LED => LED,
          SigEn => SigEn,
          DispSelect => DispSelect,
          cat => cat,
          an => an
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
		SS <= '1';
		SCK <= '1';
		Reset <= '1'; --Reset all signals first
      wait for 100 ns;
		Reset <= '0';
		
		--3 packages need to be sent. Containing data about shape, amplitude and frequency.
		--Each package contains 4 bytes; sync, address, data, checksum
		
---------------------------------------Package #1--------------------------------------------------
		--Byte #1 - Sync: 10101010
		MOSI <= '1'; --bit: 1
		wait for Mclk_period*3;
		SS <= '0'; --Transmission starts
		wait for Mclk_period*3;
		SCK <= '0'; -- SPI clock activates. Is idle high when CPOL in arduino is 1
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 2
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:3
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 4
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:5
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 6
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:7
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 8
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		SS <= '1';
		
		wait for Mclk_period*5;
		
		--Package #1
		--Byte #2 - Address: 00000001
		MOSI <= '0'; --bit: 1
		SS <= '0'; --Transmission starts
		wait for Mclk_period*3;
		SCK <= '0'; -- SPI clock activates. Is idle high when CPOL in arduino is 1
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 2
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:3
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 4
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:5
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 6
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:7
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 8
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		SS <= '1';
		
		wait for Mclk_period*5;
		
		--Package #1
		--Byte #3 - Data(Shape): 00000001 - Square wave
		MOSI <= '0'; --bit: 1
		wait for Mclk_period*3;
		SS <= '0'; --Transmission starts
		wait for Mclk_period*3;
		SCK <= '0'; -- SPI clock activates. Is idle high when CPOL in arduino is 1
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 2
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:3
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 4
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:5
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 6
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:7
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 8
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		SS <= '1';
		
		wait for Mclk_period*5;
		
		--Package #1
		--Byte #4 - Checksum: 10101010
		MOSI <= '1'; --bit: 1
		SS <= '0'; --Transmission starts
		wait for Mclk_period*3;
		SCK <= '0'; -- SPI clock activates. Is idle high when CPOL in arduino is 1
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 2
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:3
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 4
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:5
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 6
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:7
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 8
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		SS <= '1';
		
		wait for Mclk_period*5;
---------------------------------------------Package #2 -----------------------------------------------
		--Byte #1 - Sync: 10101010
		MOSI <= '1'; --bit: 1
		SS <= '0'; --Transmission starts
		wait for Mclk_period*3;
		SCK <= '0'; -- SPI clock activates. Is idle high when CPOL in arduino is 1
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 2
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:3
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 4
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:5
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 6
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:7
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 8
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		SS <= '1';
		
		wait for Mclk_period*5;
		
		--Package #2
		--Byte #2 - Address: 00000010
		MOSI <= '0'; --bit: 1
		SS <= '0'; --Transmission starts
		wait for Mclk_period*3;
		SCK <= '0'; -- SPI clock activates. Is idle high when CPOL in arduino is 1
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 2
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:3
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 4
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:5
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 6
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:7
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 8
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		SS <= '1';
		
		wait for Mclk_period*5;
		
		--Package #2
		--Byte #3 - Data(Amplitude): 01111111 - 1.65 V
		MOSI <= '0'; --bit: 1
		SS <= '0'; --Transmission starts
		wait for Mclk_period*3;
		SCK <= '0'; -- SPI clock activates. Is idle high when CPOL in arduino is 1
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 2
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:3
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 4
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:5
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 6
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:7
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 8
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		SS <= '1';
		
		wait for Mclk_period*5;
		
		--Package #2
		--Byte #4 - Checksum: 11010111
		MOSI <= '1'; --bit: 1
		SS <= '0'; --Transmission starts
		wait for Mclk_period*3;
		SCK <= '0'; -- SPI clock activates. Is idle high when CPOL in arduino is 1
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 2
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:3
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 4
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:5
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 6
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:7
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 8
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		SS <= '1';
		
		wait for Mclk_period*5;
		
-----------------------------------------------Package #3--------------------------------------------
		--Byte #1 - Sync: 10101010
		MOSI <= '1'; --bit: 1
		SS <= '0'; --Transmission starts
		wait for Mclk_period*3;
		SCK <= '0'; -- SPI clock activates. Is idle high when CPOL in arduino is 1
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 2
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:3
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 4
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:5
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 6
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:7
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 8
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		SS <= '1';
		
		wait for Mclk_period*5;
		
		--Package #3
		--Byte #2 - Address: 00000011
		MOSI <= '0'; --bit: 1
		SS <= '0'; --Transmission starts
		wait for Mclk_period*3;
		SCK <= '0'; -- SPI clock activates. Is idle high when CPOL in arduino is 1
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 2
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:3
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 4
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:5
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 6
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:7
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 8
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		SS <= '1';
		
		wait for Mclk_period*5;
		
		--Package #3
		--Byte #3 - Data(Frequency): 01111111 - 11.5 kHz
		MOSI <= '0'; --bit: 1
		SS <= '0'; --Transmission starts
		wait for Mclk_period*3;
		SCK <= '0'; -- SPI clock activates. Is idle high when CPOL in arduino is 1
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 2
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:3
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 4
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:5
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 6
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:7
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 8
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		SS <= '1';
		
		wait for Mclk_period*5;
		
		--Package #3
		--Byte #4 - Checksum: 11010110
		MOSI <= '1'; --bit: 1
		SS <= '0'; --Transmission starts
		wait for Mclk_period*3;
		SCK <= '0'; -- SPI clock activates. Is idle high when CPOL in arduino is 1
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 2
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:3
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 4
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit:5
		wait for Mclk_period*3;
		SCK <= '0'; 
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit: 6
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '1'; --bit:7
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		wait for Mclk_period*3;
		MOSI <= '0'; --bit: 8
		wait for Mclk_period*3;
		SCK <= '0';
		wait for Mclk_period*3;
		SCK <= '1';
		SS <= '1';
		
		wait for Mclk_period*5;
		
		
      wait;
   end process;

END;