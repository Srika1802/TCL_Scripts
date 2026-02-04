# List of cells that are set as dont use

puts "List of cells that are set as dont use"
 
set dont_use_cells [get_db [get_db base_cells *] .dont_use true ]

puts "Total dont_use_cells = [llength $dont_use_cells ]"

puts "List of dont_use cells"
puts "                                 "


# Total port count per layer m0 -m14                
puts "Total port count per layer m0 -m14"
set port_layers [get_db ports .layer.name]
array set layer_count {
    M0 0 M1 0 M2 0 M3 0 M4 0 M5 0 M6 0 M7 0 M8 0 M9 0 M10 0 M11 0 M12 0 M13 0 M14 0
}

set total_ports 0
foreach lyr $port_layers {
    set key [string toupper $lyr]
    if {[info exists layer_count($key)]} {
        incr layer_count($key)
        incr total_ports
    } else {
    }
}
puts "Port count per layer M0-M14"
foreach lyr [lsort [array names layer_count]] {
    puts "$lyr : $layer_count($lyr)"
}
puts "Total Number of Ports "
puts $total_ports
puts "                                                            "
