library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab11part2 is
 port (data   : in     std_logic_vector(7 downto 0);
       run    : in     std_logic;
       resetn : in     std_logic;
       clk    : in     std_logic;
       found  : buffer boolean;
       fnd_ad : out    unsigned(4 downto 0));
end lab11part2;

architecture behaviour of lab11part2 is
    component memory_block
        port (address : in  std_logic_vector(4 downto 0);
              clock   : in  std_logic;
              q       : out unsigned(7 downto 0));
    end component;

signal un_data    : unsigned(7 downto 0);
signal curr_mem   : unsigned(7 downto 0);
signal minA, midA : integer range 0 to 32;
signal maxA       : integer range 0 to 32;
type state is (s1, s2);
signal y : state;

begin
	
	mem: memory_block
		port map (std_logic_vector(to_unsigned(midA, 5)), clk, curr_mem);
	
	process (clk)
	variable min, mid, max : integer range 0 to 31;
	begin
		if (resetn = '1') then
			found <= false;
			y <= s1;
		elsif (y = s1 and run = '1') then
			found <= false;
			un_data <= unsigned(data);
			minA <= 0;
			midA <= 16;
			maxA <= 32;
			y <= s2;
		elsif (y = s2) then
			if (curr_mem < un_data) then
				min := minA + 1;
				max := maxA;
			elsif (curr_mem > un_data) then
				max := mid;
				min := minA;
			else
				min := mid;
				max := mid;
			end if;
			
			if (min = max) then
				found <= curr_mem = un_data;
				fnd_ad <= to_unsigned(min, 5);
				y <= s1;
			else
				midA <= (max + min) / 2;
			end if;
			
			minA <= min;
			maxA <= max;
		end if;
	end process;	 
end behaviour;