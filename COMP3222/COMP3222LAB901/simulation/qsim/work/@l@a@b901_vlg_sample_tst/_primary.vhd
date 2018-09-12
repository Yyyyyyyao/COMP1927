library verilog;
use verilog.vl_types.all;
entity LAB901_vlg_sample_tst is
    port(
        Clock           : in     vl_logic;
        DIN             : in     vl_logic_vector(8 downto 0);
        Resetn          : in     vl_logic;
        Run             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end LAB901_vlg_sample_tst;
