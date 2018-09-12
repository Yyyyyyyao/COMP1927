LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY LAB303 IS

PORT ( Clk,D: IN STD_LOGIC;
		 Q : OUT STD_LOGIC);
END LAB303;

ARCHITECTURE Behavior OF LAB303 IS
	COMPONENT D_gate
		PORT ( Clk,D: IN STD_LOGIC;
				 Q : OUT STD_LOGIC);
	END COMPONENT;
	
SIGNAL Qm: STD_LOGIC;
	
BEGIN

	M0: D_gate PORT MAP (NOT(Clk), D, Qm);
	M1: D_gate PORT MAP (Clk, Qm, Q);
	
	
END Behavior;
	
	
	
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY D_gate IS

PORT ( Clk,D: IN STD_LOGIC;
		 Q : OUT STD_LOGIC);
END D_gate;

ARCHITECTURE Structural OF D_gate IS

SIGNAL R_g, S_g, Qa, Qb : STD_LOGIC ;

ATTRIBUTE keep : boolean;
ATTRIBUTE keep of R_g, S_g, Qa, Qb : SIGNAL IS true;

BEGIN

S_g <= NOT(D AND Clk);
R_g <= NOT(NOT D AND Clk);
Qa <= NOT(S_g AND Qb);
Qb <= NOT(Qa AND R_g);


Q <= Qa;


END Structural;