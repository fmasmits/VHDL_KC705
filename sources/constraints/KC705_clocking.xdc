#######################   Clocking   ##########################
create_clock -period 8.000 -name {clk_trans_diff[0]} -waveform {0.000 4.000} [get_ports {clk_trans_diff[0]}]
create_clock -period 3.200 -name i_trans_wiz/gt0_txoutclkpcs_out -waveform {0.000 1.600} [get_pins i_trans_wiz/gt0_txoutclkpcs_out]