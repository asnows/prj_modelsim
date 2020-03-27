
#create_clock -period 2.245 -name clkin_p [get_ports clkin_p]
#set_property PACKAGE_PIN C20 [get_ports clrl_refclk]
#set_property PACKAGE_PIN B20 [get_ports dataout_p]
#set_property PACKAGE_PIN B19 [get_ports tx_clkdiv]
#set_property PACKAGE_PIN A20 [get_ports reset]

##35
#set_property PACKAGE_PIN L19 [get_ports clkin_p]

#set_property PACKAGE_PIN K17 [get_ports {datain_p[3]}]
#set_property PACKAGE_PIN J20 [get_ports {datain_p[2]}]
#set_property PACKAGE_PIN K19 [get_ports {datain_p[1]}]
#set_property PACKAGE_PIN G19 [get_ports {datain_p[0]}]

#set_property IOSTANDARD LVDS_25 [get_ports clkin_p]
#set_property IOSTANDARD LVDS_25 [get_ports {datain_p[3]}]
#set_property IOSTANDARD LVDS_25 [get_ports {datain_p[2]}]
#set_property IOSTANDARD LVDS_25 [get_ports {datain_p[1]}]
#set_property IOSTANDARD LVDS_25 [get_ports {datain_p[0]}]



#set_property IOSTANDARD LVCMOS25 [get_ports clrl_refclk]
#set_property IOSTANDARD LVCMOS25 [get_ports dataout_p]
#set_property IOSTANDARD LVCMOS25 [get_ports tx_clkdiv]
#set_property IOSTANDARD LVCMOS25 [get_ports reset]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clrl_refclk]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clkin_p]


#set_property BEL MMCME2_ADV [get_cells lvds_i/lvds_gen_rxclk_i/MMCME2_BASE_inst]
#set_property LOC MMCME2_ADV_X1Y2 [get_cells lvds_i/lvds_gen_rxclk_i/MMCME2_BASE_inst]
#set_property BEL IDELAYCTRL [get_cells lvds_i/lvds_gen_rxclk_i/IDELAYCTRL_inst]
#set_property LOC IDELAYCTRL_X1Y2 [get_cells lvds_i/lvds_gen_rxclk_i/IDELAYCTRL_inst]





