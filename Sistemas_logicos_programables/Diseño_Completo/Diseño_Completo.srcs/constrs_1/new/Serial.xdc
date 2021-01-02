
set_property PACKAGE_PIN A18 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports rx]
set_property PACKAGE_PIN T18 [get_ports reset]
#set_property PACKAGE_PIN U18 [get_ports tx_start]
#set_property IOSTANDARD LVCMOS33 [get_ports tx_start]
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]


set_property IOSTANDARD LVCMOS33 [get_ports tx_enable]

create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]



set_property PACKAGE_PIN U18 [get_ports tx_enable]
set_property PACKAGE_PIN B18 [get_ports rx]
