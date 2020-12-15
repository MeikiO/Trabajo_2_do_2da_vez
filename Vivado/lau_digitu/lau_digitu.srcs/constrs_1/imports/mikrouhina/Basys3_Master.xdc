## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
## Switches
set_property PACKAGE_PIN V17 [get_ports {rst}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {rst}]
	


## LEDs
#set_property PACKAGE_PIN U16 [get_ports {led[0]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
#set_property PACKAGE_PIN E19 [get_ports {led[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
#set_property PACKAGE_PIN U19 [get_ports {led[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
#set_property PACKAGE_PIN V19 [get_ports {led[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
#set_property PACKAGE_PIN W18 [get_ports {led[4]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
#set_property PACKAGE_PIN U15 [get_ports {led[5]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
#set_property PACKAGE_PIN U14 [get_ports {led[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
#set_property PACKAGE_PIN V14 [get_ports {led[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
#set_property PACKAGE_PIN V13 [get_ports {led[8]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
#set_property PACKAGE_PIN V3 [get_ports {led[9]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
#set_property PACKAGE_PIN W3 [get_ports {led[10]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
#set_property PACKAGE_PIN U3 [get_ports {led[11]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
#set_property PACKAGE_PIN P3 [get_ports {led[12]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]
#set_property PACKAGE_PIN N3 [get_ports {led[13]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]
set_property PACKAGE_PIN P1 [get_ports {fin[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {fin[0]}]
set_property PACKAGE_PIN L1 [get_ports {fin[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {fin[1]}]
	

##Buttons
#set_property PACKAGE_PIN U18 [get_ports btnC]                        
    #set_property IOSTANDARD LVCMOS33 [get_ports btnC]
#set_property PACKAGE_PIN T18 [get_ports btnU]                        
    #set_property IOSTANDARD LVCMOS33 [get_ports btnU]
set_property PACKAGE_PIN W19 [w19]                        
    set_property IOSTANDARD LVCMOS33 [w19]
set_property PACKAGE_PIN T17 [t17]                        
    set_property IOSTANDARD LVCMOS33 [t17]
#set_property PACKAGE_PIN U17 [get_ports btnD]                        
    #set_property IOSTANDARD LVCMOS33 [get_ports btnD]
     	
	
#7 segment display
set_property PACKAGE_PIN W7 [get_ports {katodo[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {katodo[0]}]
set_property PACKAGE_PIN W6 [get_ports {katodo[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {katodo[1]}]
set_property PACKAGE_PIN U8 [get_ports {katodo[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {katodo[2]}]
set_property PACKAGE_PIN V8 [get_ports {katodo[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {katodo[3]}]
set_property PACKAGE_PIN U5 [get_ports {katodo[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {katodo[4]}]
set_property PACKAGE_PIN V5 [get_ports {katodo[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {katodo[5]}]
set_property PACKAGE_PIN U7 [get_ports {katodo[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {katodo[6]}]
set_property PACKAGE_PIN V7 [get_ports {katodo[7]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {katodo[7]}]

set_property PACKAGE_PIN U2 [get_ports {anodo[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {anodo[0]}]
set_property PACKAGE_PIN U4 [get_ports {anodo[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {anodo[1]}]
set_property PACKAGE_PIN V4 [get_ports {anodo[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {anodo[2]}]
set_property PACKAGE_PIN W4 [get_ports {anodo[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {anodo[3]}]

