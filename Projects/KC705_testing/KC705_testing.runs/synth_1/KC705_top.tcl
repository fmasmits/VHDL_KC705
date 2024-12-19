# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
namespace eval ::optrace {
  variable script "/home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Projects/KC705_testing/KC705_testing.runs/synth_1/KC705_top.tcl"
  variable category "vivado_synth"
}

# Try to connect to running dispatch if we haven't done so already.
# This code assumes that the Tcl interpreter is not using threads,
# since the ::dispatch::connected variable isn't mutex protected.
if {![info exists ::dispatch::connected]} {
  namespace eval ::dispatch {
    variable connected false
    if {[llength [array get env XILINX_CD_CONNECT_ID]] > 0} {
      set result "true"
      if {[catch {
        if {[lsearch -exact [package names] DispatchTcl] < 0} {
          set result [load librdi_cd_clienttcl[info sharedlibextension]] 
        }
        if {$result eq "false"} {
          puts "WARNING: Could not load dispatch client library"
        }
        set connect_id [ ::dispatch::init_client -mode EXISTING_SERVER ]
        if { $connect_id eq "" } {
          puts "WARNING: Could not initialize dispatch client"
        } else {
          puts "INFO: Dispatch client connection id - $connect_id"
          set connected true
        }
      } catch_res]} {
        puts "WARNING: failed to connect to dispatch server - $catch_res"
      }
    }
  }
}
if {$::dispatch::connected} {
  # Remove the dummy proc if it exists.
  if { [expr {[llength [info procs ::OPTRACE]] > 0}] } {
    rename ::OPTRACE ""
  }
  proc ::OPTRACE { task action {tags {} } } {
    ::vitis_log::op_trace "$task" $action -tags $tags -script $::optrace::script -category $::optrace::category
  }
  # dispatch is generic. We specifically want to attach logging.
  ::vitis_log::connect_client
} else {
  # Add dummy proc if it doesn't exist.
  if { [expr {[llength [info procs ::OPTRACE]] == 0}] } {
    proc ::OPTRACE {{arg1 \"\" } {arg2 \"\"} {arg3 \"\" } {arg4 \"\"} {arg5 \"\" } {arg6 \"\"}} {
        # Do nothing
    }
  }
}

OPTRACE "synth_1" START { ROLLUP_AUTO }
set_msg_config  -string {{.*The IP file '.*' has been moved from its original location, as a result the outputs for this IP will now be generated in '.*'. Alternatively a copy of the IP can be imported into the project using one of the 'import_ip' or 'import_files' commands..*}}  -suppress  -regexp
set_msg_config  -string {{.*File '.*.xci' referenced by design '.*' could not be found..*}}  -suppress  -regexp
OPTRACE "Creating in-memory project" START { }
create_project -in_memory -part xc7k325tffg900-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Projects/KC705_testing/KC705_testing.cache/wt [current_project]
set_property parent.project_path /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Projects/KC705_testing/KC705_testing.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part xilinx.com:kc705:part0:1.7 [current_project]
set_property ip_output_repo /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Projects/KC705_testing/KC705_testing.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
set_property generic {GLOBAL_DATE=32'h11122024 GLOBAL_TIME=32'h00122707 GLOBAL_VER=32'h00000000 GLOBAL_SHA=32'h0F889328 TOP_SHA=32'h0AB3D196 TOP_VER=32'h00000000 HOG_SHA=32'h0219F277 HOG_VER=32'h080F0004 CON_VER=32'h00000000 CON_SHA=32'h0AB3D196 XIL_DEFAULTLIB_VER=32'h00000000 XIL_DEFAULTLIB_SHA=32'h0AB3D196 IPS_VER=32'h00000000 IPS_SHA=32'h0AB3D196} [current_fileset]
set src_rc [catch { 
  puts "source /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/pre-synthesis.tcl"
  source /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/pre-synthesis.tcl
} _RESULT] 
if {$src_rc} { 
  send_msg_id runtcl-1 status "$_RESULT"
  send_msg_id runtcl-2 status "sourcing script /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/pre-synthesis.tcl failed"
  return -code error
}
OPTRACE "Creating in-memory project" END { }
OPTRACE "Adding files" START { }
read_vhdl -vhdl2008 -library xil_defaultlib /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/hdl/KC705_top.vhd
read_ip -quiet /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/trans_wiz/trans_wiz.xci
set_property used_in_implementation false [get_files -all /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/trans_wiz/trans_wiz.xdc]
set_property used_in_implementation false [get_files -all /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/trans_wiz/trans_wiz_ooc.xdc]

read_ip -quiet /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/ila_data_in/ila_data_in.xci
set_property used_in_synthesis false [get_files -all /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/ila_data_in/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/ila_data_in/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/ila_data_in/ila_v6_2/constraints/ila.xdc]
set_property used_in_implementation false [get_files -all /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/ila_data_in/ila_data_in_ooc.xdc]

read_ip -quiet /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/vio_RxTx/vio_RxTx.xci
set_property used_in_implementation false [get_files -all /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/vio_RxTx/vio_RxTx.xdc]
set_property used_in_implementation false [get_files -all /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/vio_RxTx/vio_RxTx_ooc.xdc]

read_ip -quiet /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/vio_tra_set/vio_tra_set.xci
set_property used_in_implementation false [get_files -all /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/vio_tra_set/vio_tra_set.xdc]
set_property used_in_implementation false [get_files -all /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/vio_tra_set/vio_tra_set_ooc.xdc]

OPTRACE "Adding files" END { }
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/constraints/KC705_physical.xdc
set_property used_in_implementation false [get_files /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/constraints/KC705_physical.xdc]

read_xdc /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/constraints/KC705_clocking.xdc
set_property used_in_implementation false [get_files /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/constraints/KC705_clocking.xdc]

set_param ips.enableIPCacheLiteLoad 1

read_checkpoint -auto_incremental -incremental /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Projects/KC705_testing/KC705_testing.srcs/utils_1/imports/synth_1/KC705_top.dcp
close [open __synthesis_is_running__ w]

OPTRACE "synth_design" START { }
synth_design -top KC705_top -part xc7k325tffg900-2
OPTRACE "synth_design" END { }
if { [get_msg_config -count -severity {CRITICAL WARNING}] > 0 } {
 send_msg_id runtcl-6 info "Synthesis results are not added to the cache due to CRITICAL_WARNING"
}


OPTRACE "write_checkpoint" START { CHECKPOINT }
# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef KC705_top.dcp
OPTRACE "write_checkpoint" END { }
OPTRACE "synth reports" START { REPORT }
generate_parallel_reports -reports { "report_utilization -file KC705_top_utilization_synth.rpt -pb KC705_top_utilization_synth.pb"  } 
OPTRACE "synth reports" END { }
set src_rc [catch { 
  puts "source /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/post-synthesis.tcl"
  source /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/post-synthesis.tcl
} _RESULT] 
if {$src_rc} { 
  send_msg_id runtcl-1 status "$_RESULT"
  send_msg_id runtcl-2 status "sourcing script /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/post-synthesis.tcl failed"
  return -code error
}
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
OPTRACE "synth_1" END { }
