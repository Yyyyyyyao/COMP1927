library verilog;
use verilog.vl_types.all;
entity LAB401_vlg_sample_tst is
    port(
        KEY             : in     vl_logic_vector(0 downto 0);
        SW              : in     vl_logic_vector(9 downto 0);
        sampler_tx      : out    vl_logic
    );
end LAB401_vlg_sample_tst;
