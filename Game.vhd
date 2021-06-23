library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Game is
    Port (	ClockGame : in  STD_LOGIC;
				ResetGame : in  STD_LOGIC);
end Game;

architecture Behavioral of Game is

    COMPONENT Countdown
    PORT(
         Clock : IN  std_logic;
         Clear : IN  std_logic;
         Enable : IN  std_logic;
         StartNumber : IN  std_logic_vector(31 downto 0);
			TimeOut: out STD_LOGIC_VECTOR (31 downto 0);
         Finish : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs   
   signal ClearCountdown : std_logic := '0';
   signal EnableCountdown : std_logic := '0'; 
   signal StartNumberCountdown : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal FinishCountdown : std_logic;	
	signal TimeOutCountdown : std_logic_vector(31 downto 0);

    COMPONENT RNG
    PORT(
         Clock : IN  std_logic;
         Reset : IN  std_logic;
         Enable : IN  std_logic;
         Output : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ResetRNG : std_logic := '0';
   signal EnableRNG : std_logic := '1'; -- generowanie liczb bedzie zawsze wlaczone

 	--Outputs
   signal OutputRNG : std_logic_vector(7 downto 0);

    COMPONENT Timer
    PORT(
         Clock : IN  std_logic;
         Clear : IN  std_logic;
         Enable : IN  std_logic;
         TimeOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ClearTimer : std_logic := '0';
   signal EnableTimer : std_logic := '0';

 	--Outputs
   signal TimeOutTimer : std_logic_vector(31 downto 0);
	
	-- Sygna³ zegarowy
	signal Clock : std_logic := '0';
	-- Sygna³ wskazuj¹cy czy z klawiatury by³a jakaœ 'akcja', równoznaczny z DO_Rdy z modu³u PS2_Kbd
	signal KeyboardInput : std_logic := '0';
	-- Stan gry
	type StateType is (StartScreen, BeginCountdown, LightsOn, TimerOn, LightsOut, EndScreen);
	signal GameState : StateType := StartScreen;
	-- StartScreen - wyœwietlenie ekranu startowego i czekanie na rozpoczêcie gry przez u¿ytkownika
	-- BeginCountdown - rozpoczecie odliczania
	-- 2 - wypisanie na ekranie swiatel, czekanie na koniec odliczania
	-- 3 - rozpoczecie timera
	-- 4 - zgasniecie swiatel, czekanie na reakcje uzytkownika
	-- 5 - uzytkownik zareagowal, konczymy timer
	-- 6 - wypisujemy czas na ekranie, gdy uzytkownik nacisnie jakis guzik wraca do 'kroku' 0

begin

	-- Instantiate Countdown
   _ctd: Countdown PORT MAP (
          Clock => Clock,
          Clear => ClearCountdown,
          Enable => EnableCountdown,
          StartNumber => StartNumberCountdown,
			 TimeOut => TimeOutCountdown,
          Finish => FinishCountdown
        );
		  
	-- Instantiate RNG
	_rng: RNG PORT MAP (
          Clock => Clock,
          Reset => ResetRNG,
          Enable => EnableRNG,
          Output => OutputRNG
        );
		  
	-- Instantiate Timer
   _timer: Timer PORT MAP (
          Clock => Clock,
          Clear => ClearTimer,
          Enable => EnableTimer,
          TimeOut => TimeOutTimer
        );
	
		  
	process(Clock)
	begin
		if rising_edge(Clock) then
			if ResetGame = '1' then
				GameState <= StartScreen;
			else
				case GameState is
					
					when StartScreen =>
						-- wyswietlenie tekstu						
						-- jesli uzytkownik cos kliknal to przechodzimy do gry
						if KeyboardInput = '1' then
							GameState <= BeginCountdown;
							-- wyzerowanie aktywnosci klawiatury
							KeyboardInput <= '0';
						end if;
						
					when BeginCountdown =>
						-- wstawienie losowej liczby do modulu Countdown
						StartNumberCountdown <= OutputRNG & OutputRNG & OutputRNG & OutputRNG;
						-- wlaczenie modulu Countdown
						ClearCountdown <= '0';
						EnableCountdown <= '1';						
						GameState <= LightsOn;
						
					when LightsOn =>
						-- wyswietlanie swiatel
						-- czekanie na koniec countdown
						if FinishCountdown = '1' then
							-- jezeli koniec to wylaczamy countdown
							EnableCountdown <= '0';
							ClearCountdown <= '1';
							-- wyczyszczenie timera przed wlaczeniem go
							ClearTimer <= '1';
							GameState <= TimerOn;							
						end if;
						
					when TimerOn =>
						ClearTimer <= '0';
						EnableTimer <= '1';
						GameState <= LightsOut;
					
					when LightsOut =>
						-- czekanie na reakcje uzytkownika
						if KeyboardInput <= '1' then
							EnableTimer <= '0';
							GameState <= EndScreen;
						end if;
					
					when EndScreen =>
						-- wyswietlenie ekranu koncowego z czasem
						-- klikniecie -> zaczecie gry od nowa
						if KeyboardInput <= '1' then
							GameState <= StartScreen;
						end if;							
					
				end case;
			end if;
		end if;
	end process;


-- wyœwietlenie tekstu na ekranie (modu³ Sugiera)

-- odczyt klawiatury (modu³ Sugiera) (naciœniêcie np spacji to start)

-- je¿eli naciœniêto start

-- wypisz na ekranie "œwiate³" (modu³ Sugiera)

-- rozpocznij countdown z losow¹ liczb¹

-- po skoñczeniu countdown gasna swiatla i zaczyna sie timer

-- jednoczesnie czekamy na uzytkownika az wcisnie np spacje

-- jak nacisnie to konczymy dzialanie timera

-- pokazujemy czas na ekranie (modu³ Sugiera)

-- mozna zacz¹æ jeszcze raz jak sie kliknie cokolwiek (powrót do poczatku)

end Behavioral;

