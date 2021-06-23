LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

--USE ieee.numeric_std.ALL;
 
ENTITY Timer_Test IS
END Timer_Test;
 
ARCHITECTURE behavior OF Timer_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Timer
    PORT(
         Clock : IN  std_logic;
         Clear : IN  std_logic;
         Enable : IN  std_logic;
         TimeOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal Clear : std_logic := '0';
   signal Enable : std_logic := '0';

 	--Outputs
   signal TimeOut : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Timer PORT MAP (
          Clock => Clock,
          Clear => Clear,
          Enable => Enable,
          TimeOut => TimeOut
        );

   Clock <= not Clock after 10 ns;
	Enable <= '1' after 25 ns;
	Clear <= '1' after 85 ns, '0' after 86 ns;


END;
