library verilog;
use verilog.vl_types.all;
entity lab11part2_vlg_check_tst is
    port(
        found           : in     vl_logic;
        mem_addr        : in     vl_logic_vector(4 downto 0);
        sampler_rx      : in     vl_logic
    );
end lab11part2_vlg_check_tst;
