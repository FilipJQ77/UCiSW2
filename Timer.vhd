library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Timer is
    Port ( 	Clock : in  STD_LOGIC;
				Clear : in STD_LOGIC;
				Enable : in STD_LOGIC;				
				TimeOut : out  STD_LOGIC_VECTOR (31 downto 0));
end Timer;

architecture Behavioral of Timer is
	signal TimeInternal : UNSIGNED(31 downto 0) := (others => '0');
begin

	process(Clock, Clear)
	begin
		if Clear = '1' then
			TimeInternal <= (others => '0');
		elsif rising_edge(Clock) then
			if Enable = '1' then
				TimeInternal <= TimeInternal + 1;
			end if;
		end if;
	end process;

	TimeOut <= STD_LOGIC_VECTOR(TimeInternal);

end Behavioral;