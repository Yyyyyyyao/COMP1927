LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY BJK IS 

	PORT(clk: in std_logic;
		  start: in std_logic; --reset
		  cardValue: in std_logic_vector(3 downto 0);
		  cardReady: in std_logic;
		  newCard: out std_logic;
		  lost: out std_logic;
		  finished: out std_logic;
		  score: out std_logic_vector(4 downto 0));
END BJK;

ARCHITECTURE Behavior OF BJK IS 

TYPE State_type IS (S1, S2, S3);
SIGNAL y: State_type;
SIGNAL Buswires: std_logic_vector(4 downto 0);
SIGNAL A: std_logic_vector(4 downto 0);
SIGNAL result: std_logic_vector(4 downto 0);


BEGIN
	
	Buswires <= 0 & sw(3 downto 0);
	
	
	fsm_tansition: process(start, clk)
	begin 
		if start = '0' then 
			y <= S1;
		elsif (clk'event and clk = '1') then
			case y is 
				when S1=> 
					y <= S2;
				when S2 =>
					if cardReady = '0' then
						y <= S2;
					else 
						y <= S3;
					end if;
				when S3 =>
					if cardReady = '0' the 
						y <= S4;
					else 
						y <= S3;
				when S4 =>
					if cmp16 = '1' then 
						y <= S2;
					elsif cmp16 = '0' then
						y <= S5;
					end if;
				when S5 =>
					y <= S5;
			end case;
		end if;
	end process;

	fsm_output: process(y)
	begin 
		cmp16 = '1';
		cmp21 = '1';
		enaLoad = '0';
		enaAdd = '0';
		enaScore = '0';
		newCard = '0';
		lost = '0';
		finished = '0';
		
		case y is 
			when S1 =>
				score <= "00000";
				A <= "00000";
				Buswires <= "00000";
				
			when S1 =>
				enaLoad = '1';
				newCard = '1';
			when S2 =>
				enaAdd = '1';
			when S3 =>
				enaScore = '1';
				enacmp16 = '1';
			when S4 =>
				enacmp21 = '1';
		end case;
	end process;
	
	
	data_path:
		reg_A: regn port map (Buswires, enaLoad, clk, A);
		add_A: add port map (score, A, result);
		reg_add: regn port map (result, enaAdd, clk, score);
		
		
		
		
		
end Behavior;


LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY regn IS 
	PORT(R   :IN    STD_LOGIC_VECTOR(4 DOWNTO 0);
		  Rin, Clock :IN   STD_LOGIC;
		  Q   :BUFFER STD_LOGIC_VECTOR(4 DOWNTO 0));
END regn;

ARCHITECTURE Behavior OF regn IS 
BEGIN	
	PROCESS(Clock)
	BEGIN 
		IF Clock'EVENT AND Clock = '1' THEN
			IF Rin = '1' THEN
				Q <= R;
			END IF;
		END IF;		
	END PROCESS;
END Behavior;
		
	
					

