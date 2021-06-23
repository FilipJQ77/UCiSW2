LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY RNG_Test IS
END RNG_Test;
 
ARCHITECTURE behavior OF RNG_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RNG
    PORT(
         Clock : IN  std_logic;
         Reset : IN  std_logic;
         Enable : IN  std_logic;
         Output : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Enable : std_logic := '0';

 	--Outputs
   signal Output : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RNG PORT MAP (
          Clock => Clock,
          Reset => Reset,
          Enable => Enable,
          Output => Output
        );

   Clock <= not Clock after 10 ns;
	Enable <= '1';
	Reset <= '1' after 200 ns, '0' after 202 ns;

END;
