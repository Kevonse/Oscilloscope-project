-----------  Driver to sevensegment display  --------------- 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevenSeg5 is
    Port ( Reset,Clk: in  std_logic;    
	        Data :   in  std_logic_vector (19 downto 0); -- Binary data
           cat :    out std_logic_vector(7 downto 0);  -- Common cathodes
           an :     out std_logic_vector(3 downto 0)); -- Common Anodes
end SevenSeg5;

architecture SevenSeg_arch of SevenSeg5 is
signal DispCount: integer range 0 to 3;
signal DataN: std_logic_vector (3 downto 0);
signal CatInt, CatData, CatSign: std_logic_vector (7 downto 0);
signal AnInt: std_logic_vector (3 downto 0);

begin
	

	DispCountReg: process(Reset, Clk)
	begin
	 if Reset = '1' then
	 DispCount <= 0;
	 elsif Clk'event and Clk = '1' then
	   if DispCount = 3 
		  then DispCount <= 0;
		  else DispCount <= DispCount + 1; end if;
      end if;
	end process DispCountReg;

	DispCountDec: process(DispCount, Data)
	begin
	  case DispCount is
	    when 0 => 
		   AnInt <= "1110";        --  Display 1 activated
			DataN <= Data(3 downto 0);
	    when 1 => 
		   AnInt <= "1101";        --  Display 1 activated
			DataN <= Data(7 downto 4);
	    when 2 => 
		   AnInt <= "1011";        --  Display 1 activated
			DataN <= Data(11 downto 8);
	    when others => 
		   AnInt <= "0111";        --  Display 1 activated
			DataN <= Data(15 downto 12);
     end case;
    end process DispCountDec;

   with DataN SELect      --  Activate segments acc. to Data
     CatData <= "11000000" when "0000",   --0
            "11111001" when "0001",   --1
            "10100100" when "0010",   --2
            "10110000" when "0011",   --3
         	"10011001" when "0100",   --4
         	"10010010" when "0101",   --5
         	"10000010" when "0110",   --6
         	"11111000" when "0111",   --7
				"10000000" when "1000",   --8
				"10011000" when "1001",   --9
				"10001000" when "1010",   --A
				"10000011" when "1011",   --b
				"11000110" when "1100",   --C
				"10100001" when "1101",   --d
				"10000110" when "1110",   --E
				"10001110" when "1111",   --F
         	"11111111" when others;  --blank

   with DataN SELect      --  Activate segments acc. to Data
     CatSign <= "11111111" when "0000",   --Blank
            "10101111" when "0001",   -- "r"
            "11100011" when "0010",   --"u"
            "10101011" when "0011",   --"n"
         	"10011001" when "0100",   --4
         	"10010010" when "0101",   --5
         	"10000010" when "0110",   --6
         	"11111000" when "0111",   --7
				"10000000" when "1000",   --8
				"10011000" when "1001",   --9
				"10001000" when "1010",   --A
				"10000011" when "1011",   --b
				"11000110" when "1100",   --C
				"10100001" when "1101",   --d
				"10000110" when "1110",   --E
				"10001110" when "1111",   --F
         	"11111111" when others;  --blank
    
	 CatInt <= CatData when Data(DispCount+16) = '0' else CatSign;

	 process(Reset, Clk)
	 begin
	   if Reset = '1' then Cat <= "00000000"; An <= "0000";
	   elsif Clk'event and Clk = '1' then
	     Cat <= CatInt;
		  An <= AnInt;
      end if;
	 end process;

end SevenSeg_arch;
