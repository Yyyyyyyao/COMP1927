library verilog;
use verilog.vl_types.all;
entity lab11part2_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        data            : in     vl_logic_vector(7 downto 0);
        resetn          : in     vl_logic;
        run             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end lab11part2_vlg_sample_tst;
