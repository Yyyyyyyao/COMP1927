LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY LAB205 IS
PORT ( SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		 HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		 HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		 HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END LAB205;

ARCHITECTURE Behavior OF LAB205 IS
	COMPONENT char_7seg
		PORT ( C : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				Display0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT;
	


	COMPONENT circuit_b
			PORT (s : IN STD_LOGIC;
					K: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT;

SIGNAL C: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL A: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL B: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL S0: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL S1: STD_LOGIC_VECTOR(4 DOWNTO 0);
	
	
	
SIGNAL T: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL D: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL E: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	
BEGIN
	
	C(0) <= SW(8);
	A <= SW(7 DOWNTO 4);
	B <= SW(3 DOWNTO 0);
	
	PROCESS(T, A, B, C, D, E)
	BEGIN 
		T <= ('0'&A)+('0'&B)+("0000"&C(0));
		IF T > "1001" THEN
			D <= "1010";
			E <= "0001";
		ELSE
			D <= "0000";
			E <= "0000";
		END IF;
		S0 <= T - ('0'&D);
		S1 <= ('0'&E);
		
	END PROCESS;
	
	M3: char_7seg PORT MAP (S0(3 DOWNTO 0), HEX0);
	M4: circuit_b PORT MAP (E(0), HEX1);
	M5: char_7seg PORT MAP (A, HEX3);
	M6: char_7seg PORT MAP (B, HEX2);
	
END Behavior;



--Circuit_B
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