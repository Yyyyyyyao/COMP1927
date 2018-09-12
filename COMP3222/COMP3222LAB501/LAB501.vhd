LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY LAB501 IS 
	PORT(SW: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		  KEY: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		  LEDG: OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
		  LEDR: OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
		  
END LAB501;

ARCHITECTURE Behavior OF LAB501 IS 

	COMPONENT p_D_gate
		PORT ( D, Clk,Resetn : IN STD_LOGIC ;
			    Q : OUT STD_LOGIC) ;
	END COMPONENT;
	
	SIGNAL z: STD_LOGIC;
	SIGNAL w: STD_LOGIC;	
	SIGNAL Resetn: STD_LOGIC;
	SIGNAL Clock: STD_LOGIC;
	SIGNAL V: STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL y: STD_LOGIC_VECTOR(8 DOWNTO 0);
	
BEGIN 

	w <= SW(1);
	Resetn <= SW(0);
	Clock <= KEY(0);
	
	V(0) <= '1';
	V(1) <= NOT(w) AND (NOT(y(0)) OR y(5) OR y(6) OR y(7) OR y(8));
	V(2) <= NOT(w) AND y(1);
	V(3) <= NOT(w) AND y(2);
	V(4) <= NOT(w) AND (y(3) OR y(4));
	V(5) <= w AND NOT(y(5) OR y(6) OR y(7) OR y(8));
	V(6) <= w AND y(5);
	V(7) <= w AND y(6);
	V(8) <= w AND (y(7) OR y(8));
	
	z <= y(4) OR y(8);
	
	M0: p_D_gate PORT MAP (V(0), Clock, Resetn, y(0));
	M1: p_D_gate PORT MAP (V(1), Clock, Resetn, y(1));
	M2: p_D_gate PORT MAP (V(2), Clock, Resetn, y(2));
	M3: p_D_gate PORT MAP (V(3), Clock, Resetn, y(3));
	M4: p_D_gate PORT MAP (V(4), Clock, Resetn, y(4));
	M5: p_D_gate PORT MAP (V(5), Clock, Resetn, y(5));
	M6: p_D_gate PORT MAP (V(6), Clock, Resetn, y(6));
	M7: p_D_gate PORT MAP (V(7), Clock, Resetn, y(7));
	M8: p_D_gate PORT MAP (V(8), Clock, Resetn, y(8));
	
	LEDR <= y;
	
	LEDG(0) <= z;
	
END Behavior;



LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY p_D_gate IS
	PORT ( D, Clk, Resetn: IN STD_LOGIC ;
			 Q : OUT STD_LOGIC) ;
	END p_D_gate;
ARCHITECTURE Behavior OF p_D_gate IS

BEGIN
	PROCESS (Clk, Resetn)
	BEGIN
		IF Resetn = '0' THEN
			Q <= '0';			
		ELSIF Clk'event AND Clk = '1'THEN
			Q <= D ;
		END IF;
	END PROCESS;
END Behavior;





					