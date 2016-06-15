----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:23:49 06/06/2016 
-- Design Name: 
-- Module Name:    shiftreg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shiftreg is
    Port ( reset : in  STD_LOGIC;
           SCK : in  STD_LOGIC;
			  Mclk: in std_logic;
           MOSI : in  STD_LOGIC;
			  SS : in std_logic;
           SPIdat : out  STD_LOGIC_vector(7 downto 0));
end shiftreg;

architecture Behavioral of shiftreg is

signal sclk: std_logic_vector(1 downto 0); --sample value of SCK signal
signal shiftval: std_logic_vector(7 downto 0); --output
signal SSsample : std_logic_vector(1 downto 0);

begin
	Sclock : process(reset, Mclk)--Samples SCK
	begin
		if reset = '1' then 
			sclk <= "00";
		elsif Mclk'event and Mclk = '1' then --On rising edge Mclk
			sclk <= sclk(0) & SCK ; --Left shift signal value
		end if;	
	end process;

	shiftreg : process(reset,Mclk) --register holding incoming byte
		begin
			if reset = '1' then 
				shiftval <= "00000000";	
			elsif Mclk'event and Mclk = '1' then
				if sclk = "10" then --SCK has just gone low
					shiftval <=  shiftval(6 downto 0) & MOSI; --Left shift shiftval with bit from master unit
				end if;
			end if;	
	end process;
	
	
	Byteholder : process(Reset,Mclk)
		Begin
			if reset = '1' then 	
				SPIdat <= x"00";
			elsif Mclk'event and Mclk = '1' then
				If SSsample = "01" then --Shiftreg works with "11" but SigGenTop does not!
					SPIdat <= shiftval;
				end if;
			end if;
		end process;
	
	SS_Sampler : Process(Reset, Mclk) --Register holding sample rate of SCK
		begin
			if reset = '1' then 
				SSsample <= "11"; --changed from previous "11"
			elsif Mclk'event and Mclk = '1' then --On rising edge Mclk
				SSsample <= SSsample(0) & SS ; --Left shift signal value
			end if;	
	end process;
	
end Behavioral;

