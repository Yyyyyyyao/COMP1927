LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY LAB404 IS

PORT ( SW: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		CLOCK_50 : IN STD_LOGIC;
		HEX0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END LAB404;

ARCHITECTURE Behavior OF LAB404 IS

	COMPONENT T_D_gate
		PORT ( Clk, T, Clear : IN STD_LOGIC ;
				 Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) ;
	END COMPONENT;

	COMPONENT char_7seg
		PORT ( V : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 Display : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT;
	
	
SIGNAL Clear: STD_LOGIC;
SIGNAL Enable: STD_LOGIC;
SIGNAL Clk: STD_LOGIC;
SIGNAL Q: STD_LOGIC_VECTOR(3 DOWNTO 0);



BEGIN

	Clk <= CLOCK_50;
	Enable <= SW(1);
	Clear <= SW(0);
	

	M0: T_D_gate PORT MAP(Clk, Enable, Clear, Q);

	
	M15: char_7seg PORT MAP(Q(3 DOWNTO 0), HEX0);


END Behavior;


--T_D_gate
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY T_D_gate IS
	PORT ( Clk, T, Clear : IN STD_LOGIC ;
			 Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) ;
	END T_D_gate;
ARCHITECTURE Behavior OF T_D_gate IS

SIGNAL Count: STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

	PROCESS (Clk,T)
	variable num: integer range 0 to 49999999;
	BEGIN
		IF Clear = '0' THEN
			num := 0;
		ELSIF (Clk'EVENT AND Clk = '1') THEN
			IF num = 49999999 THEN 
				num := 0;
				IF T = '1'THEN
					Count <= Count + 1;
				ELSE
					Count <= Count;
				END IF;
			ELSE 
				num := num + 1;
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