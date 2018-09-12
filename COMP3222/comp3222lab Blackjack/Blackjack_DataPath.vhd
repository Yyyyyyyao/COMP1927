----------------------------------------------------------------------------------
-- Company: UNSW
-- Engineer: Jorgen Peddersen
-- 
-- Create Date:    16:06:48 09/26/2006 
-- Design Name:    Blackjack Player
-- Module Name:    Blackjack Datapath - Structural 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Blackjack_DataPath is
  
  port (
    clk                       : in  std_logic;
    rst                       : in  std_logic;
    cardValue                 : in  std_logic_vector(3 downto 0);
    score                     : out std_logic_vector(4 downto 0);
    sel                       : in  std_logic;
    enaLoad, enaAdd, enaScore : in  std_logic;
	 --enaCounter_m, enaCounter_p: in  std_logic;	-- enable the plus or minus
	 enaCounter_p					: in std_logic_vector(1 downto 0);
	 Counter							: out std_logic_vector(4 downto 0); --Counter
    cmp11, cmp16, cmp21       : out std_logic);

end Blackjack_DataPath;

architecture Structural of Blackjack_DataPath is


	component regn 
		PORT(R   :IN    STD_LOGIC_VECTOR(4 DOWNTO 0);
		     Rin, Clock, rst :IN   STD_LOGIC;
			  Q   :out STD_LOGIC_VECTOR(4 DOWNTO 0));
	end component;
	
	component add
		PORT
	(
		dataa		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
	);
	end component;
	
	
	component compare11 
		PORT
	(
		dataa		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		aeb		: OUT STD_LOGIC 
	);
	end component;
	
	component compare16
		PORT
	(
		dataa		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		agb		: OUT STD_LOGIC 
	);
	end component;
	
	component compare21
		PORT
	(
		dataa		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		agb		: OUT STD_LOGIC 
	);
	end component;
	
--	component C_m
--		PORT(Rin, Clock, rst :IN   STD_LOGIC;
--			  Q   				:buffer STD_LOGIC_VECTOR(1 DOWNTO 0));
--	end component;
	
	component C_p
	PORT(Rin: in std_logic_VECTOR(1 downto 0);
			Clock, rst :IN   STD_LOGIC;
		  Q   :buffer STD_LOGIC_VECTOR(4 DOWNTO 0));
	end component;
	

SIGNAL Buswires: std_logic_vector(4 downto 0);
SIGNAL A: std_logic_vector(4 downto 0);
SIGNAL result: std_logic_vector(4 downto 0);
SIGNAL regAdd: std_logic_vector(4 downto 0) := "00000";
SIGNAL fake: std_logic_vector(4 downto 0);

begin  -- Structural

	card_correction: process(cardValue)
	begin 
		if cardValue = "0001" then
			Buswires <= "00000";
		elsif cardValue = "1011" then
			Buswires <= "01011";
		elsif cardValue = "1100" then
			Buswires <= "01010";
		elsif cardValue = "1101" then
			Buswires <= "01010";
		else
			Buswires <= '0' & cardValue(3 downto 0);
		end if;
	end process;

	
	minus: process(sel)	
		begin 
				if sel = '0' then
					fake <= "10110";
				else 
					fake <= Buswires;
				end if;
		end process;
	
	reg_A: regn port map(fake, enaLoad, clk, rst, A);
	
	comp11: compare11 port map(A, cmp11);
	
	counter_plus: C_p port map (enaCounter_p, clk, rst, Counter);
	
	add_A: add port map(A, regAdd, result);
	
		
	--counter_minus : C_m port map (enaCounter_m, clk, rst, Counter);
	
	reg_add: regn port map (result, enaAdd, clk, rst, regAdd);
	
	comp16: compare16 port map(regAdd, cmp16);
	
	comp21: compare21 port map(regAdd, cmp21);
	
	reg_score: regn port map (regAdd, enaScore, clk, rst,score);
	
	
	
	
	
	

	

	
end Structural;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY regn IS 
	PORT(R   :IN    STD_LOGIC_VECTOR(4 DOWNTO 0);
		  Rin, Clock, rst :IN   STD_LOGIC;
		  Q   :out STD_LOGIC_VECTOR(4 DOWNTO 0));
END regn;

ARCHITECTURE Behavior OF regn IS 
BEGIN	
	PROCESS(Clock, rst)
	BEGIN 
		IF rst = '0' THEN
			Q <= "00000";
		ELSIF Clock'EVENT AND Clock = '1' THEN
			IF Rin = '1' THEN
				Q <= R;
			END IF;
		END IF;		
	END PROCESS;
END Behavior;



--Counter_minus
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;


--ENTITY C_m IS 
--	PORT(Rin, Clock, rst :IN   STD_LOGIC;
--		  Q   :buffer STD_LOGIC_VECTOR(1 DOWNTO 0));
--END C_m;

--ARCHITECTURE Behavior OF C_m IS 
--BEGIN	
--	PROCESS(Clock, rst)
--	BEGIN 
--		IF rst = '0' THEN
	--		Q <= "00";
		--ELSIF Clock'EVENT AND Clock = '1' THEN
			--IF Rin = '1' THEN
				--Q <= Q - '1';
		--	END IF;
		--END IF;		
	--END PROCESS;
--END Behavior;


--Counter_plus
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY C_p IS 
	PORT(Rin: in std_logic_VECTOR(1 downto 0);
			Clock, rst :IN   STD_LOGIC;
		  Q   :buffer STD_LOGIC_VECTOR(4 DOWNTO 0));
END C_p;

ARCHITECTURE Behavior OF C_p IS 
BEGIN	
	PROCESS(Clock, rst)
	BEGIN 
		IF rst = '0' THEN
			Q <= "00000";
		ELSIF Clock'EVENT AND Clock = '1' THEN
			IF Rin = "11" THEN
				Q <= Q + 1;
			elsif Rin = "10" then
				Q <= Q - 1;
			END IF;
		END IF;		
	END PROCESS;
END Behavior;