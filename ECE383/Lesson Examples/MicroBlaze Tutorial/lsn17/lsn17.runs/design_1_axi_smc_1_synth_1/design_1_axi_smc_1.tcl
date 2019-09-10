# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param project.vivado.isBlockSynthRun true
set_msg_config -msgmgr_mode ooc_run
create_project -in_memory -part xc7a200tsbg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.cache/wt} [current_project]
set_property parent.project_path {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.xpr} [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_FIFO XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:nexys_video:part0:1.1 [current_project]
set_property ip_output_repo {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_ip -quiet {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/design_1_axi_smc_1.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_12/bd_6f02_s00a2s_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_21/bd_6f02_s01a2s_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_24/bd_6f02_m00s2a_0_ooc.xdc}}]
set_property used_in_synthesis false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_25/bd_6f02_m00arn_0/bd_6f02_m00arn_0_clocks.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_25/bd_6f02_m00arn_0/bd_6f02_m00arn_0_clocks.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_25/bd_6f02_m00arn_0_ooc.xdc}}]
set_property used_in_synthesis false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_26/bd_6f02_m00rn_0/bd_6f02_m00rn_0_clocks.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_26/bd_6f02_m00rn_0/bd_6f02_m00rn_0_clocks.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_26/bd_6f02_m00rn_0_ooc.xdc}}]
set_property used_in_synthesis false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_27/bd_6f02_m00awn_0/bd_6f02_m00awn_0_clocks.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_27/bd_6f02_m00awn_0/bd_6f02_m00awn_0_clocks.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_27/bd_6f02_m00awn_0_ooc.xdc}}]
set_property used_in_synthesis false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_28/bd_6f02_m00wn_0/bd_6f02_m00wn_0_clocks.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_28/bd_6f02_m00wn_0/bd_6f02_m00wn_0_clocks.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_28/bd_6f02_m00wn_0_ooc.xdc}}]
set_property used_in_synthesis false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_29/bd_6f02_m00bn_0/bd_6f02_m00bn_0_clocks.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_29/bd_6f02_m00bn_0/bd_6f02_m00bn_0_clocks.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_29/bd_6f02_m00bn_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_22/bd_6f02_sarn_1_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_23/bd_6f02_srn_1_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_13/bd_6f02_sarn_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_14/bd_6f02_srn_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_15/bd_6f02_sawn_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_16/bd_6f02_swn_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_17/bd_6f02_sbn_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_4/bd_6f02_arsw_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_5/bd_6f02_rsw_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_6/bd_6f02_awsw_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_7/bd_6f02_wsw_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_8/bd_6f02_bsw_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_1/bd_6f02_psr0_0_board.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_1/bd_6f02_psr0_0.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_2/bd_6f02_psr_aclk_0_board.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_2/bd_6f02_psr_aclk_0.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_3/bd_6f02_psr_aclk1_0_board.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_3/bd_6f02_psr_aclk1_0.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/ooc.xdc}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.runs/design_1_axi_smc_1_synth_1} -new_name design_1_axi_smc_1 -ip [get_ips design_1_axi_smc_1]]

if { $cached_ip eq {} } {

synth_design -top design_1_axi_smc_1 -part xc7a200tsbg484-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
# disable binary constraint mode for IPCache checkpoints
set_param constraints.enableBinaryConstraints false

catch {
 write_checkpoint -force -noxdef -rename_prefix design_1_axi_smc_1_ design_1_axi_smc_1.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_axi_smc_1_stub.v
 lappend ipCachedFiles design_1_axi_smc_1_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_axi_smc_1_stub.vhdl
 lappend ipCachedFiles design_1_axi_smc_1_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_axi_smc_1_sim_netlist.v
 lappend ipCachedFiles design_1_axi_smc_1_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_axi_smc_1_sim_netlist.vhdl
 lappend ipCachedFiles design_1_axi_smc_1_sim_netlist.vhdl

 config_ip_cache -add -dcp design_1_axi_smc_1.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips design_1_axi_smc_1]
}

rename_ref -prefix_all design_1_axi_smc_1_

# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef design_1_axi_smc_1.dcp
create_report "design_1_axi_smc_1_synth_1_synth_report_utilization_0" "report_utilization -file design_1_axi_smc_1_utilization_synth.rpt -pb design_1_axi_smc_1_utilization_synth.pb"

if { [catch {
  file copy -force {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.runs/design_1_axi_smc_1_synth_1/design_1_axi_smc_1.dcp} {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/design_1_axi_smc_1.dcp}
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/design_1_axi_smc_1_stub.v}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/design_1_axi_smc_1_stub.vhdl}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/design_1_axi_smc_1_sim_netlist.v}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/design_1_axi_smc_1_sim_netlist.vhdl}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.runs/design_1_axi_smc_1_synth_1/design_1_axi_smc_1.dcp} {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/design_1_axi_smc_1.dcp}
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.runs/design_1_axi_smc_1_synth_1/design_1_axi_smc_1_stub.v} {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/design_1_axi_smc_1_stub.v}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.runs/design_1_axi_smc_1_synth_1/design_1_axi_smc_1_stub.vhdl} {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/design_1_axi_smc_1_stub.vhdl}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.runs/design_1_axi_smc_1_synth_1/design_1_axi_smc_1_sim_netlist.v} {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/design_1_axi_smc_1_sim_netlist.v}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.runs/design_1_axi_smc_1_synth_1/design_1_axi_smc_1_sim_netlist.vhdl} {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/design_1_axi_smc_1_sim_netlist.vhdl}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.ip_user_files/ip/design_1_axi_smc_1}]} {
  catch { 
    file copy -force {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/design_1_axi_smc_1_stub.v}} {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.ip_user_files/ip/design_1_axi_smc_1}
  }
}

if {[file isdir {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.ip_user_files/ip/design_1_axi_smc_1}]} {
  catch { 
    file copy -force {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.srcs/sources_1/bd/design_1/ip/design_1_axi_smc_1/design_1_axi_smc_1_stub.vhdl}} {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Lesson Examples/lsn17/lsn17.ip_user_files/ip/design_1_axi_smc_1}
  }
}
