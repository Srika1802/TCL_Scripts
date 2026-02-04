proc auto_insert_buffer nn {
    puts "net name is $nn"
    set pn [get_object_name  [get_pins [all_connected $nn -leaf] -filter "direction == out"]]
    puts "driver pin name is $pn"
    set bn [add_buffer $dpn NBUFFX8_HVT]
    return $bn
}


set fh_read [open ./outputs/reports/mtv_tcl.txt r]
set i 0
while {[gets $fh_read line] >= 0} {
    if {[llength $line ] == 5} {
        set nn [lindex $line 0]
        set flag [catch {lappend all_buffers [auto_insert_buffer $nn]}]
        puts $flag
        if {$flag == 0} {
            incr i
        }
    }
}

puts "all buffers"
legalize_placement -cells $all_buffers 
puts "number of buffers inserted $i"
