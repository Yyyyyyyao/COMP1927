library verilog;
use verilog.vl_types.all;
entity LAB401 is
    port(
        SW              : in     vl_logic_vector(9 downto 0);
        KEY             : in     vl_logic_vector(0 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX0            : out    vl_logic_vector(6 downto 0)
    );
end LAB401;
