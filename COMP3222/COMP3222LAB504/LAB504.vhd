LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY LAB504 IS
	PORT(SW: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		  LEDR: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		  	CLOCK_50 : IN STD_LOGIC;
		  KEY: IN STD_LOGIC_VECTOR(1 DOWNTO 0));
END LAB504;

ARCHITECTURE Behavior OF LAB504 IS

SIGNAL Resn : STD_LOGIC;
SIGNAL Clk : STD_LOGIC;


CONSTANT A: STD_LOGIC_VECTOR(2 DOWNTO 0):= "000";
CONSTANT B: STD_LOGIC_VECTOR(2 DOWNTO 0):= "001";
CONSTANT C: STD_LOGIC_VECTOR(2 DOWNTO 0):= "010";
CONSTANT D: STD_LOGIC_VECTOR(2 DOWNTO 0):= "011";
CONSTANT E: STD_LOGIC_VECTOR(2 DOWNTO 0):= "100";
CONSTANT F: STD_LOGIC_VECTOR(2 DOWNTO 0):= "101";
CONSTANT G: STD_LOGIC_VECTOR(2 DOWNTO 0):= "110";
CONSTANT H: STD_LOGIC_VECTOR(2 DOWNTO 0):= "111";
SIGNAL letter: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL letter_len: INTEGER RANGE 0 TO 4;

TYPE State_type IS(reset,loading, light_on, light_off);
SIGNAL curr_state: State_type;
SiGNAL next_state: State_type;
SIGNAL n: INTEGER range 0 to 74999999;

BEGIN

	Clk <= CLOCK_50;
	Resn <= KEY(0);

	PROCESS(Clk, Resn)
	BEGIN 
		IF Resn = '0' THEN
			curr_state <= reset;
		ELSIF Clk'EVENT AND Clk = '1' THEN
			curr_state <= next_state;
			IF curr_state = loading THEN
				LEDR(0) <= '0';
			CASE SW IS
				WHEN A=> 
					letter <= "XX01";
					letter_len <= 2;
				WHEN B=>
					letter <= "1110";
					letter_len <= 4;
				WHEN C=>
					letter <= "1010";
					letter_len <= 4;
				WHEN D=>
					letter <= "X110";
					letter_len <= 3;
				WHEN E=>
					letter <= "XXX1";
					letter_len <= 1;
				WHEN F=>
					letter <= "1011";
					letter_len <= 4;
				WHEN G=>
					letter <= "X100";
					letter_len <= 3;
				WHEN H=>
					letter <= "1111";
					letter_len <= 4;
			END CASE;
			IF KEY(1) = '0' THEN
				next_state <= light_on;
			END IF;
			ELSIF curr_state = light_on THEN
				LEDR(0) <= '1';
				IF letter(0) = '1' THEN 
					IF n = 24999999 THEN 
						n <= 0;
						next_state <= light_off;
						letter_len <= letter_len -1;
						letter(2 DOWNTO 0) <= letter(3 DOWNTO 1);
					ELSE
						n <= n+1;
					END IF;
				ELSIF letter(0) = '0' THEN
					IF n = 74999999 THEN 
						n <= 0;
						next_state <= light_off;
						letter_len <= letter_len -1;
						letter(2 DOWNTO 0) <= letter(3 DOWNTO 1);
					ELSE
						n <= n+1;
					END IF;
				END IF;
			ELSIF  curr_state = light_off THEN
				LEDR(0) <= '0';
				IF n = 24999999 THEN	
					n <= 0;
					IF letter_len = 0 THEN
						next_state <= loading;
					ELSE
						next_state <= light_on;
					END IF;	
				ELSE	
					n<= n+1;
				END IF;
			ELSIF curr_state = reset THEN
				LEDR(0) <= '0';
				next_state <= loading;
			END IF;
		END IF;
	END PROCESS;
	

END Behavior;



