----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:00:11 06/15/2016 
-- Design Name: 
-- Module Name:    DispMux - Behavioral 
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

entity DispMux is
    Port ( 
			  Reset : in Std_logic;
			  Mclk : in std_logic;
			  ShapeDisp : in  STD_LOGIC_VECTOR (1 downto 0);
           AmplDisp : in  STD_LOGIC_VECTOR (7 downto 0);
           FreqDisp : in  STD_LOGIC_VECTOR (7 downto 0);
			  OK_cnt : in STD_LOGIC_VECTOR (19 downto 0);
           --StartPoint : in  STD_LOGIC_VECTOR (19 downto 0);
           DispOut : out  STD_LOGIC_VECTOR (19 downto 0);
           Switch : in  STD_LOGIC);
end DispMux;



architecture Behavioral of DispMux is

signal DispCount: integer range 0 to 4;

begin

Counter : Process(Switch)

begin

end process;

DispCountDec: process(Reset, Mclk, Switch,DispCount, ShapeDisp,AmplDisp,FreqDisp, OK_cnt)
	begin
	
	if Reset = '1' then
		DispCount <= 0;
	elsif Mclk'event and Mclk = '1' then
		If DispCount > 4 then
			DispCount <= 0;
		elsif Switch = '1' then
			DispCount <= DispCount +1;
		else
			DispCount <= DispCount;
		end if;
	end if;
	
	
	
	  case DispCount is
	    when 0 => 
			--StartPoint <= x"F0123"; -- Value for StartPoint
		   DispOut <= x"F0123";        
	    when 1 => 
			DispOut <= "000010100000000000" & ShapeDisp;
	    when 2 => 
			DispOut <= "000010100000" & AmplDisp;
	    when 3 => 
			DispOut <= "000011110000" & FreqDisp;
		 when 4 =>
			DispOut <= OK_cnt;
		 when others => 
			DispOut <= x"01234";
     end case;
    end process DispCountDec;



end Behavioral;

