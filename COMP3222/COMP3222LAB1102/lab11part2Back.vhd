library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab11part2 is
 port (data   : in     std_logic_vector(7 downto 0);
       run    : in     std_logic;
       resetn : in     std_logic;
       clk    : in     std_logic;
       found  : buffer boolean;
       fnd_ad : out    std_logic_vector(4 downto 0));
end lab11part2;

architecture behaviour of lab11part2 is
    component memory_block
        port (address : in  std_logic_vector(4 downto 0);
              clock   : in  std_logic;
              q       : out unsigned(7 downto 0));
    end component;

signal location   : std_logic_vector(4 downto 0);
signal un_data    : unsigned(7 downto 0);
signal curr_mem   : unsigned(7 downto 0);
signal minA, midA : integer range 0 to 31;
signal maxA       : integer range 0 to 31;
type state is (s1, s2);
signal y : state;

begin
	un_data <= unsigned(data);

	statetable: process (clk, resetn)
	begin
		if resetn = '1' then
			y <= s1;
		elsif (clk'event and clk = '1') then
			case y is
				when s1 =>
					if run = '1' then
						y <= s2;
					else
						y <= s1;
					end if;
				when s2 =>
					if (found = true) then
						y <= s1;
					else
						y <= s2;
					end if;
			end case;
		end if;
	end process;
	
	controls: process (y, clk, run)
	variable min, mid, max : integer range 0 to 31;
	begin
		if (clk'event and clk = '1') and run = '1' then
			case y is
				when s1 =>
					minA <= 0;
					midA <= 15;
					maxA <= 31;
				when s2 =>
					if (to_integer(curr_mem) < to_integer(un_data)) then
						min := midA+1;
						max := maxA;
					elsif (to_integer(curr_mem) > to_integer(un_data)) then
						max := midA;
						min := minA;
					else
						max := midA;
						min := midA;
					end if;
					
					if (max = min) then
						found <= true;
						location <= std_logic_vector(to_unsigned(min, 5));
					else
						mid := (max + min) / 2;
					end if;
				
					minA <= min;
					maxA <= max;
			end case;
		end if;
	end process;
	 
	mem: memory_block
		port map (std_logic_vector(to_unsigned(midA, 5)), not clk, curr_mem);
  
	fnd_ad <= location;
	 
end behaviour;