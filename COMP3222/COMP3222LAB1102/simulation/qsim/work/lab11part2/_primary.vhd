library verilog;
use verilog.vl_types.all;
entity lab11part2 is
    port(
        data            : in     vl_logic_vector(7 downto 0);
        run             : in     vl_logic;
        resetn          : in     vl_logic;
        clk             : in     vl_logic;
        found           : out    vl_logic;
        mem_addr        : out    vl_logic_vector(4 downto 0)
    );
end lab11part2;
