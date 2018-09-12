LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity test is
	port(sw: in std_logic_vector(4 downto 0);
		  ledr: out std_logic_vector(4 downto 0));
		  
end test;



architecture b of test is


	component compare
	PORT
	(
		dataa		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		agb		: OUT STD_LOGIC 
	);
	end component;

begin 

	cpm: compare port map(sw, ledr(0));
	
end b;