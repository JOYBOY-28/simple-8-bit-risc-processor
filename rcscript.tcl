set_db / .init_lib_search_path {/home/install/FOUNDRY/digital/90nm/dig/lib}
#Read Lib RTL and SDC files
set_db / .library "slow.lib"
set_db / .init_hdl_search_path {/home/NIEECE/Desktop/simple_8bit_risc_processor}
read_hdl { Top.v IM.v CU.v register_file.v Program_counter.v ALU_accu.v}
set DESIGN simple_8bit_cpu
elaborate $DESIGN
check_design -unresolved 
read_sdc constraints_top.sdc

#Setting effort medium
set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium
syn_generic
syn_map
syn_opt

write_hdl > processor_netlist.v
write_sdc > processor_sdc.sdc

#PPA Reports
report_power > power.rpt
report_gates > gatecount.rpt
report_timing > timing.rpt
report_area > area.rpt
gui_show
