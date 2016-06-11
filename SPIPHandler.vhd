----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:51:02 06/10/2016 
-- Design Name: 
-- Module Name:    SPIHandler - Behavioral 
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

entity SPIHandler is
    Port ( Reset : in  STD_LOGIC;
           Mclk : in  STD_LOGIC;
			  SS : in std_logic;
			  DataIn : in  STD_LOGIC_VECTOR (7 downto 0);
			  LED : out  STD_LOGIC_VECTOR (7 downto 0);
           Shape : out  STD_LOGIC_VECTOR (1 downto 0);
           Ampl : out  STD_LOGIC_VECTOR (7 downto 0);
           Freq : out  STD_LOGIC_VECTOR (7 downto 0);
           SigEn : out  STD_LOGIC);
end SPIHandler;

architecture Behavioral of SPIHandler is
--Data signal can be either shape, amplitude or frequency before it is analyzed based on adress.
signal ByteIn, Data, AdrVal, AmplVal, FreqVal, SyncVal, ChecksumVal: std_logic_vector(7 downto 0);--signals holding transmitted bytes
signal ChecksumCalc : STD_LOGIC_VECTOR(7 downto 0); --the calculated value of checksum
signal Package_Ok : STD_LOGIC; --signal indicating if checksum values matched
signal SyncEn, DataEn, ShapeEn, AmplEn, FreqEn, ChecksumEn, AdrEn: std_logic; --Signals for which register to load data into
signal ShapeVal : Std_logic_vector(1 downto 0); --shape value
--signal SSsample : std_logic_vector(1 downto 0); --Sample of SCK
type StateType is ( AdrS, DataS, CheckSumEvalS, SyncS, ShapeS, AmplS, FreqS, SigEnS);--States indicating current byte to be received
signal State, nState: StateType; --Current state and next state


begin

--SS_Sampler : Process(Reset, Mclk) --Register holding sample rate of SCK
--begin
--	if reset = '1' then 
--		SSsample <= "00";
--	elsif Mclk'event and Mclk = '1' then --On rising edge Mclk
--		SSsample <= SSsample(0) & SS ; --Left shift signal value
--	end if;
--end process;

DataInReg: process (Reset, Mclk) --Register has byte transferred into shiftreg from SPI transmission
begin
  if Reset = '1' then ByteIn <= x"00"; --reset signal holding incoming byte
  elsif Mclk'event and Mclk = '1' then
      ByteIn <= DataIn; --Signal holding transmitted byte is set.
		--LED <= DataIn; --Set LED's based in byte held by ByteIn signal. Used for testing transmission
    end if;
end process;

SyncReg: process (Reset, Mclk) --Register holds sync byte. 1st byte.
begin
	if Reset = '1' then SyncVal <= x"00";
	elsif Mclk'event and Mclk = '1' then
		if SyncEn = '1' then --load byte into this register
			SyncVal <= ByteIn; --sync value is saved as current byte value
		end if;
	end if;
end process;

AdrReg: process (Reset, Mclk)--Register holding frequency byte. 2nd byte.
begin
	if Reset = '1' then AdrVal <= x"00";
	elsif Mclk'event and Mclk = '1' then
		if AdrEn = '1' then --load byte into this register
			AdrVal <= ByteIn;--Address output is set to held byte
		end if;
  end if;
end process;

DataReg: process (Reset, Mclk) --Holds data byte. Byte can be shape, amplitude or frequency based on adress byte. 3rd byte.
begin
	if Reset = '1' then Data <= X"00";
	elsif Mclk'event and Mclk = '1' then
		if DataEn = '1' then --load current byte into data byte.
			Data <= ByteIn;
		end if;
	end if;
end process;

ChecksumReg: process (Reset, Mclk) --Register holding checksum byte. 4th byte.
begin
	if Reset = '1' then ChecksumVal <= x"00"; --reset signal holding incoming byte
	elsif Mclk'event and Mclk = '1' then
		if ChecksumEn = '1' then --load current byte into this register
			ChecksumVal <= ByteIn;
		end if;
   end if;
end process;

ShapeReg: process (Reset, Mclk)--Register holding shape byte
begin
  if Reset = '1' then ShapeVal <= "00";
  elsif Mclk'event and Mclk = '1' then
    if ShapeEn = '1' then --Load byte into register
      ShapeVal <= Data(1 downto 0); --Shape value is set. 2 LSB's of Data byte
		Shape <= ShapeVal; --Shape output is assigned
    end if;
  end if;
