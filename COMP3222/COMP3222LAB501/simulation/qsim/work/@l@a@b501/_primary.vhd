library verilog;
use verilog.vl_types.all;
entity LAB501 is
    port(
        SW              : in     vl_logic_vector(8 downto 0);
        KEY             : in     vl_logic_vector(0 downto 0);
        LEDG            : out    vl_logic_vector(0 downto 0);
        LEDR            : out    vl_logic_vector(8 downto 0)
    );
end LAB501;
