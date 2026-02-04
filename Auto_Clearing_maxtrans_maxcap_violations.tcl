##### auto upsizeing of drivestrength #####
proc auto_upsize nn {
puts "net_name is $nn"
set db [get_object_name [get_cells -of_objects [get_pins [all_connected $nn -leaf] -filter "direction == out"]]]
set rn [get_attribute [get_cells $dn] ref_name ]
puts "Old ref name of $dn is $rn"
    regexp -nocase {(.+X)([0-9]+)([a-z]+)} $rn temp a b c
        if {$b == 0} {
            set b 1
        } else {
            set b [expr $b * 2]
        }
    
    set nrn $a$b$c
    size_cell $dn $nrn
    set new_ref [get_attribute  [get_cells $dn] ref_name ]
    puts "new ref name of $dn is $new_ref"


set fh_read [open ./outputs/reports/mtv_tcl.txt r]
set i 0
while {[gets $fh_read line] >= 0} {
    if {[llength $line] == 5} {
      set nn [lindex $line 0]
      set flag [catch {auto_upsize $nn}]
      puts $flag
          if {$flag == 0} {
          incr i 
          }
}

}
puts "number of buffers $i" 

##### auto upsizeing of VT varients #####

proc auto_upsize nn {
puts "net_name is $nn"
set db [get_object_name [get_cells -of_objects [get_pins [all_connected $nn -leaf] -filter "direction == out"]]]
set rn [get_attribute [get_cells $dn] ref_name ]
puts "Old ref name of $dn is $rn"
    regexp -nocase {(.+X)([0-9]+)([a-z]+)} $rn temp a b c
        if {$c == "_HVT"} {
            set c _RVT
        } elseif {$c == "_RVT"} {
            set c _LVT
        }
    
    set nrn $a$b$c
    size_cell $dn $nrn
    set new_ref [get_attribute  [get_cells $dn] ref_name ]
    puts "new ref name of $dn is $new_ref"


set fh_read [open ./outputs/reports/mtv_tcl.txt r]
set i 0
while {[gets $fh_read line] >= 0} {
    if {[llength $line] == 5} {
      set nn [lindex $line 0]
      set flag [catch {auto_upsize $nn}]
      puts $flag
          if {$flag == 0} {
          incr i 
          }
}

}
puts "number of buffers $i" 
