## FPGAOL ZYNQ XDC v2.1
## device xc7a35tfgg484-1

## CLOCK
set_property -dict { PACKAGE_PIN V18  IOSTANDARD LVCMOS33 } [get_ports {clk}]

## LED
set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33 } [get_ports {led[0]}]
set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports {led[1]}]
set_property -dict { PACKAGE_PIN C13   IOSTANDARD LVCMOS33 } [get_ports {led[2]}]
set_property -dict { PACKAGE_PIN B13   IOSTANDARD LVCMOS33 } [get_ports {led[3]}]
set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports {led[4]}]
set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports {led[5]}]
set_property -dict { PACKAGE_PIN A13   IOSTANDARD LVCMOS33 } [get_ports {led[6]}]
set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports {led[7]}]

## SWITCH
set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS33 } [get_ports {sw[0]}]
set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports {sw[1]}]
set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports {sw[2]}]
set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports {sw[3]}]
set_property -dict { PACKAGE_PIN C18   IOSTANDARD LVCMOS33 } [get_ports {sw[4]}]
set_property -dict { PACKAGE_PIN C19   IOSTANDARD LVCMOS33 } [get_ports {sw[5]}]
set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports {sw[6]}]
set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports {sw[7]}]

## BUTTON
set_property -dict {PACKAGE_PIN F20 IOSTANDARD LVCMOS33} [get_ports {btn}]

## SEG DATA 
set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports {seg_data[0]}]
set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports {seg_data[1]}]
set_property -dict { PACKAGE_PIN B20   IOSTANDARD LVCMOS33 } [get_ports {seg_data[2]}]
set_property -dict { PACKAGE_PIN A20   IOSTANDARD LVCMOS33 } [get_ports {seg_data[3]}]

## SEG AN
set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports {seg_an[0]}]
set_property -dict { PACKAGE_PIN A19   IOSTANDARD LVCMOS33 } [get_ports {seg_an[1]}]
set_property -dict { PACKAGE_PIN F19   IOSTANDARD LVCMOS33 } [get_ports {seg_an[2]}]

## UART
set_property -dict { PACKAGE_PIN F15  IOSTANDARD LVCMOS33 } [get_ports {uart_din}]
set_property -dict { PACKAGE_PIN F13  IOSTANDARD LVCMOS33 } [get_ports {uart_dout}]