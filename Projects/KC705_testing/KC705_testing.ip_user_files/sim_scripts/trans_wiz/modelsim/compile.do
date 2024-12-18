vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm -64 -incr -mfcu  -sv \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93  \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -64 -93  \
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

