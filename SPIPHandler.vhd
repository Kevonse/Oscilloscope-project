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
--Data signal can be either shape, amplitude or frequency before it is loaded to correct register based on adress.
signal Data, AdrVal, AmplVal, FreqVal, SyncVal, ChecksumVal: std_logic_vector(7 downto 0);--signals holding transmitted bytes - ByteIn,
signal ChecksumCalc : STD_LOGIC_VECTOR(7 downto 0); --the calculated value of checksum
signal Package_Ok : STD_LOGIC; --signal indicating if checksum values matched
signal SyncEn, DataEn, ShapeEn, AmplEn, FreqEn, ChecksumEn, AdrEn: std_logic; --Signals for which register to load data into
signal ShapeVal : Std_logic_vector(1 downto 0); --shape value
signal SSsample : std_logic_vector(1 downto 0); --Sample of SS signal
signal ByteTransfCompl : std_logic; --Signal indicating if byte has been transferred. Must be so if SS has gone high again.
type StateType is ( Idle, AdrS, DataS, CheckSumEvalS, SyncS);--States indicating current byte to be received
signal State, nState: StateType; --Current state and next state
signal Package_loaded : std_logic; --Signal goes high when checksum byte is loaded
signal Pack_load_sample : std_logic_vector(1 downto 0);
signal Enable : std_logic; --Signal holding value for output SigEn 

begin

SS_Sampler : Process(Reset, Mclk) --Register holding sample rate of SCK
begin
	if reset = '1' then 
		SSsample <= "11";
		--ByteTransfCompl <= '0';
	elsif Mclk'event and Mclk = '1' then --On rising edge Mclk
		SSsample <= SSsample(0) & SS ; --Left shift signal value
		if SSsample = "01" then --if SS has gone high (8 bits transferred).
			ByteTransfCompl <= '1';
		else
			ByteTransfCompl <= '0';
		end if;
	end if;
	
end process;

--DataInReg: process (Reset, Mclk) --Register has byte transferred into shiftreg from SPI transmission
--begin
--  if Reset = '1' then ByteIn <= x"00"; --reset signal holding incoming byte
--  elsif Mclk'event and Mclk = '1' then
--      ByteIn <= DataIn; --Signal holding transmitted byte is set.
--    end if;
--end process;

SyncReg: process (Reset, Mclk) --Register holds sync byte. 1st byte.
begin
	if Reset = '1' then SyncVal <= x"00";
	elsif Mclk'event and Mclk = '1' then
		if SyncEn = '1' then --load byte into this register
			SyncVal <= DataIn; --sync value is saved as current byte value
		end if;
	end if;
end process;

AdrReg: process (Reset, Mclk)--Register holding frequency byte. 2nd byte.
begin
	if Reset = '1' then AdrVal <= x"00";
	elsif Mclk'event and Mclk = '1' then
		if AdrEn = '1' then --load byte into this register
			AdrVal <= DataIn;--Address output is set to held byte
		end if;
  end if;
end process;

DataReg: process (Reset, Mclk) --Holds data byte. Byte can be shape, amplitude or frequency based on adress byte. 3rd byte.
begin
	if Reset = '1' then Data <= X"00";
	elsif Mclk'event and Mclk = '1' then
		if DataEn = '1' then --load current byte into data byte.
			Data <= DataIn;
		end if;
	end if;
end process;

ChecksumReg: process (Reset, Mclk) --Register holding checksum byte. 4th byte.
begin
	if Reset = '1' then ChecksumVal <= x"00"; --reset signal holding incoming byte
	elsif Mclk'event and Mclk = '1' then
		if ChecksumEn = '1' then --load current byte into this register
			ChecksumVal <= DataIn;
		end if;
   end if;
end process;

ShapeReg: process (Reset, Mclk)--Register holding shape byte
begin
	if Reset = '1' then 
		ShapeVal <= "00";
  elsif Mclk'event and Mclk = '1' then
    if ShapeEn = '1' then --Load byte into register
      ShapeVal <= Data(1 downto 0); --Shape value is set. 2 LSB's of Data byte
    end if;
  end if;
end process;

AmplReg: process (Reset, Mclk)--Register holding amplitude byte
begin
	if Reset = '1' then 
		AmplVal <= x"00";
	elsif Mclk'event and Mclk = '1' then
		if AmplEn = '1' then --load byte into this register
			AmplVal <= Data;--Amplitude value is set
		end if;
   end if;
end process;

FreqReg: process (Reset, Mclk)--Register holding frequency byte
begin
	if Reset = '1' then 
		FreqVal <= X"00";
		Enable <= '0'; --Don't enable an output signal
  elsif Mclk'event and Mclk = '1' then
    if FreqEn = '1' then --load byte into this register
      FreqVal <= Data;--Frequency value is set
		Enable <= '1'; --Enable an output signal
    end if;
  end if;
