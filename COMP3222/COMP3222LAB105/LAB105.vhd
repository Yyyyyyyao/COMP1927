LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY LAB105 IS
PORT ( SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 LEDG : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
		 HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);
		 HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6));
END LAB105;

ARCHITECTURE Behavior OF LAB105 IS
	COMPONENT mux_2bit_3to1
		PORT ( S, U, V, W : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				 M : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT char_7seg
		PORT ( C : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				Display : OUT STD_LOGIC_VECTOR(0 TO 6));
	END COMPONENT;
	
	SIGNAL M : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL N : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL O : STD_LOGIC_VECTOR(1 DOWNTO 0);	
	SIGNAL U : STD_LOGIC_VECTOR(1 DOWNTO 0);	
BEGIN
	LEDR <= SW;
	U <= SW(1 DOWNTO 0);
	M0: mux_2bit_3to1 PORT MAP (SW(9 DOWNTO 8), SW(5 DOWNTO 4), SW(3 DOWNTO 2), U, M);
	H0: char_7seg PORT MAP (M, HEX2);
	
	M1: mux_2bit_3to1 PORT MAP (SW(9 DOWNTO 8), SW(3 DOWNTO 2), U, SW(5 DOWNTO 4), N);
	H1: char_7seg PORT MAP (N, HEX1);	

	M2: mux_2bit_3to1 PORT MAP (SW(9 DOWNTO 8), U, SW(5 DOWNTO 4), SW(3 DOWNTO 2), O);  		
	H2: char_7seg PORT MAP (O, HEX0);	
	LEDG <= M;
END Behavior;


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_2bit_3to1 IS
	PORT ( S, U, V, W : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			 M : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END mux_2bit_3to1;

ARCHITECTURE Behavior OF mux_2bit_3to1 IS
BEGIN
	M(0) <= (NOT (S(1)) AND ((NOT (S(0)) AND (U(0))) OR (S(0) AND V(0)))) OR (S(1) AND W(0));
	M(1) <= (NOT (S(1)) AND ((NOT (S(0)) AND (U(1))) OR (S(0) AND V(1)))) OR (S(1) AND W(1));
END Behavior;


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY char_7seg IS
	PORT ( C : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			 Display : OUT STD_LOGIC_VECTOR(0 TO 6));
END char_7seg;

ARCHITECTURE Behavior OF char_7seg IS
BEGIN
	Display(0) <= NOT(NOT(C(1)) AND C(0));
	Display(1) <= NOT((NOT(C(1)) AND NOT(C(0))) OR (C(1) AND NOT(C(0))));
	Display(2) <= NOT((NOT(C(1)) AND NOT(C(0))) OR (C(1) AND NOT(C(0))));
	Display(3) <= NOT((NOT(C(1)) AND NOT(C(0))) OR (C(0) AND NOT(C(1))));
	Display(4) <= NOT((NOT(C(1)) AND NOT(C(0))) OR (C(0) AND NOT(C(1))));
	Display(5) <= NOT(NOT(C(1)) AND C(0));
	Display(6) <= NOT((NOT(C(1)) AND NOT(C(0))) OR (C(0) AND NOT(C(1))));
END Behavior;