# 
# Report generation script generated by Vivado
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
proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}


start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  create_project -in_memory -part xc7a200tsbg484-1
  set_property board_part digilentinc.com:nexys_video:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 2/code/lab2/lab2.cache/wt} [current_project]
  set_property parent.project_path {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 2/code/lab2/lab2.xpr} [current_project]
  set_property ip_repo_paths {{C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 3/code/ip_repo/lab2_1.0}} [current_project]
  set_property ip_output_repo {{C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 2/code/lab2/lab2.cache/ip}} [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  set_property XPM_LIBRARIES XPM_CDC [current_project]
  add_files -quiet {{C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 2/code/lab2/lab2.runs/synth_1/lab2.dcp}}
  read_ip -quiet {{C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 2/code/lab2/lab2.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci}}
  read_ip -quiet {{C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 2/code/lab2/lab2.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.xci}}
  read_xdc {{C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 2/code/lab2/lab2.srcs/constrs_1/imports/Lab 2/Lab2.xdc}}
  link_design -top lab2 -part xc7a200tsbg484-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force lab2_opt.dcp
  create_report "impl_1_opt_report_drc_0" "report_drc -file lab2_drc_opted.rpt -pb lab2_drc_opted.pb -rpx lab2_drc_opted.rpx"
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force lab2_placed.dcp
  create_report "impl_1_place_report_io_0" "report_io -file lab2_io_placed.rpt"
  create_report "impl_1_place_report_utilization_0" "report_utilization -file lab2_utilization_placed.rpt -pb lab2_utilization_placed.pb"
  create_report "impl_1_place_report_control_sets_0" "report_control_sets -file lab2_control_sets_placed.rpt"
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force lab2_routed.dcp
  create_report "impl_1_route_report_drc_0" "report_drc -file lab2_drc_routed.rpt -pb lab2_drc_routed.pb -rpx lab2_drc_routed.rpx"
  create_report "impl_1_route_report_methodology_0" "report_methodology -file lab2_methodology_drc_routed.rpt -pb lab2_methodology_drc_routed.pb -rpx lab2_methodology_drc_routed.rpx"
  create_report "impl_1_route_report_power_0" "report_power -file lab2_power_routed.rpt -pb lab2_power_summary_routed.pb -rpx lab2_power_routed.rpx"
  create_report "impl_1_route_report_route_status_0" "report_route_status -file lab2_route_status.rpt -pb lab2_route_status.pb"
  create_report "impl_1_route_report_timing_summary_0" "report_timing_summary -file lab2_timing_summary_routed.rpt -warn_on_violation  -rpx lab2_timing_summary_routed.rpx"
  create_report "impl_1_route_report_incremental_reuse_0" "report_incremental_reuse -file lab2_incremental_reuse_routed.rpt"
  create_report "impl_1_route_report_clock_utilization_0" "report_clock_utilization -file lab2_clock_utilization_routed.rpt"
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force lab2_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  set_property XPM_LIBRARIES XPM_CDC [current_project]
  catch { write_mem_info -force lab2.mmi }
  write_bitstream -force lab2.bit 
  catch {write_debug_probes -quiet -force lab2}
  catch {file copy -force lab2.ltx debug_nets.ltx}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

