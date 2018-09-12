LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY LAB902 IS
    PORT (SW   : in  std_logic_vector(9 downto 0);
          KEY : in  std_logic_vector(3 downto 0);
          LEDR : out std_logic_vector(9 downto 0));
end LAB902;

ARCHITECTURE Behavior of LAB902 IS

	COMPONENT LAB901
		PORT(DIN                :IN STD_LOGIC_VECTOR(8 DOWNTO 0);
			  Resetn, Clock, Run :IN STD_LOGIC;
		     Done               :BUFFER STD_LOGIC;
		     BusWires           :BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT Counter
		PORT (Resetn, MClock :IN STD_LOGIC;
            Q :BUFFER STD_LOGIC_VECTOR(4 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT ROM1
		PORT(address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			  clock		: IN STD_LOGIC  := '1';
			  q		: OUT STD_LOGIC_VECTOR (8 DOWNTO 0));
	END COMPONENT;
	
	
	
SIGNAL DIN, BusWires: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL Resetn, Run, Done: STD_LOGIC;
SIGNAL MClock, PClock:STD_LOGIC;
SIGNAL Count: STD_LOGIC_VECTOR(4 downto 0);


BEGIN
	Run <= SW(9);
	Resetn <= KEY(0);
	MClock <= KEY(1);
	PClock <= KEY(2);
	LEDR(9) <= Done;
	LEDR(8 DOWNTO 0) <= BusWires;

	

	PROCESSER: LAB901 PORT MAP(DIN, Resetn, PClock, Run, Done, Buswires);
	Counter1: Counter PORT MAP(Resetn, MClock, Count);
	Memory: ROM1 PORT MAP(Count, MClock, DIN);

END Behavior;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all ;

ENTITY Counter IS
    PORT (Resetn, MClock :IN STD_LOGIC;
          Q        :BUFFER STD_LOGIC_VECTOR(4 DOWNTO 0));
END Counter;

ARCHITECTURE Behavior OF Counter IS
BEGIN
    PROCESS(MClock, Resetn)
    BEGIN
		IF Resetn = '0' THEN 
			Q <= "00000";
		ELSIF MClock'EVENT AND MClock = '1' THEN
			Q <= Q + '1';
		END IF;
	END PROCESS;
	 
END Behavior;





