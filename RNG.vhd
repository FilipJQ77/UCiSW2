library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RNG is
    Port ( Clock : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Enable : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (7 downto 0));
end RNG;

architecture Behavioral of RNG is
	signal OutputTemp: STD_LOGIC_VECTOR(7 downto 0) := x"77";	
begin

process(clock)
	variable Temp: STD_LOGIC := '0';
	begin
		if (Reset = '1') then
				OutputTemp <= x"01";
		elsif rising_edge(Clock) then			
			if Enable = '1' then
				Temp := OutputTemp(4) xor OutputTemp(3) XOR OutputTemp(2) XOR OutputTemp(0);
				OutputTemp <= Temp & OutputTemp(7 downto 1);
			end if;
		end if;
end process;

Output <= OutputTemp;

end Behavioral;