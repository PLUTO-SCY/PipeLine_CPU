set_property -dict {PACKAGE_PIN F6 IOSTANDARD LVCMOS33} [get_ports {leds[7]}]
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports {leds[6]}]
set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports {leds[5]}]
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {leds[4]}]
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports {leds[3]}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {leds[2]}]
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {leds[1]}]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {leds[0]}]

set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports {AN[3]}]
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports {AN[2]}]
set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVCMOS33} [get_ports {AN[1]}]
set_property -dict {PACKAGE_PIN H1 IOSTANDARD LVCMOS33} [get_ports {AN[0]}]

set_property -dict {PACKAGE_PIN B4 IOSTANDARD LVCMOS33} [get_ports {BCD[0]}]
set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {BCD[1]}]
set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {BCD[2]}]
set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports {BCD[3]}]
set_property -dict {PACKAGE_PIN A1 IOSTANDARD LVCMOS33} [get_ports {BCD[4]}]
set_property -dict {PACKAGE_PIN B3 IOSTANDARD LVCMOS33} [get_ports {BCD[5]}]
set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports {BCD[6]}]
set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS33} [get_ports {BCD[7]}]

set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {system_clk}]
set_property -dict {PACKAGE_PIN U4  IOSTANDARD LVCMOS33} [get_ports {reset}]

# create_clock -period 10 -name system_clk -waveform {0.000 5.000} -add [get_ports system_clk]


#S6
set_property PACKAGE_PIN R17 [get_ports uart_rst]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rst]

#S1
set_property PACKAGE_PIN R1 [get_ports mem2uart]
set_property IOSTANDARD LVCMOS33 [get_ports mem2uart]


#led 0
set_property PACKAGE_PIN K3 [get_ports recv_done]
set_property IOSTANDARD LVCMOS33 [get_ports recv_done]

#led 1
set_property PACKAGE_PIN M1 [get_ports send_done]
set_property IOSTANDARD LVCMOS33 [get_ports send_done]


#UART
set_property PACKAGE_PIN N5 [get_ports Rx_Serial]
set_property PACKAGE_PIN T4 [get_ports Tx_Serial]

set_property IOSTANDARD LVCMOS33 [get_ports Rx_Serial]
set_property IOSTANDARD LVCMOS33 [get_ports Tx_Serial]
