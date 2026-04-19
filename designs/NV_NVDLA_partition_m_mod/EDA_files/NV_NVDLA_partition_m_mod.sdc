#BSD 3-Clause License
#
#Copyright (c) 2024, ASU-VDA-Lab
#
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#
#1. Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
#2. Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
#3. Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

set_cmd_units -time ps -capacitance fF

set_clock_gating_check -rise -setup 0
set_clock_gating_check -fall -setup 0
create_clock [get_ports {nvdla_core_clk}] -name nvdla_core_clk -period 500 -waveform {0.000000 250.000}
set_clock_transition  -rise -min 0.1 [get_clocks {nvdla_core_clk}]
set_clock_transition  -rise -max 0.1 [get_clocks {nvdla_core_clk}]
set_clock_transition  -fall -min 0.1 [get_clocks {nvdla_core_clk}]
set_clock_transition  -fall -max 0.1 [get_clocks {nvdla_core_clk}]
set_wire_load_mode enclosed
set_false_path  -from [get_ports {tmc2slcg_disable_clock_gating test_mode nvdla_clk_ovr_on global_clk_ovr_on dla_reset_rstn direct_reset_}]
set_false_path -to [get_pin */RESETN]
set_false_path -to [get_pin */SETN]
set_ideal_network  [get_ports {global_clk_ovr_on}]
set_ideal_network  [get_ports {test_mode}]
set_ideal_network  [get_ports {direct_reset_}]
set_ideal_network  [get_ports {dla_reset_rstn}]
set_ideal_network  [get_ports {nvdla_core_clk}]
set_ideal_network  [get_ports {nvdla_clk_ovr_on}]
set_ideal_network  [get_ports {tmc2slcg_disable_clock_gating}]

set_max_fanout 128 [current_design]

set_load 0 [all_outputs]
set_input_transition  0.1 [all_inputs]
set_input_delay 0 [all_inputs]
