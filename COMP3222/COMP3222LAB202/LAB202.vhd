LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY LAB202 IS
PORT ( SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		 HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END LAB202;

ARCHITECTURE Behavior OF LAB202 IS
	COMPONENT comparator
		PORT ( U : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				 z : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT char_7seg
		PORT ( C : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				Display0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT circuit_a
		PORT ( A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				 B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT mul_2to1
		PORT ( B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				 V : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				 s : IN STD_LOGIC;
				 M: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT circuit_b
			PORT (s : IN STD_LOGIC;
					K: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT;
	
	
SIGNAL M : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL V : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL B : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL z : STD_LOGIC;

	
	
	
BEGIN

	V <= SW(3 DOWNTO 0);
	M0: comparator PORT MAP (V, z);
	M1: circuit_a PORT MAP (V, B);
	M2: mul_2to1 PORT MAP (B, V, z, M);
	M3: char_7seg PORT MAP (M, HEX0);
	M4: circuit_b PORT MAP (z, HEX1);
	
	
	
	
END Behavior;


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY circuit_b IS
	PORT (s: IN STD_LOGIC;
			K: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END circuit_b;

ARCHITECTURE Behavior OF circuit_b IS
BEGIN
	K(0) <= s;
	K(1) <= '0';
	K(2) <= '0';
	K(3) <= s;
	K(4) <= s;
	K(5) <= s;
	K(6) <= '1';


END Behavior;




--mul_2to1
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mul_2to1 IS
	PORT ( B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 V : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 s : IN STD_LOGIC;
			 M: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END mul_2to1;

ARCHITECTURE Behavior OF mul_2to1 IS
BEGIN

	M(0) <= (s AND B(0)) OR (NOT(s) AND V(0));
	M(1) <= (s AND B(1)) OR (NOT(s) AND V(1));
	M(2) <= (s AND B(2)) OR (NOT(s) AND V(2));
	M(3) <= (s AND B(3)) OR (NOT(s) AND V(3));
	
END Behavior;





--Circuit_A
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY circuit_a IS
	PORT ( A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END circuit_a;

ARCHITECTURE Behavior OF circuit_a IS
BEGIN
	B(3) <= '0';
	B(2) <= A(1) AND A(2);
	B(1) <= NOT(A(1));
	B(0) <= A(0);
END Behavior;



--Comparator
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comparator IS
	PORT ( U : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 z : OUT STD_LOGIC);
END comparator;

ARCHITECTURE Behavior OF comparator IS
BEGIN
	z <= (U(2) AND U(3)) OR (U(1) AND U(3));
	
END Behavior;




--7 segment decoder
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY char_7seg IS
	PORT ( C : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 Display0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END char_7seg;

ARCHITECTURE Behavior OF char_7seg IS
BEGIN
	Display0(0) <= NOT(C(3) OR C(1) OR (C(2) AND C(0)) OR (NOT(C(2)) AND NOT(C(0))));
	Display0(1) <= NOT(NOT(C(2)) OR (NOT(C(1)) AND NOT(C(0))) OR (C(1) AND C(0)));
	Display0(2) <= NOT(C(2) OR NOT(C(1)) OR C(0));
	Display0(3) <= NOT((NOT(C(2)) AND NOT(C(0))) OR (C(1) AND NOT(C(0))) OR (C(2) AND NOT(C(1)) AND C(0)) OR (NOT(C(2)) AND C(1)) OR C(3));
	Display0(4) <= NOT((NOT(C(2)) AND NOT(C(0))) OR (C(1) AND NOT(C(0))));
	Display0(5) <= NOT(C(3) OR (NOT(C(1)) AND NOT(C(0))) OR (C(2) AND NOT(C(1))) OR (C(2) AND NOT(C(0))));
	Display0(6) <= NOT(C(3) OR (C(2) AND NOT(C(1))) OR (C(1) AND NOT(C(2))) OR (C(1) AND NOT(C(0))));
	
END Behavior;