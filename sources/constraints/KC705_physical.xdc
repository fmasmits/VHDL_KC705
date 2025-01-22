#####################   Package pins    #######################
set_property PACKAGE_PIN AD12 [get_ports {clk_sys_diff[0]}]
set_property PACKAGE_PIN AD11 [get_ports {clk_sys_diff[1]}]
set_property PACKAGE_PIN G8 [get_ports {clk_trans_diff[0]}]
set_property PACKAGE_PIN G7 [get_ports {clk_trans_diff[1]}]
set_property PACKAGE_PIN K5 [get_ports {data_in_diff[1]}]
set_property PACKAGE_PIN K6 [get_ports {data_in_diff[0]}]
set_property PACKAGE_PIN K1 [get_ports {data_out_diff[1]}]
set_property PACKAGE_PIN K2 [get_ports {data_out_diff[0]}]

#####################   I/O standards   #######################
set_property IOSTANDARD LVDS [get_ports {clk_sys_diff[0]}]
set_property IOSTANDARD LVDS [get_ports {clk_sys_diff[1]}]


#####################   Bank0 pin   #######################
set_property CFGBVS Vcco [current_design]
set_property config_voltage 2.5 [current_design]