# Pitch and min-width of each layer m0-m14
puts "Pitch and min-width of each layer m0-m14"
set metal_layers {m0 m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13 m14}
puts " Metal Layer Properties "
puts "Layer\tMin_Width(um)\tPitch_X(um)"
foreach metal $metal_layers {
    set layer_obj [get_db layers $metal]
    if {$layer_obj ne ""} {
        set min_width [get_db $layer_obj .min_width]
        set pitch_x   [get_db $layer_obj .pitch_x]
        puts "$metal\t$min_width\t\t$pitch_x"
    } 
}

puts "                                        "


# Length of longest wire in the design
set max_len 0.0
set max_net ""
set a [get_db nets]
foreach net $a {
    set bbox [get_db $net .bbox]
    set net_name [get_db $net .name]   
    set xMin [lindex $bbox 0 0]
    set yMin [lindex $bbox 0 1] 
    set xMax [lindex $bbox 0 2]
    set yMax [lindex $bbox 0 3]
    set length [expr {abs($xMax - $xMin) + abs($yMax - $yMin)}]
    if {$length > $max_len} {
        set max_len $length
        set max_net $net_name
    }
}
puts "Longest net = $max_net"
puts "Approx length = $max_len microns"
puts "                                                           "
