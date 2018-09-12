onerror {quit -f}
vlib work
vlog -work work LAB204.vo
vlog -work work LAB204.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.LAB204_vlg_vec_tst
vcd file -direction LAB204.msim.vcd
vcd add -internal LAB204_vlg_vec_tst/*
vcd add -internal LAB204_vlg_vec_tst/i1/*
add wave /*
run -all
