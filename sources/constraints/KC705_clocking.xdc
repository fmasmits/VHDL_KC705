#######################   Clocking   ##########################
create_clock -period 8.000 -name {clk_trans_diff[0]} -waveform {0.000 4.000} [get_ports {clk_trans_diff[0]}]


set_property C_CLK_INPUT_FREQ_HZ 100000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_sys_div2]
