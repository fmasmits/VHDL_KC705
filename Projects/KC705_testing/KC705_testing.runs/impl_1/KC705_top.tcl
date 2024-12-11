namespace eval ::optrace {
  variable script "/home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Projects/KC705_testing/KC705_testing.runs/impl_1/KC705_top.tcl"
  variable category "vivado_impl"
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
    } elseif { [info exist ::env(HOST)] } {
      set host $::env(HOST)
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
OPTRACE "impl_1" END { }
}

set_msg_config  -string {{.*The IP file '.*' has been moved from its original location, as a result the outputs for this IP will now be generated in '.*'. Alternatively a copy of the IP can be imported into the project using one of the 'import_ip' or 'import_files' commands..*}}  -suppress  -regexp
set_msg_config  -string {{.*File '.*.xci' referenced by design '.*' could not be found..*}}  -suppress  -regexp

OPTRACE "impl_1" START { ROLLUP_1 }
OPTRACE "Phase: Write Bitstream" START { ROLLUP_AUTO }
OPTRACE "write_bitstream setup" START { }
start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  set_param chipscope.maxJobs 3
  set_param runs.launchOptions { -jobs 1  }
  open_checkpoint KC705_top_routed.dcp
  set_property webtalk.parent_dir /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Projects/KC705_testing/KC705_testing.cache/wt [current_project]
OPTRACE "Write Bitstream: pre hook" START { }
  set src_rc [catch { 
    puts "source /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/pre-bitstream.tcl"
    source /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/pre-bitstream.tcl
  } _RESULT] 
  if {$src_rc} { 
    set tool_flow [get_property -quiet TOOL_FLOW [current_project -quiet]]
    if { $tool_flow eq {SDx} } { 
      send_gid_msg -id 2 -ssname VPL_TCL -severity ERROR $_RESULT
      send_gid_msg -id 3 -ssname VPL_TCL -severity ERROR "sourcing script /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/pre-bitstream.tcl failed"
    } else {
      send_msg_id runtcl-1 status "$_RESULT"
      send_msg_id runtcl-2 status "sourcing script /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/pre-bitstream.tcl failed"
    }
    return -code error
  }
OPTRACE "Write Bitstream: pre hook" END { }
set_property TOP KC705_top [current_fileset]
OPTRACE "read constraints: write_bitstream" START { }
OPTRACE "read constraints: write_bitstream" END { }
  set_property XPM_LIBRARIES XPM_CDC [current_project]
  catch { write_mem_info -force -no_partial_mmi KC705_top.mmi }
OPTRACE "write_bitstream setup" END { }
OPTRACE "write_bitstream" START { }
  write_bitstream -force KC705_top.bit 
OPTRACE "write_bitstream" END { }
OPTRACE "write_bitstream misc" START { }
OPTRACE "read constraints: write_bitstream_post" START { }
OPTRACE "read constraints: write_bitstream_post" END { }
  catch {write_debug_probes -quiet -force KC705_top}
  catch {file copy -force KC705_top.ltx debug_nets.ltx}
OPTRACE "Write Bitstream: post hook" START { }
  set src_rc [catch { 
    puts "source /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/post-bitstream.tcl"
    source /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/post-bitstream.tcl
  } _RESULT] 
  if {$src_rc} { 
    set tool_flow [get_property -quiet TOOL_FLOW [current_project -quiet]]
    if { $tool_flow eq {SDx} } { 
      send_gid_msg -id 2 -ssname VPL_TCL -severity ERROR $_RESULT
      send_gid_msg -id 3 -ssname VPL_TCL -severity ERROR "sourcing script /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/post-bitstream.tcl failed"
    } else {
      send_msg_id runtcl-1 status "$_RESULT"
      send_msg_id runtcl-2 status "sourcing script /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/Hog/Tcl/integrated/post-bitstream.tcl failed"
    }
    return -code error
  }
OPTRACE "Write Bitstream: post hook" END { }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

OPTRACE "write_bitstream misc" END { }
OPTRACE "Phase: Write Bitstream" END { }
OPTRACE "impl_1" END { }
