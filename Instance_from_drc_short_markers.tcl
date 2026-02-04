#get instance(s) from all drc short markers

	proc wrap_text {text width} {
    set result {}
    set line ""
    foreach word [split $text ""] {
        append line $word
        if {[string length $line] >= $width} {
            lappend result $line
            set line ""
        }
    }
    if {$line ne ""} {
        lappend result $line
    }
    return $result
}


set allMarkers [get_db markers]
set shortMarkers {}
foreach m $allMarkers {
    if {[get_db $m .subtype] eq "Metal_Short"} {
        lappend shortMarkers $m
    }
}
set layer_priority {m1 m2 m3 m4 m5 m6 m7 m8 m9 m10}
array set layerOrder {}
set idx 0
foreach l $layer_priority {
    set layerOrder($l) $idx
    incr idx
}

# Column widths (fixed)
set netColWidth 40
set instColWidth 50

set markerInfo {}
foreach marker $shortMarkers {
    set layer [get_db $marker .layer.name]
    set nets [get_db $marker .objects]

    set net_list {}
    set inst_list {}
    foreach net $nets {
        lappend net_list $net
        foreach inst [get_db $net .pins.inst] {
            lappend inst_list $inst
        }
    }

    lappend markerInfo [list $layerOrder($layer) $marker $layer $net_list $inst_list]
}


set sortedMarkers [lsort -integer -index 0 $markerInfo]


set border "+----------------------+--------+------------------------------------------+----------------------------------------------------+"
puts $border
puts [format "| %-20s | %-6s | %-40s | %-50s |" "Marker" "Layer" "Nets" "Instances"]
puts $border
foreach row $sortedMarkers {
    lassign $row order marker layer nets insts

    # Wrap nets and insts
    set wrapped_nets {}
    foreach n $nets {
        foreach wn [wrap_text $n $netColWidth] {
            lappend wrapped_nets $wn
        }
    }

    set wrapped_insts {}
    foreach i $insts {
        foreach wi [wrap_text $i $instColWidth] {
            lappend wrapped_insts $wi
        }
    }

    set maxlen [expr { [llength $wrapped_nets] > [llength $wrapped_insts] ? [llength $wrapped_nets] : [llength $wrapped_insts] }]

    for {set i 0} {$i < $maxlen} {incr i} {
        set net_str ""
        set inst_str ""
        if {$i < [llength $wrapped_nets]} {
            set net_str [lindex $wrapped_nets $i]
        }
        if {$i < [llength $wrapped_insts]} {
            set inst_str [lindex $wrapped_insts $i]
        }

        if {$i == 0} {
            puts [format "| %-20s | %-6s | %-40s | %-50s |" $marker $layer $net_str $inst_str]
        } else {
            puts [format "| %-20s | %-6s | %-40s | %-50s |" "" "" $net_str $inst_str]
        }
    }
    puts $border
}
