----------------  Clock divider  -----------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DivClk is
    port ( Reset: in STD_LOGIC;     -- Global Reset (BTN1)
           Clk: in STD_LOGIC;     -- Master Clock (50 MHz)
           TimeP: in integer;     -- Time periode of the divided clock (50e6)
           Clk1: out STD_LOGIC);   -- Divided clock1 (1 Hz)
end DivClk;

architecture DivClk_arch of DivClk is
--constant MaxCnt1: integer:= 14;
signal Cnt1: integer range 0 to 25000000;  -- 24 bit counter
signal Clear1: STD_LOGIC;  
signal Clk1_D: STD_LOGIC;  

begin

  -- T-register with enable and async.reset
  Div1Reg: process(clk,Reset)
  begin
    if Reset = '1' then Clk1_D <= '0';     -- async. reset
    elsif (clk'event and clk ='1') then
      if Clear1= '1' then                -- enable
        Clk1_D <= not Clk1_D;
		end if;
    end if;
  end process Div1Reg;

  Div1Dec: process(Cnt1, TimeP) -- Kombinatorisk
  begin
    Clear1 <= '0';
    if Cnt1 = TimeP/2 then
	   Clear1 <= '1';
	 end if;
  end process Div1Dec;

  -- 24 bit up-counter with clear and async. reset
  Div1Cnt:process(clk,Reset)
  begin
    if Reset = '1' then Cnt1 <= 1;        -- async. reset
    elsif (clk'event and clk ='1') then
	   if Clear1 = '1' then Cnt1 <= 1;   -- clear
		else Cnt1 <= Cnt1 + 1; end if;
    end if;
  end process Div1Cnt;

  Clk1 <= Clk1_D;

end DivClk_arch;

