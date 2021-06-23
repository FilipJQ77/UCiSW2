library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Countdown is
    Port ( Clock : in  STD_LOGIC;
           Clear : in  STD_LOGIC;
           Enable : in  STD_LOGIC;
           StartNumber : in  STD_LOGIC_VECTOR (31 downto 0);
			  TimeOut: out STD_LOGIC_VECTOR (31 downto 0); -- USUNAC POTEM (ALBO ZOSTAWIC, WHATEVER LMAO)
           Finish : out  STD_LOGIC);
end Countdown;

architecture Behavioral of Countdown is
	signal TimeInternal : UNSIGNED(31 downto 0) := x"00000000";
	signal FinishInternal : STD_LOGIC := '0';
begin

	-- ENABLE WCZYTUJE LICZBE I URUCHAMIA ODLICZANIE
	process(Clock, Clear, Enable)
	begin
		if Clear = '1' then
			TimeInternal <= x"00000000";
			FinishInternal <= '0';
		elsif rising_edge(Enable) then
				TimeInternal <= UNSIGNED(StartNumber);
				FinishInternal <= '0';
		elsif rising_edge(Clock) then			
			if Enable = '1' then
				if TimeInternal = 1 then -- NIE ZERO PONIEWAZ BEDZIE OPOZNIENIE JEDNEGO TICKU ZEGARA
					FinishInternal <= '1';
				else
					TimeInternal <= TimeInternal - 1;
					FinishInternal <= '0';
				end if;
			end if;
		end if;
	end process;
	
	Finish <= FinishInternal;
	TimeOut <= STD_LOGIC_VECTOR(TimeInternal);

end Behavioral;
