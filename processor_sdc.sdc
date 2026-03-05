# ####################################################################

#  Created by Genus(TM) Synthesis Solution 17.22-s017_1 on Tue May 20 10:54:47 IST 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000.0fF
set_units -time 1000.0ps

# Set the current design
current_design simple_8bit_cpu

create_clock -name "clk" -period 2.0 -waveform {0.0 1.0} [get_ports clk]
set_clock_transition 0.1 [get_clocks clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -network_latency_included -add_delay -rise -min 0.0 [get_ports clk]
set_input_delay -clock [get_clocks clk] -clock_fall -network_latency_included -add_delay -fall -min 0.0 [get_ports clk]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports clk]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {acc_port[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {acc_port[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {acc_port[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {acc_port[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {acc_port[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {acc_port[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {acc_port[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {acc_port[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {reg_port[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {reg_port[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {reg_port[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {reg_port[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {reg_port[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {reg_port[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {reg_port[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {reg_port[0]}]
set_wire_load_mode "enclosed"
set_dont_use [get_lib_cells slow/HOLDX1]
set_clock_uncertainty -setup 0.01 [get_ports clk]
set_clock_uncertainty -hold 0.01 [get_ports clk]
