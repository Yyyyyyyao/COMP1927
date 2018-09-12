LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY LAB203 IS
	PORT (SW: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
			LEDR: OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
			LEDG: OUT STD_LOGIC_VECTOR(4 DOWNTO 0));
END LAB203;

ARCHITECTURE Behavior OF LAB203 IS

	SIGNAL C: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL A: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL B: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL S: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	
	COMPONENT full_adder
		PORT (Cin, x, y: IN STD_LOGIC;
				s, Cout: OUT STD_LOGIC);
	END COMPONENT;

BEGIN
	LEDR <= SW;
	C(0) <= SW(8);
	A <= SW(7 DOWNTO 4);
	B <= SW(3 DOWNTO 0);
	LEDG(4) <= C(4);
	LEDG(0) <= S(0); 
	LEDG(1) <= S(1); 
	LEDG(2) <= S(2);
	LEDG(3) <= S(3);
	step0: full_adder PORT MAP(C(0), A(0), B(0), S(0), C(1));
	step1: full_adder PORT MAP(C(1), A(1), B(1), S(1), C(2));
	step2: full_adder PORT MAP(C(2), A(2), B(2), S(2), C(3));
	step3: full_adder PORT MAP(C(3), A(3), B(3), S(3), C(4));


END Behavior;




LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY full_adder IS
	PORT (Cin, x, y: IN STD_LOGIC;
			s, Cout: OUT STD_LOGIC);
END full_adder;

ARCHITECTURE Behavior OF full_adder IS
BEGIN
	s <= x XOR y XOR Cin;
	Cout <= (x AND y) OR (Cin AND x) OR (Cin AND y);


END Behavior;