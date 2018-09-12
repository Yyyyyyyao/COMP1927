LIBRARY ieee; 
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY LAB901 IS
	PORT(DIN                :IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		  Resetn, Clock, Run :IN STD_LOGIC;
		  Done               :BUFFER STD_LOGIC;
		  BusWires           :BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0));
END LAB901;


ARCHITECTURE Behavior OF LAB901 IS

	COMPONENT dec3to8
		PORT(W : IN   STD_LOGIC_VECTOR(2 DOWNTO 0);
			  En: IN   STD_LOGIC;
			  Y : OUT  STD_LOGIC_VECTOR(0 TO 7));
	END COMPONENT;
	
	COMPONENT regn
		GENERIC(n: INTEGER := 9);
		PORT(R   :IN    STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		     Rin, Clock :IN   STD_LOGIC;
		     Q   :BUFFER STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT trin
		GENERIC(n: INTEGER := 9);
		PORT(X :IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		     E :IN STD_LOGIC;
		     F :OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
TYPE State_type IS(T0, T1, T2, T3);
SIGNAL Tstep_Q, Tstep_D: State_type;
SIGNAL Rin, Rout, Xreg, Yreg : STD_LOGIC_VECTOR(0 TO 7);
SIGNAL Ain, Gin, Gout, AddSub, Extern, High: STD_LOGIC;
SIGNAL R0, R1, R2, R3, R4, R5, R6, R7, G, SUM, A: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL I : STD_LOGIC_VECTOR(1 TO 3);
SIGNAL IR: STD_LOGIC_VECTOR(1 TO 9);
SIGNAL Sel: STD_LOGIC_VECTOR(0 TO 9);

BEGIN 
	High <= '1';
	I <= IR(1 TO 3);
	decX: dec3to8 PORT MAP(IR(4 TO 6), High, Xreg);
	decY: dec3to8 PORT MAP(IR(7 TO 9), High, Yreg);
	
	statetable: PROCESS(Tstep_Q, Run, Done)
	BEGIN 
		CASE Tstep_Q IS
			WHEN T0 => 
				IF(Run = '0') THEN 
					Tstep_D <= T0;
				ELSE 
					Tstep_D <= T1;
				END IF;
			WHEN T1 => 
				IF(Done = '0') THEN 
					Tstep_D <= T2;
				ELSE 
					Tstep_D <= T0;
				END IF;				
			WHEN T2 =>
				Tstep_D <= T3;
			WHEN T3 =>
				IF(Done = '0') THEN 
					Tstep_D <= T3;
				ELSE 
					Tstep_D <= T0;
				END IF;
		END CASE;
	END  PROCESS;

	controlsignals :PROCESS(Tstep_Q, I, Xreg, Yreg)
	BEGIN 
		Rin <= "00000000";
		Rout <= "00000000";
		Done <= '0';
		Extern <= '0';
		Ain <= '0';
		Gin <= '0';
		Gout <= '0';
		AddSub <= '0';
		CASE Tstep_Q IS 
			WHEN T0 =>
				IR(1 TO 9) <= DIN(8 DOWNTO 0);
			WHEN T1 =>
				CASE I IS
					WHEN "000" =>
						Rin <= Xreg;
						Rout <= Yreg;
						Done <= '1';
					WHEN "001" =>
						Extern <='1';
						Rin <= Xreg;
						Done <= '1';
					WHEN "010" =>
						Rout <= Xreg;
						Ain <= '1';
					WHEN "011" =>
						Rout <= Xreg;
						Ain <= '1';	
					WHEN OTHERS=>
						
				END CASE;
			WHEN T2 =>
				CASE I IS
					WHEN "010" =>
						Rout <= Yreg;
						Gin <= '1';
					WHEN "011" =>
						Rout <= Yreg;
						Gin <= '1';
						AddSub <= '1';
					WHEN OTHERS=>
				END CASE;
			WHEN T3 =>
				CASE I IS
					WHEN "010" =>
						Gout <= '1';
						Rin <= Xreg;
						Done <= '1';
					WHEN "011" =>
						Gout <= '1';
						Rin <= Xreg;
						Done <= '1';
					WHEN OTHERS=>
				END CASE;	
		END CASE;
		END PROCESS;

		fsmflipflops: PROCESS(Clock, Resetn, Tstep_D)
			BEGIN 
				IF Resetn = '0' THEN	
					Tstep_Q <= T0;
				ELSIF Clock'EVENT AND Clock = '1' THEN	
					Tstep_Q <= Tstep_D;
				END IF;
			
			END PROCESS;
			
		reg_0: regn PORT MAP(BusWires, Rin(0), Clock, R0);
		reg_1: regn PORT MAP(BusWires, Rin(1), Clock, R1);		
		reg_2: regn PORT MAP(BusWires, Rin(2), Clock, R2);		
		reg_3: regn PORT MAP(BusWires, Rin(3), Clock, R3);		
		reg_4: regn PORT MAP(BusWires, Rin(4), Clock, R4);		
		reg_5: regn PORT MAP(BusWires, Rin(5), Clock, R5);		
		reg_6: regn PORT MAP(BusWires, Rin(6), Clock, R6);		
		reg_7: regn PORT MAP(BusWires, Rin(7), Clock, R7);		
		

		
		regA: regn PORT MAP(BusWires, Ain, Clock, A);
		
		WITH AddSub SELECT
			SUM <= A + BusWires WHEN '0',
					 A - BusWires WHEN OTHERS;
		
		regG: regn PORT MAP(SUM, Gin, Clock, G);

		Sel <= Rout & Gout & Extern;
		With Sel SELECT
		BusWires <= R0 WHEN "1000000000",
						R1 WHEN "0100000000",
						R2 WHEN "0010000000",
						R3 WHEN "0001000000",
						R4 WHEN "0000100000",
						R5 WHEN "0000010000",
						R6 WHEN "0000001000",
						R7 WHEN "0000000100",
						G  WHEN "0000000010",
						DIN WHEN others;
		
END Behavior;
		

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY dec3to8 IS
	PORT(W : IN   STD_LOGIC_VECTOR(2 DOWNTO 0);
		  En: IN   STD_LOGIC;
		  Y : OUT  STD_LOGIC_VECTOR(0 TO 7));
END dec3to8;

ARCHITECTURE Behavior OF  dec3to8 IS
BEGIN 
	PROCESS(W, En)
		BEGIN	
			IF En = '1' THEN
				CASE W IS
					WHEN "000" => Y <= "10000000";
					WHEN "001" => Y <= "01000000";
					WHEN "010" => Y <= "00100000";
					WHEN "011" => Y <= "00010000";
					WHEN "100" => Y <= "00001000";
					WHEN "101" => Y <= "00000100";
					WHEN "110" => Y <= "00000010";
					WHEN "111" => Y <= "00000001";
				END CASE;
			ELSE	
				Y <= "00000000";
			END IF;
	END PROCESS;
END Behavior;


LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY regn IS 
	GENERIC(n: INTEGER := 9);
	PORT(R   :IN    STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		  Rin, Clock :IN   STD_LOGIC;
		  Q   :BUFFER STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END regn;

ARCHITECTURE Behavior OF regn IS 
BEGIN	
	PROCESS(Clock)
	BEGIN 
		IF Clock'EVENT AND Clock = '1' THEN
			IF Rin = '1' THEN
				Q <= R;
			END IF;
		END IF;		
	END PROCESS;
END Behavior;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY trin IS
	GENERIC(n: INTEGER := 9);
	PORT(X :IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		  E :IN STD_LOGIC;
		  F :OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END trin;

ARCHITECTURE Behavior OF trin IS
BEGIN 
	F <=(OTHERS =>'Z') WHEN E = '0' ELSE X;
END Behavior;




















					
		
		
		