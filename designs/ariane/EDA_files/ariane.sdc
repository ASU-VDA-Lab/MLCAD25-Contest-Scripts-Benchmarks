set_cmd_units -time ps -capacitance fF
set_max_fanout 16.000 [current_design]
create_clock -name clk -period 2500.0 [get_ports clk_i]
set_input_delay  -max -clock [get_clocks "clk"] -add_delay 90.0 [all_inputs -no_clocks]
set_output_delay -max -clock [get_clocks "clk"] -add_delay 90.0 [all_outputs]
set_input_delay  -min -clock [get_clocks "clk"] -add_delay 45.0 [all_inputs -no_clocks]
set_output_delay -min -clock [get_clocks "clk"] -add_delay 45.0 [all_outputs]

set_max_transition 9.0 [all_outputs]
set_input_transition -max 45.0 [all_inputs]
set_input_transition -min 9.0 [all_inputs]
