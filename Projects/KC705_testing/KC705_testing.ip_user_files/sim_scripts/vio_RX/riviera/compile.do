transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -incr "+incdir+../../../../KC705_testing.gen/sources_1/ip/vio_RX/hdl/verilog" "+incdir+../../../../KC705_testing.gen/sources_1/ip/vio_RX/hdl" -l xpm -l xil_defaultlib \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93  -incr \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../../KC705_testing.gen/sources_1/ip/vio_RX/sim/vio_RX.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

