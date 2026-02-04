if {0} {
set data [open_drc_error_data zroute.err ]

# Get violated net names for shorts
set net_name [get_attribute [get_drc_errors -error_data $data -filter "error_class == short" ] objects]


set i 0
set j 0
suppress_message SEL-004
foreach ff [get_object_name [get_flat_cells -filter "is_sequential == true && is_hard_macro == false"]] {
    puts "ff $i -- $ff"
    incr i
    set a [get_object_name [all_fanin  -to $ff/clk -flat]]
    set b [get_object_name [get_cells -of_objects [get_pins $a] ]]
    
    foreach c $b {
        set d [get_attribute [get_flat_cell $c] is_integrated_clock_gating_cell]
        if {$d == true} {
            incr j
            puts "there is clock gating cell"
            break
        }
    }
}
set k [expr $i - $j]
puts $k "number of cells with out clock gating are $k"
