vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm -64 -incr -mfcu  -sv "+incdir+../../../../KC705_testing.gen/sources_1/ip/vio_RX/hdl/verilog" "+incdir+../../../../KC705_testing.gen/sources_1/ip/vio_RX/hdl" \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93  \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../../KC705_testing.gen/sources_1/ip/vio_RX/sim/vio_RX.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

