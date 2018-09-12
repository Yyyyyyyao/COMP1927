LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY LAB502 IS PORT (SW : IN STD_logic_VECTOR (1 DOWNTO 0);
							 KEY : IN STD_logic_VECTOR (0 DOWNTO 0);
							 LEDR : OUT STD_logic_VECTOR (3 DOWNTO 0);
							 LEDG : OUT STD_logic_VECTOR (0 DOWNTO 0));
		
END LAB502;

ARCHITECTURE Behavior OF LAB502 IS
SIGNAL w,z : std_logic;
SIGNAL Res : std_logic;
SIGNAL Clk : std_logic;
TYPE State_type IS (A, B, C, D, E, F, G, H, I);
-- Attribute to declare a specific encoding for the states
attribute syn_encoding : string;
attribute syn_encoding of State_type : type is "0000 0001 0010 0011 0100 0101 0110 0111 1000";

	SIGNAL y_present, y_next : State_type; -- y_Q is present state, y_D is next state
BEGIN

	PROCESS (w, y_present) -- state table
	BEGIN
		CASE y_present IS
			WHEN A=>		
			
				IF w='0' THEN
					y_next<=B;
				ELSE 
					y_next<=F;
				END IF;
			WHEN B=>
			
				IF w='0' THEN
					y_next<=C;
				ELSE 
					y_next<=F;
				END IF;
			WHEN C=>
				
				IF w='0' THEN
					y_next<=D;
				ELSE 
					y_next<=F;
				END IF;
			WHEN D=>
		
				IF w='0' THEN
					y_next<=E;
				ELSE 
					y_next<=F;
				END IF;
			WHEN E=>

				IF w='0' THEN
					y_next<=E;
				ELSE 
					y_next<=F;
				END IF;
			WHEN F=>
				
				IF w='0' THEN
					y_next<=B;
				ELSE 
					y_next<=G;
				END IF;
			WHEN G=>
			
				IF w='0' THEN
					y_next<=B;
				ELSE 
					y_next<=H;
				END IF;
			WHEN H=>
				
				IF w='0' THEN
					y_next<=B;
				ELSE 
					y_next<=I;
				END IF;
			WHEN I=>
			
				IF w='0' THEN
					y_next<=B;
				ELSE 
					y_next<=I;
				END IF;
		END CASE;
	END PROCESS;
	
	PROCESS (Clk,Res) -- state flip-flops
	BEGIN
		IF Res = '0' THEN
			y_present <= A;
		ELSIF (Clk'EVENT AND Clk = '1') THEN
			y_present<=y_next;
		END IF;
	END PROCESS;
	
	PROCESS (y_present)
	BEGIN	
		IF y_present = A THEN
			LEDR<="0000";
			z<='0';
		ELSIF y_present = B THEN
			LEDR <="0001";
			z<='0';
		ELSIF y_present = C THEN
			LEDR <= "0010";
			z<='0';
		ELSIF y_present = D THEN
			LEDR<="0011";
			z<='0';
		ELSIF y_present = E THEN
			z<='1';
			LEDR<="0100";
		ELSIF y_present =F THEN 
			LEDR<="0101";
			z<='0';
		ELSIF y_present = G then
			LEDR<="0110";
			z<='0';
		ELSIF y_present = H then
			LEDR<="0111";
			z<='0';
		ELSIF y_present = I THEN
			z<='1';
			LEDR<="1000";
		END IF;
	END PROCESS;
	w<=SW(1);
	Res<=SW(0);
	Clk<=KEY(0);
	LEDG(0)<=z;
END Behavior;