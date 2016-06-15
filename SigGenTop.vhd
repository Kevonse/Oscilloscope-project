----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:02:25 06/08/2016 
-- Design Name: 
-- Module Name:    SigGenTop - Behavioral 
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

entity SigGenTop is
    Port ( Reset : in  STD_LOGIC;
           Mclk : in  STD_LOGIC;
           SCK : in  STD_LOGIC;
           SS : in  STD_LOGIC;
			  MOSI : in  STD_LOGIC;
			  BTN0 : in STD_LOGIC;
           PWMOut : out  STD_LOGIC;
			  LED : out STD_LOGIC_VECTOR (7 downto 0);
			  cat :    out std_logic_vector(7 downto 0);  -- Common cathodes
           an :     out std_logic_vector(3 downto 0); -- Common Anodes
           MISO : out  STD_LOGIC);
end SigGenTop;

architecture Behavioral of SigGenTop is



component SigGenControl is
    Port ( Reset : in  STD_LOGIC;
           Mclk : in  STD_LOGIC;
           SCK : in  STD_LOGIC;
           MOSI : in  STD_LOGIC;
           SS : in  STD_LOGIC;
			  Shape : out  STD_LOGIC_VECTOR (1 downto 0);
           Ampl : out  STD_LOGIC_VECTOR (7 downto 0);
           Freq : out  STD_LOGIC_VECTOR (7 downto 0);
			  LED : out STD_LOGIC_VECTOR (7 downto 0);
           SigEn : out  STD_LOGIC;
			  cat :  out std_logic_vector(7 downto 0);  -- Common cathodes
           an :  out std_logic_vector(3 downto 0); -- Common Anodes
			  DispSelect : in STD_LOGIC;
           MISO : out  STD_LOGIC);
end component;

component SigGenDatapath is
  generic( PWMinc : std_logic_vector(6 downto 0) := "0000001" );
  Port ( Reset  : in std_logic;	
         Clk    : in std_logic;
         SigEn  : in std_logic;
         Shape  : in std_logic_vector(1 downto 0);
         Ampl   : in std_logic_vector(7 downto 0);
         Freq   : in std_logic_vector(7 downto 0);
         PWMOut : out std_logic);
end component;

--Common signals
signal Ampl_conn, Freq_conn : std_logic_vector(7 downto 0);
signal SigEn_conn : std_logic;
signal Shape_conn : std_logic_vector(1 downto 0);

begin

U1 : SigGenControl Port map(Reset => Reset,
									 Mclk => Mclk,
									 SCK => SCK,
									 MOSI => MOSI,
									 SS => SS,
									 Shape => Shape_conn,
									 Ampl => Ampl_conn,
									 Freq => Freq_conn,
									 SigEn => SigEn_conn,
									 LED => LED,
									 DispSelect => BTN0,
									 an => an,
									 cat => cat,
									 MISO => MISO);

U3 : SigGenDatapath port map(Reset => Reset,
									  Clk => Mclk,
									  Shape => Shape_conn,
									  Ampl => Ampl_conn,
									  Freq => Freq_conn, 
									  PWMOut => PWMOut, 
									  SigEn => SigEn_conn);
									  

end Behavioral;

