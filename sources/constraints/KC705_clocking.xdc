#######################   Clocking   ##########################
create_clock -period 5.000 -name {clk_sys_diff[0]} [get_ports {clk_sys_diff[0]}]
create_clock -period 8.000 -name {clk_trans_diff[0]} [get_ports {clk_trans_diff[0]}]