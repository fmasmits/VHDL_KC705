#######################   Clocking   ##########################
create_clock -period 8.000 -name {clk_trans_diff[0]} -waveform {0.000 4.000} [get_ports {clk_trans_diff[0]}]