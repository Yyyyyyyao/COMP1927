LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY LAB401 IS

PORT ( SW: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		KEY: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		HEX1: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END LAB401;

ARCHITECTURE Behavior OF LAB401 IS

	COMPONENT T_D_gate
		PORT ( Clk, T, Clear : IN STD_LOGIC ;
				 Q : OUT STD_LOGIC) ;
	END COMPONENT;

	COMPONENT char_7seg
		PORT ( V : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 Display : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT;
	
	
SIGNAL Clear: STD_LOGIC;
SIGNAL Enable: STD_LOGIC;
SIGNAL Clk: STD_LOGIC;
SIGNAL Q: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL V: STD_LOGIC_VECTOR(7 DOWNTO 0);


BEGIN

	Clk <= KEY(0);
	Enable <= SW(1);
	Clear <= SW(0);
	

	M0: T_D_gate PORT MAP(Clk, Enable, Clear, Q(0));
	M1: V(7) <= Enable AND Q(0);
	M2: T_D_gate PORT MAP(Clk, V(7), Clear, Q(1));
	M3: V(6) <= V(7) AND Q(1);
	M4: T_D_gate PORT MAP(Clk, V(6), Clear, Q(2));
	M5: V(5) <= V(6) AND Q(2);	
	M6: T_D_gate PORT MAP(Clk, V(5), Clear, Q(3));
	M7: V(4) <= V(5) AND Q(3);	
	M8: T_D_gate PORT MAP(Clk, V(4), Clear, Q(4));
	M9: V(3) <= V(4) AND Q(4);	
	M10: T_D_gate PORT MAP(Clk, V(3), Clear, Q(5));
	M11: V(2) <= V(3) AND Q(5);	
	M12: T_D_gate PORT MAP(Clk, V(2), Clear, Q(6));
	M13: V(1) <= V(2) AND Q(6);	
	M14: T_D_gate PORT MAP(Clk, V(1), Clear, Q(7));

	
	M15: char_7seg PORT MAP(Q(3 DOWNTO 0), HEX0);
	M16: char_7seg PORT MAP(Q(7 DOWNTO 4), HEX1);
	

END Behavior;


--T_D_gate
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY T_D_gate IS
	PORT ( Clk, T, Clear : IN STD_LOGIC ;
			 Q : OUT STD_LOGIC) ;
	END T_D_gate;
ARCHITECTURE Behavior OF T_D_gate IS

SIGNAL Count: STD_LOGIC;

BEGIN
	PROCESS (Clk,T)
	BEGIN
		IF Clear = '0' THEN
			Count <= '0';
		ELSIF (Clk'EVENT AND Clk = '1') THEN
			IF T = '1'THEN
				Count <= T XOR Count;
			ELSE
				Count <= Count;
			END IF;
		END IF;
	END PROCESS;
	Q <= Count;
END Behavior;



--char_7seg
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY char_7seg IS
	PORT ( V : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 Display : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END char_7seg;

ARCHITECTURE Behavior OF char_7seg IS
BEGIN
	WITH V SELECT
		Display <= "1000000" WHEN "0000",--0
					  "1111001" WHEN "0001",--1
						"0100100" WHEN "0010",--2
						"0110000" WHEN "0011",--3
						"0011001" WHEN "0100",--4
						"0010010" WHEN "0101",--5
						"0000010" WHEN "0110",--6
						"1011000" WHEN "0111",--7
						"0000000" WHEN "1000",--8
						"0010000" WHEN "1001",--9
						"0001000" WHEN "1010",--A
						"0000011" WHEN "1011",--b
						"1000110" WHEN "1100",--C
						"0100001" WHEN "1101",--d
						"0000110" WHEN "1110",--E
						"0001110" WHEN "1111";--F
END Behavior;

