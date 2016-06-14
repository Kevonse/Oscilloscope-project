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
           MISO : out  STD_LOGIC);
end SigGenControl;

architecture Behavioral of SigGenControl is

component shiftreg is
    Port ( Reset : in  STD_LOGIC;
           SCK : in  STD_LOGIC;
			  SS: in std_logic;
			  Mclk: in std_logic;
           MOSI : in  STD_LOGIC;
			  SPIDAT : OUT STD_LOGIC_VECTOR (7 downto 0));
           --LED : out  STD_LOGIC_vector(7 downto 0));
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
           SigEn : out  STD_LOGIC);
end component;

Signal SregIn : std_logic_vector(7 downto 0);

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
								 Shape => Shape,
								 Ampl => Ampl,
								 Freq => Freq,
								 SigEn => SigEn, 
								 SS => SS,
								 LED => LED);
end Behavioral;

