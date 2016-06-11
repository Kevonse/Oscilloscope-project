--------------------------------------------------------------------------------
-- Company:        DTU
-- Engineer:       Peter Brauer
--
-- Create Date:    29/4/15
-- Design Name:    
-- Module Name:    SigGenDatapath - Behavioral
-- Project Name:   Signal Generator
-- Target Device:  Spartan 3
-- Tool versions:  
-- Description:    Datapath circuit for the Signal Generator system
--
-- Dependencies:   Lookup table "SinusLUT" for generating a sinus signal
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
-- Revision June 2016:
-- Module now works with a 50 MHz input clock
-- Setting freq to 0x01 yields an output frequency of 24 Hz
-- Setting freq to 0xff yields an output frequency of 23 kHz
-- The PWM frequency is ~391 kHz
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SigGenDatapath is
  generic( PWMinc : std_logic_vector(6 downto 0) := "0010000" );
  Port ( Reset  : in std_logic;	
         Clk    : in std_logic;
         SigEN  : in std_logic;
         Shape  : in std_logic_vector(1 downto 0);
         Ampl   : in std_logic_vector(7 downto 0);
         Freq   : in std_logic_vector(7 downto 0);
         PWMOut : out std_logic);
end SigGenDatapath;

architecture Behavioral of SigGenDatapath is

signal SigCnt, FreqCnt: std_logic_vector(11 downto 0);
signal SigCnt_int, nSigCnt_int : std_logic_vector(14 downto 0);
signal Sig, SigSquare, SigSaw : std_logic_vector(7 downto 0); --, SigSinus
signal SigAmpl: std_logic_vector(6 downto 0); 
signal PWMcnt: std_logic_vector(6 downto 0) := "0000000";
signal PWM, PWMwrap : std_logic;

begin

FreqDec: FreqCnt <= "00" & Freq(7 downto 6) & Freq(5 downto 4) & '0' & Freq(3 downto 2) & '0' & Freq(1 downto 0);

--FreqAdd: nSigCnt <= SigCnt + FreqCnt;
FreqAdd : nSigCnt_int <= SigCnt_int + FreqCnt;

SigCnt <= SigCnt_int(14 downto 3);

SigReg: process (Reset, Clk)
begin
  if Reset = '1' then 
	--SigCnt <= X"000";
	SigCnt_int <= (others => '0');
  elsif Clk'event and Clk = '1' then
    if PWMwrap = '1' then
      --SigCnt <= nSigCnt;
		SigCnt_int <= nSigCnt_int;
    end if;
  end if;
end process;

--SinusDec : entity WORK.SinusLUT PORT MAP (clka => Clk, addra => SigCnt, douta => SigSinus);

PWMcount: process(Reset, Clk)
variable PWMcntvar: std_logic_vector(7 downto 0);
begin
  if Reset = '1' then PWMcntvar := "00000000";
  elsif Clk'event and Clk = '1' then
    PWMcntvar := PWMcntvar + PWMinc;
		if PWMcntvar > "10000000" then
			PWMcntvar := "00000000";
		end if;
  end if;
  PWMcnt <= PWMcntvar(6 downto 0);
end process;     

PWMdec: PWMwrap <= '1' when PWMcnt = "0000000" else '0';

SquareDec: SigSquare <= "00000000" when SigCnt < X"800" else "11111111";

SawDec: SigSaw <= SigCnt(11 downto 4);

SigMux: Sig <= X"FF" when Shape = "00" else
               SigSquare when Shape = "01" else
               SigSaw; --when Shape = "10" else
               --SigSinus;


AmplDec: process(Ampl, Sig)
variable MulA, MulB, MulC: std_logic_vector(15 downto 0);
--variable MulC: std_logic_vector(6 downto 0);
begin
  MulB := X"00" & Sig;
  MulA := X"00" & Ampl;
  MulC := X"0000";
  for j in 0 to 15 loop
    if MulA(j) = '1' then
      MulC := MulC + MulB;
    end if;
    MulB := MulB(14 downto 0) & '0';
  end loop;
--  MulC := MulC + 1;
  SigAmpl <= MulC(15 downto 9);
--  SigAmpl <= "1111111";
end process;


PWMcomp: PWM <= '1' when PWMcnt <= SigAmpl else '0';

PWMon: PWMout <= PWM when SigEn = '1' else '0';

end Behavioral;
