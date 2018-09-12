library verilog;
use verilog.vl_types.all;
entity LAB304 is
    port(
        Clk             : in     vl_logic;
        D               : in     vl_logic;
        Qa              : out    vl_logic;
        Qb              : out    vl_logic;
        Qc              : out    vl_logic
    );
end LAB304;
