# Average fanout in the design

puts "Average fanout in the design"
set a [get_db pins *]
set fanout_values [get_db $a .fanout]
set total_fanout 0
foreach fanout $fanout_values {
    set total_fanout [expr $total_fanout + $fanout]
}
set num_pins [llength $fanout_values]
set average_fanout [expr $total_fanout / double($num_pins)]
puts "Total pins: $num_pins"
puts "Total fanout: $total_fanout"
puts "Average fanout: $average_fanout"
puts "                                                         "


# Total pin cap
puts "Total pin cap" 
set pins [get_db pins *]
set cap_values [get_db $pins .capacitance_max]
set total_cap 0
foreach cap $cap_values {
    set total_cap [expr $total_cap + $cap]
}
puts "Total capacitance: $total_cap"
puts "                                             "
