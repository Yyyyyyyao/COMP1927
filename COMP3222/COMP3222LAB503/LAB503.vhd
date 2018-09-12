LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY LAB503 is
	GENERIC (N: INTEGER := 4);
	PORT(SW: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		  LEDR: OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		  LEDG: OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
		  KEY: IN STD_LOGIC_VECTOR(0 DOWNTO 0));
END LAB503;

ARCHITECTURE Behavior OF LAB503 IS

	SIGNAL Clk: STD_LOGIC;
	SIGNAL Resetn: STD_LOGIC;
	SIGNAL Q: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL R: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL z: STD_LOGIC;
	SIGNAL w: STD_LOGIC;
	SIGNAL v1,v0: STD_LOGIC;
	SIGNAL l: STD_LOGIC;
	
BEGIN 
	
	Resetn <=SW(0);
	Clk <= KEY(0);
	w <= SW(1);
	l <= SW(2);
	
	PROCESS(Resetn, Clk, Q, R, w)
	BEGIN 
		IF Resetn = '0' THEN
			Q <= "0000";
			R <= "1111";
		ELSIF Clk'EVENT AND Clk = '1' THEN
				Genbits_s: FOR i IN 0 TO N-2 LOOP	
					Q(i) <= Q(i+1);
					R(i) <= R(i+1);
				END LOOP;
				Q(N-1) <= w;
				R(N-1) <= w;
		END IF;
	END PROCESS;
	v0 <= Q(0) AND Q(1) AND Q(2) AND Q(3);
	v1 <= R(0) OR R(1) OR R(2) OR R(3);	
	
	z <= v0 OR NOT(v1);
	
	LEDG(0) <= z;
	
	
END Behavior;