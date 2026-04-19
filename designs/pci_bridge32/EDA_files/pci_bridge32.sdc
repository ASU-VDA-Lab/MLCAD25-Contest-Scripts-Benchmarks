set_cmd_units -time ps -capacitance fF
set_max_fanout 16.000 [current_design]
create_clock -name clk -period 600.0 [get_ports pci_clk_i]

set_false_path  -from [get_ports {rst_i}]
set_false_path -to [get_pin */RESETN]
set_false_path -to [get_pin */SETN]

set_input_delay  -max -clock [get_clocks "clk"] -add_delay 20.0 [all_inputs -no_clocks]
set_output_delay -max -clock [get_clocks "clk"] -add_delay 20.0 [all_outputs]
set_input_delay  -min -clock [get_clocks "clk"] -add_delay 10.0 [all_inputs -no_clocks]
set_output_delay -min -clock [get_clocks "clk"] -add_delay 10.0 [all_outputs]

set_max_transition 2.0 [all_outputs]
set_input_transition -max 10.0 [all_inputs]
set_input_transition -min 2.0 [all_inputs]