end process;

CheckSumEval: process (Reset, Mclk) --Process evaluation transferred checksum byte against calculated checksum byte
begin
	if Reset = '1' then 
		ChecksumCalc <= x"00"; --calculated byte
		Package_Ok <= '0';
	elsif Mclk'event and Mclk = '1' then
		if Pack_load_sample = "01" then --If all bytes in package have been loaded
			ChecksumCalc <= SyncVal xor AdrVal xor Data; --Checksum is calculated based on 3 earlier bytes in package
		elsif Pack_load_sample = "10" then
			if ChecksumVal = ChecksumCalc then --If checksum sent and checksum calculated matches
				Package_Ok <= '1'; --Raise OK signal
			else
				Package_Ok <= '0'; --Checksums did not match
			end if;
		else
			Package_Ok <= '0';
		end if;
  end if;
end process;

Package_sampler : Process(Reset, Mclk) --Sampling value of Package_loaded
begin
	if reset = '1' then 
		Pack_load_sample <= "00";
	elsif Mclk'event and Mclk = '1' then --On rising edge Mclk
		Pack_load_sample <= Pack_load_sample(0) & Package_loaded ; --Left shift signal value
	end if;
end process;




StateReg: process (Reset, Mclk)--Register hold current state
begin
	if Reset = '1' then 
		State <= SyncS; --Sync state is state when first byte expected is the sync byte
	elsif Mclk'event and Mclk = '1' then
		State <= nState; --Moving on to next state
  end if;
end process;


StateDec: process (Reset, State, AdrVal, Package_loaded, ByteTransfCompl)--statemachine , 
begin
	--Reset load signals
	SyncEn <= '0';
	DataEn <= '0';
	ChecksumEn <= '0';
	AdrEn <= '0';
	Package_loaded <= '0';
	nState <= State;
	
	if Reset = '1' then --Output is zero if reset signal is set to high
		--Reset load signals
		SyncEn <= '0';
		DataEn <= '0';
		ChecksumEn <= '0';
		AdrEn <= '0';
		nState <= SyncS;
		Package_loaded <= '0';
	else
		case state is
			when SyncS => --Sync state
				if ByteTransfCompl = '1' then --If byte has been transferred run statemachine. SSsample = "01".
					SyncEn <= '1'; --Load data into SyncReg
					nState <= AdrS; --next expected byte is the address byte
				end if;
			when AdrS => --State is AdrS
				if ByteTransfCompl = '1' then --If byte has been transferred run statemachine. SSsample = "01".
					AdrEn <= '1'; --Load data into AdrReg
					nState <= DataS; --Next expected byte is Data (Shape, Amplitude, Frequency)
				end if;
			when DataS => --Expected byte is data (Shape, Amplitude, Frequency)
				if ByteTransfCompl = '1' then --If byte has been transferred run statemachine. SSsample = "01".
					DataEn <= '1'; --load data into DataReg
					nState <= CheckSumEvalS; --Next expected byte is checksum
				end if;
			when CheckSumEvalS => --Expected byte is the checksum
				if ByteTransfCompl = '1' then --If byte has been transferred run statemachine. SSsample = "01".
					ChecksumEn <= '1'; --load data into checksumReg
					nState <= Idle; --Expect new package
				end if;
			when Idle =>
				Package_loaded <= '1';
				nState <= SyncS;
			when others => --If none of the states applied
				nState <= SyncS; --Set state to expect new package
		end case;
	end if;
end process;

AdrDec: process (Reset, Data, AdrVal, Package_Ok)--statemachine
begin
	ShapeEn <= '0';
	AmplEn <= '0';
	FreqEn <= '0';
	
	if Reset = '1' then
		ShapeEn <= '0';
		AmplEn <= '0';
		FreqEn <= '0';
	else
		if Package_Ok = '1' then --Checksums matched
			if AdrVal = X"01" then --If address indicates data is a shape value
				ShapeEn <= '1';
			elsif AdrVal = X"02" then --If address indicates data is an amplitude value
				AmplEn <= '1';
			elsif AdrVal = X"03" then --If address indicates that data is a frequency value
				FreqEn <= '1';
			end if;
		end if;
	end if;
end process;
		Shape <= ShapeVal; --Shape output is assigned
		Ampl <= AmplVal;--Amplitude output is assigned
		Freq <= FreqVal;--Frequency output is assigned
		SigEn <= Enable;
		--LED <= ByteIn;
		--LED(7) <= Enable;
		LED <= SyncVal;
		--LED <= AmplVal;
		--LED <= FreqVal;
		--LED <= "000000" & ShapeVal;
		
end Behavioral;

