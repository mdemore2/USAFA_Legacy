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
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a200tsbg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.cache/wt} [current_project]
set_property parent.project_path {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.xpr} [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:nexys_video:part0:1.1 [current_project]
set_property ip_output_repo {c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/sources_1/imports/new/counter.vhdl}
  {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/sources_1/new/counterVert.vhd}
  {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/sources_1/imports/Lab 1/dvid.vhdl}
  {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/sources_1/new/scopeface.vhdl}
  {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/sources_1/imports/Lab 1/tdms.vhdl}
  {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/sources_1/new/vga.vhdl}
  {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/sources_1/imports/Lab 1/video.vhdl}
  {C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/sources_1/imports/Lab 1/lab1.vhdl}
}
read_ip -quiet {{C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/constrs_1/imports/Lab 1/Lab1.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/C19Mark.Demore/Documents/Demore_ECE383/Labs/Lab 1/code/lab1/lab1.srcs/constrs_1/imports/Lab 1/Lab1.xdc}}]


synth_design -top lab1 -part xc7a200tsbg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef lab1.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file lab1_utilization_synth.rpt -pb lab1_utilization_synth.pb"
