--------------------------------------------------------------------------------
-- Company:        DTU
-- Engineer:       Peter Brauer
--
-- Create Date:    10:07:10 05/12/09
-- Design Name:    
-- Module Name:    SigGenControl - Behavioral
-- Project Name:   Signal Generator
-- Target Device:  Spartan 3
-- Tool versions:  
-- Description:    Control circuit for the Signal Generator system
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

entity SigGenControl is
  Port ( Reset  : in std_logic;	
         Clk    : in std_logic;
         BTN0    : in std_logic;
         BTN1    : in std_logic;
         BTN2    : in std_logic;
         SW     : in std_logic_vector(7 downto 0);
         Disp   : out std_logic_vector(19 downto 0);
         Shape  : inout std_logic_vector(1 downto 0);
         Ampl   : inout std_logic_vector(7 downto 0);
         Freq   : inout std_logic_vector(7 downto 0);
         SigEn  : out std_logic);
end SigGenControl;

architecture Behavioral of SigGenControl is

component BTNdb
  port( Reset, Clk: in std_logic;
        BTNin: in std_logic;
        BTNout: out std_logic);
end component;

signal BTN1db, BTN2db, ShapeEN, AmplEN, FreqEN: std_logic;
--signal SWshape, SWampl, SWfreq: std_logic_vector(7 downto 0);
signal DispSel: std_logic_vector(1 downto 0);
type StateType is (ShapeS, AmplS, FreqS, RunS);
signal State, nState: StateType;  

begin

ShapeReg: process (Reset, Clk)
begin
  if Reset = '1' then Shape <= "00";
  elsif Clk'event and Clk = '1' then
    if ShapeEn = '1' then
      Shape <= SW(1 downto 0);
    end if;
  end if;
end process;

AmplReg: process (Reset, Clk)
begin
  if Reset = '1' then Ampl <= X"00";
  elsif Clk'event and Clk = '1' then
    if AmplEn = '1' then
      Ampl <= SW;
    end if;
  end if;
end process;

FreqReg: process (Reset, Clk)
begin
  if Reset = '1' then Freq <= X"00";
  elsif Clk'event and Clk = '1' then
    if FreqEn = '1' then
      Freq <= SW;
    end if;
  end if;
end process;

DispMux: Disp <= X"F1230" when DispSel = "0" else
                 X"4F0" & Freq when DispSel = X"1" else
                 X"4A0" & Ampl when DispSel = X"2" else
                 X"450" & "000000" & Shape;

--SWdec: process (SW)
--begin
--  if SW > X"03" then SWshape <= X"03"; else SWshape <= SW; end if;
--  if SW < X"FF" then SWampl  <= SW; else SWampl <= X"FF"; end if;
--  if SW < X"FF" then SWfreq  <= SW; else SWfreq <= X"FF"; end if;
--end process;

StateReg: process (Reset, Clk)
begin
  if Reset = '1' then State <= ShapeS;
  elsif Clk'event and Clk = '1' then
    State <= nState;
  end if;
end process;

StateDec: process (state, BTN0, BTN1db, BTN2db)
begin
  SigEN <= '0';
  ShapeEN <= '0';
  AmplEN <= '0';
  FreqEN <= '0';
  DispSel <= "00";
  nState <= ShapeS;
  case state is
    when ShapeS =>
	   ShapeEN <= BTN0;
		DispSel <= "11";
		if BTN2db = '1' then
		  nState <= RunS;
      elsif BTN1db =	'1' then
		  nState <= AmplS;
		else
		  nState <= ShapeS;
		end if;

    when AmplS =>
	   AmplEN <= BTN0;
		DispSel <= "10";
		if BTN2db = '1' then
		  nState <= RunS;
      elsif BTN1db =	'1' then
		  nState <= FreqS;
		else
		  nState <= AmplS;
		end if;

    when FreqS =>
	   FreqEN <= BTN0;
		DispSel <= "01";
		if BTN2db = '1' then
		  nState <= RunS;
      elsif BTN1db =	'1' then
		  nState <= ShapeS;
		else
		  nState <= FreqS;
		end if;

    when RunS =>
	   SigEN <= '1';
		DispSel <= "00";
		if BTN2db = '1' then
		  nState <= ShapeS;
      else
		  nState <= RunS;
		end if;

  end case;
end process;

Deb1: BTNdb port map (Reset => Reset, Clk => Clk, BTNin => BTN1, BTNout => BTN1db);

Deb2: BTNdb port map (Reset => Reset, Clk => Clk, BTNin => BTN2, BTNout => BTN2db);

end Behavioral;
