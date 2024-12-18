transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -incr -l xpm -l xil_defaultlib \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../../../../sources/ip/trans_wiz/trans_wiz_common_reset.vhd" \
"../../../../../../sources/ip/trans_wiz/trans_wiz_common.vhd" \
"../../../../../../sources/ip/trans_wiz/trans_wiz_gt_usrclk_source.vhd" \
"../../../../../../sources/ip/trans_wiz/trans_wiz_support.vhd" \
"../../../../../../sources/ip/trans_wiz/trans_wiz/example_design/trans_wiz_tx_startup_fsm.vhd" \
"../../../../../../sources/ip/trans_wiz/trans_wiz/example_design/trans_wiz_rx_startup_fsm.vhd" \
"../../../../../../sources/ip/trans_wiz/trans_wiz_init.vhd" \
"../../../../../../sources/ip/trans_wiz/trans_wiz_gt.vhd" \
"../../../../../../sources/ip/trans_wiz/trans_wiz_multi_gt.vhd" \
"../../../../../../sources/ip/trans_wiz/trans_wiz/example_design/trans_wiz_sync_block.vhd" \
"../../../../../../sources/ip/trans_wiz/trans_wiz.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

