
#give the file_name, the amount of seconds between each measurement, and the duration in hours
proc register_cnt {file_name increments duration} {

    #register data in files containing 1 hour of data each
    for {set h 0} {$h < $duration} {incr h} {

        #initialization
        set output_file [open "$file_name$h" w+]
        set t_start [clock seconds]
        set t       [clock seconds]

        #actual data gathering
        for {set i 0} {$t < $t_start + 3600} {incr i} {
            set t [clock seconds]
            set E [get_property INPUT_VALUE [get_hw_probes -of_objects [lindex [get_hw_vios 1]] -filter {NAME =~ "*Cnt*"}]]
            puts $output_file "$t\t$E"
            after [expr $increments*1000]
        }

        #close file again
        close $output_file
    }
}