end process;

AmplReg: process (Reset, Mclk)--Register holding amplitude byte
begin
	if Reset = '1' then AmplVal <= x"00";
	elsif Mclk'event and Mclk = '1' then
		if AmplEn = '1' then --load byte into this register
			AmplVal <= Data;--Amplitude value is set
			Ampl <= AmplVal;--Amplitude output is assigned
		end if;
   end if;
end process;

FreqReg: process (Reset, Mclk)--Register holding frequency byte
begin
  if Reset = '1' then Freq <= x"00";
  elsif Mclk'event and Mclk = '1' then
    if FreqEn = '1' then --load byte into this register
      FreqVal <= Data;--Frequency value is set
		Freq <= FreqVal;--Frequency output is assigned
    end if;
  end if;
end process;

CheckSumEval: process (Reset, Mclk) --Process evaluation transferred checksum byte against calculated checksum byte
begin
	if Reset = '1' then 
		ChecksumCalc <= x"00"; --calculated byte
		Package_Ok <= '0';
	elsif Mclk'event and Mclk = '1' then
		ChecksumCalc <= SyncVal xor AdrVal xor ByteIn; --Checksum is calculated based on 3 earlier bytes in package
		
		if ChecksumVal = ChecksumCalc then --If checksum sent and checksum calculated matches
			Package_Ok <= '1'; --Raise OK signal
			SigEn <= '1';
		else
			Package_Ok <= '0'; --Checksums did not match
		end if;
  end if;
end process;



StateReg: process (Reset, Mclk)--Register hold current state
begin
  if Reset = '1' then State <= SyncS; --Sync state is state when first byte expected is the sync byte
  elsif Mclk'event and Mclk = '1' then
    State <= nState; --Moving on to next state
  end if;
end process;


StateDec: process (Reset, State, DataIn, AdrVal)--, SSsample,,state,SS,DataIn,Adr,CheckSumTmp)--statemachine
begin
	--Reset load signals
	SyncEn <= '0';
	DataEn <= '0';
	ShapeEn <= '0';
	AmplEn <= '0';
	FreqEn <= '0';
	ChecksumEn <= '0';
	AdrEn <= '0';
	
	if Reset = '1' then --Output is zero if reset signal is set to high	
		--Reset load signals
		SyncEn <= '0';
		DataEn <= '0';
		ShapeEn <= '0';
		AmplEn <= '0';
		FreqEn <= '0';
		ChecksumEn <= '0';
		AdrEn <= '0';
		nState <= SyncS;
	else
		case state is
			when SyncS => --Sync state
				SyncEn <= '1'; --Load data into SyncReg
				nState <= AdrS; --next expected byte is the address byte
			when AdrS => --State is AdrS
				AdrEn <= '1';
				nState <= DataS; --Next expected byte is Data (Shape, Amplitude, Frequency)
			when DataS => --Expected byte is data (Shape, Amplitude, Frequency)
				DataEn <= '1'; --load current byte into DataReg
				if AdrVal = X"00" then
					nState <= ShapeS;
				elsif AdrVal = X"01" then
					nState <= AmplS;
				elsif AdrVal = X"02" then
					nState <= FreqS;
				elsif AdrVal = X"03" then
					nState <= SigEnS;
				else
					nState <= CheckSumEvalS; --Next expected byte is the checksum
				end if;
			when CheckSumEvalS => --Expected byte is the checksum
				ChecksumEn <= '1'; --load current byte into checksumReg
				nState <= SyncS; --Expect new package
			when Shapes =>
				ShapeEn <= '1';
				nState <= CheckSumEvalS; --Next expected byte is the checksum
			when AmplS =>
				AmplEn <= '1';
				nState <= CheckSumEvalS; --Next expected byte is the checksum
			when FreqS =>
				FreqEn <= '1';
				nState <= CheckSumEvalS; --Next expected byte is the checksum
			when SigEnS =>
				SigEn <= '1';
				nState <= CheckSumEvalS; --Next expected byte is the checksum
			when others => --If none of the states applied
				nState <= SyncS; --Set state to expect new package
		end case;
	end if;
end process;
		
end Behavioral;

