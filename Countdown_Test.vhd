LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Countdown_Test IS
END Countdown_Test;
 
ARCHITECTURE behavior OF Countdown_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Countdown
    PORT(
         Clock : IN  std_logic;
         Clear : IN  std_logic;
         Enable : IN  std_logic;
         StartNumber : IN  std_logic_vector(31 downto 0);
			  TimeOut: out STD_LOGIC_VECTOR (31 downto 0); -- DO USUNIÊCIA POTEM
         Finish : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal Clear : std_logic := '0';
   signal Enable : std_logic := '0';
   signal StartNumber : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Finish : std_logic;
	
	signal TimeOut : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Countdown PORT MAP (
          Clock => Clock,
          Clear => Clear,
          Enable => Enable,
          StartNumber => StartNumber,
			 TimeOut => TimeOut,
          Finish => Finish
        );

   Clock <= not Clock after 10 ns;
	
	StartNumber <= x"00000010" after 15 ns;
	Enable <= '1' after 17 ns, '0' after 350 ns;
	Clear <= '1' after 355 ns, '0' after 356 ns;
	

END;
