#####################   Package pins    #######################
set_property PACKAGE_PIN AD12 [get_ports {clk_sys_in_diff[0]}]
set_property PACKAGE_PIN AD11 [get_ports {clk_sys_in_diff[1]}]
set_property PACKAGE_PIN Y23 [get_ports clk_sys_out]

#####################   I/O standards   #######################
set_property IOSTANDARD LVDS [get_ports {clk_sys_in_diff[0]}]
set_property IOSTANDARD LVDS [get_ports {clk_sys_in_diff[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports clk_sys_out]

