library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab11part2 is
 port (data      : in  std_logic_vector(7 downto 0);
       run       : in  std_logic;
       resetn    : in  std_logic;
       clk       : in  std_logic;
       found     : buffer boolean;
       mem_addr  : out std_logic_vector(4 downto 0));
end lab11part2;

architecture behaviour of lab11part2 is
    component memory_block
        port (address : in  std_logic_vector(4 downto 0);
              clock   : in  std_logic;
              q       : out std_logic_vector(7 downto 0));
    end component;

type state is (s1, s2);
signal y        : state;
signal mid      : integer range 0 to 31;
signal curr_mem : std_logic_vector(7 downto 0);
signal minA     : integer range 0 to 31;
signal midA     : integer range 0 to 31;
signal maxA     : integer range 0 to 31;

begin
	process (clk, resetn, run, curr_mem)
	variable min, max : integer range 0 to 31;
	begin
		if resetn = '1' then
			y     <= s1;
			minA  <= 0;
			midA  <= 15;
			maxA  <= 31;
			found <= false;
		elsif (clk'event and clk = '1') then
			case y is
				when s1 =>
					if (run = '1') then
						y <= s2;
					else
						y <= s1;
					end if;
				when s2 =>
					if (curr_mem > data) then
						max := midA;
						min := minA;
					elsif (curr_mem < data) then
						min := midA + 1;
						max := maxA;
					else
						found <= true;
						mem_addr <= std_logic_vector(to_unsigned(midA, 5));
						y <= s1;
					end if;
					
					midA <= (max + min) / 2;
					minA <= min;
					maxA <= max;
			end case;
		end if;
	end process;
	
	mem: memory_block
		port map (std_logic_vector(to_unsigned(midA, 5)), not clk, curr_mem);	
	
end behaviour;