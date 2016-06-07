--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:    16:17:22 01/05/09
-- Design Name:    
-- Module Name:    SigGenTop - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description:
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SigGenTop is
  Port ( BTN3   : in std_logic;	
         Clk    : in std_logic;
         BTN0   : in std_logic;
         BTN1   : in std_logic;
         BTN2   : in std_logic;
         SW     : in std_logic_vector(7 downto 0);
			An     : out std_logic_vector(3 downto 0);
			Cat    : out std_logic_vector(7 downto 0);
			LD		 : out std_logic;
         PWMOut : inout std_logic);
end SigGenTop;

architecture Behavioral of SigGenTop is

signal Mclk, DispClk, SigEn: std_logic;
signal Disp: std_logic_vector(19 downto 0); 
signal Ampl, Freq: std_logic_vector(7 downto 0);
signal Shape: std_logic_vector(1 downto 0);
signal divcnt: std_logic_vector(1 downto 0); 

begin

--U0: entity WORK.DivClk 
--    port map(Reset => BTN3, Clk => Clk, TimeP => 4, Clk1 => Mclk);
	 
	 process(BTN3, Clk)
	 begin
		if BTN3 = '1' then
			divcnt <= "00";
		elsif Clk'event and Clk = '1' then
			divcnt <= divcnt + 1;
		end if;
	end process;
	
	Mclk <= divcnt(1);
			

U4: entity WORK.DivClk 
    port map(Reset => BTN3, Clk => Clk, TimeP => 50e3, Clk1 => DispClk);

U1: entity WORK.SigGenControl 
    port map(Reset => BTN3, Clk => Mclk, BTN0 => BTN0, BTN1 => BTN1, BTN2 => BTN2, SW => SW, 
	 Disp => Disp, Shape => Shape, Ampl => Ampl, Freq => Freq, SigEN=> SigEN);


U2: entity WORK.SigGenDataPath generic map (PWMinc => "0000001") 
    port map(Reset => BTN3, Clk => Mclk, Shape => Shape, Ampl => Ampl, Freq => Freq, SigEN=> SigEN, PWMOut => PWMOut);

U3: entity WORK.SevenSeg5 
    port map(Reset => BTN3, Clk => DispClk, Data => Disp, An => An, Cat => Cat);  

U5: LD <= PWMOut;


end Behavioral;
