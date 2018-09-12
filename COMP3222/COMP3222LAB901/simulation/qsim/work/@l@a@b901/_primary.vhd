library verilog;
use verilog.vl_types.all;
entity LAB901 is
    port(
        DIN             : in     vl_logic_vector(8 downto 0);
        Resetn          : in     vl_logic;
        Clock           : in     vl_logic;
        Run             : in     vl_logic;
        Done            : out    vl_logic;
        BusWires        : out    vl_logic_vector(8 downto 0)
    );
end LAB901;
