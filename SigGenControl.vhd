----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:05:01 06/08/2016 
-- Design Name: 
-- Module Name:    SigGenControl - Behavioral 
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

entity SigGenControl is
    Port ( Reset : in  STD_LOGIC;
           Mclk : in  STD_LOGIC;
           SCK : in  STD_LOGIC;
           MOSI : in  STD_LOGIC;
           SS : in  STD_LOGIC;
			  Shape : out  STD_LOGIC_VECTOR (1 downto 0);
           Ampl : out STD_LOGIC_VECTOR (7 downto 0);
           Freq : out STD_LOGIC_VECTOR (7 downto 0);
			  LED : out STD_LOGIC_VECTOR (7 downto 0);
           SigEn : out  STD_LOGIC;
			  DispSelect : in STD_LOGIC;
			  cat :    out std_logic_vector(7 downto 0);  -- Common cathodes
           an :     out std_logic_vector(3 downto 0)); -- Common Anodes
end SigGenControl;

architecture Behavioral of SigGenControl is

signal DispBTNOut : std_logic; --Debounce output. 1 if button is pressed, 0 if not.
signal DispOut : std_logic_vector(19 downto 0); --Data to display multiplexer (DispMux). This will be shown on 7-seg displ..
Signal ShapeVal : std_logic_vector(1 downto 0);
Signal AmplVal,FreqVal : std_logic_vector(7 downto 0);

component BTNdb is
  port( Reset, Clk: in std_logic;
        BTNin: in std_logic;
        BTNout: out std_logic);
end component;

component SevenSeg5 is
    Port ( Reset,Clk: in  std_logic;    
	        Data :   in  std_logic_vector (19 downto 0); -- Binary data
           cat :    out std_logic_vector(7 downto 0);  -- Common cathodes
           an :     out std_logic_vector(3 downto 0)); -- Common Anodes
end component;

component DivClk is
    port ( Reset: in STD_LOGIC;     -- Global Reset (BTN1)
           Clk: in STD_LOGIC;     -- Master Clock (50 MHz)
           TimeP: in integer;     -- Time periode of the divided clock (50e6)
           Clk1: out STD_LOGIC);   -- Divided clock1 (1 Hz)
end component;

component DispMux is
    Port ( Reset : in  STD_LOGIC;
           Mclk : in  STD_LOGIC;
			  ShapeDisp : in  STD_LOGIC_VECTOR (1 downto 0);
           AmplDisp : in  STD_LOGIC_VECTOR (7 downto 0);
           FreqDisp : in  STD_LOGIC_VECTOR (7 downto 0);
			  OK_cnt : in STD_LOGIC_VECTOR (19 downto 0);
           DispOut : out  STD_LOGIC_VECTOR (19 downto 0);
           Switch : in  STD_LOGIC);
end component;


component shiftreg is
    Port ( Reset : in  STD_LOGIC;
           SCK : in  STD_LOGIC;
			  SS: in std_logic;
			  Mclk: in std_logic;
           MOSI : in  STD_LOGIC;
			  SPIDAT : OUT STD_LOGIC_VECTOR (7 downto 0));
end component;

component SPIHandler is
    Port ( Reset : in  STD_LOGIC;
           Mclk : in  STD_LOGIC;
			  SS : in STD_Logic;
			  LED : out  STD_LOGIC_VECTOR (7 downto 0);
           DataIn : in  STD_LOGIC_VECTOR (7 downto 0);
           Shape : out  STD_LOGIC_VECTOR (1 downto 0);
           Ampl : out  STD_LOGIC_VECTOR (7 downto 0);
           Freq : out  STD_LOGIC_VECTOR (7 downto 0);
			  OK_cnt : out STD_LOGIC_VECTOR (19 downto 0);
           SigEn : out  STD_LOGIC);
end component;

Signal SregIn : std_logic_vector(7 downto 0); --Data from shift register getting data via the SPI connection
signal Clk1 : Std_logic; --One clock output from given module "DivClk" (divided clock). Clock for SevenSeg5 module.
signal OK_cnt_conn : STD_LOGIC_VECTOR (19 downto 0);

begin

U2 : shiftreg port map(Reset => Reset,
							  SCK => SCK,
							  Mclk => Mclk,
							  SS => SS, 
							  MOSI => MOSI,
							  SPIdat => SregIn);

U4 : SPIHandler port map(Reset => Reset,
								 DataIn => SregIn, 
								 Mclk => Mclk, 
								 Shape => ShapeVal,
								 Ampl => AmplVal,
								 Freq => FreqVal,
								 SigEn => SigEn, 
								 SS => SS,
								 OK_cnt => OK_cnt_conn,
							    LED => LED);
								 
U5 : SevenSeg5 Port map(Reset => Reset, 
							   Clk => Clk1,
							   Data => DispOut,
							   an => an,
							   cat => cat);
							  
U6 : BTNdb port map(Reset => Reset, 
						  Clk => Mclk,
						  BTNin => DispSelect,
						  BTNOut =>DispBTNOut);
									
U7 : DispMux Port map (Reset => Reset,
							  Mclk => Mclk,
							  ShapeDisp => ShapeVal,
							  AmplDisp => AmplVal,
							  FreqDisp => FreqVal,
							  Switch => DispBTNOut,
							  OK_cnt => OK_cnt_conn,
							  DispOut => DispOut);
							  
U8 : DivClk port map (Reset => Reset,
							 Clk => Mclk,
							 TimeP => 50e3,
							 Clk1 => Clk1);

Shape <= ShapeVal;
Ampl <= AmplVal;
Freq <= FreqVal;							  
							  
end Behavioral;

