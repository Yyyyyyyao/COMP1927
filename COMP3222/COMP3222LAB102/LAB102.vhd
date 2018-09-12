LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY LAB102 IS
PORT ( x0,x1,x2,x3 : IN STD_LOGIC;
		 y0,y1,y2,y3 : IN STD_LOGIC;
		 s : IN STD_LOGIC;
		 m0,m1,m2,m3 : OUT STD_LOGIC);
END LAB102;

ARCHITECTURE Behavior OF LAB102 IS
BEGIN
	m0 <= (NOT (s) AND x0) OR (s AND y0);
	m1 <= (NOT (s) AND x1) OR (s AND y1);
	m2 <= (NOT (s) AND x2) OR (s AND y2);
	m3 <= (NOT (s) AND x3) OR (s AND y3);
END Behavior;