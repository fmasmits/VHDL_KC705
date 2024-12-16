#######################   Clocking   ##########################
create_clock -period 5.000 -name {clk_sys_in_diff[0]} -waveform {0.000 2.500} [get_ports {clk_sys_in_diff[0]}]