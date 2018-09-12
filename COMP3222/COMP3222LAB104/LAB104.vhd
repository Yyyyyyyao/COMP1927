LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY LAB104 IS
PORT (c0, c1: IN STD_LOGIC;
		HEX0: OUT STD_LOGIC_VECTOR(0 TO 6));
END LAB104;

ARCHITECTURE Behavior OF LAB104 IS
BEGIN
	HEX0(0) <= NOT(NOT(c1) AND c0);
	HEX0(1) <= NOT((NOT(c1) AND NOT(c0)) OR (c1 AND NOT(c0)));
	HEX0(2) <= NOT((NOT(c1) AND NOT(c0)) OR (c1 AND NOT(c0)));
	HEX0(3) <= NOT((NOT(c1) AND NOT(c0)) OR (c0 AND NOT(c1)));
	HEX0(4) <= NOT((NOT(c1) AND NOT(c0)) OR (c0 AND NOT(c1)));
	HEX0(5) <= NOT(NOT(c1) AND c0);
	HEX0(6) <= NOT((NOT(c1) AND NOT(c0)) OR (c0 AND NOT(c1)));
END Behavior;