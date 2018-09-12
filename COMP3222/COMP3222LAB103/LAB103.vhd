LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY LAB103 IS
PORT (  SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		m0,m1: OUT STD_LOGIC); 
END LAB103;

ARCHITECTURE Behavior OF LAB103 IS
signal u0,u1 : STD_LOGIC;
signal v0,v1 : STD_LOGIC;
signal w0,w1 : STD_LOGIC;
signal s0,s1 : STD_LOGIC;
BEGIN
	LEDR <= SW;
	s0 <= SW(9);
	s1 <= SW(8);
	w1 <= SW(0);
	w0 <= SW(1);
	v1 <= SW(2);
	v0 <= SW(3);
	u1 <= SW(4);
	u0 <= SW(5);
	m0 <= (NOT (s1) AND ((NOT (s0) AND (u0)) OR (s0 AND v0))) OR (s1 AND w0);
	m1 <= (NOT (s1) AND ((NOT (s0) AND (u1)) OR (s0 AND v1))) OR (s1 AND w1);
	
END Behavior;