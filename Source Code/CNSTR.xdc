set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -name clk -period 10.000 [get_ports clk]

# User LEDs - Bank 33 (PL general-purpose I/O)
set_property PACKAGE_PIN T22 [get_ports {Current_state[0]}]; # LD0
set_property PACKAGE_PIN T21 [get_ports {Current_state[1]}]; # LD1
set_property PACKAGE_PIN U22 [get_ports {Current_state[2]}]; # LD2
set_property PACKAGE_PIN U21 [get_ports {Current_state[3]}]; # LD3
set_property PACKAGE_PIN V22 [get_ports {Current_state[4]}]; # LD4
set_property PACKAGE_PIN W22 [get_ports {Current_state[5]}]; # LD5

# Set correct I/O standard for the LED pins
set_property IOSTANDARD LVCMOS33 [get_ports {Current_state[*]}];

# Reset pushbutton (BTN0)
set_property PACKAGE_PIN P16 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
