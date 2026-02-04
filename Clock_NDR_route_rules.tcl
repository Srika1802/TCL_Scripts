#Clock top/trunk/leaf NDRs and their route rules

puts "Clock top/trunk/leaf NDRs and their route rules"
proc categorize_clock_route_types {} {
    set all_route_types [get_db route_types]
    set clock_top_ndrs {}
    set clock_trunk_ndrs {}
    set clock_leaf_ndrs {}
    set other_ndrs {}
    foreach route_type $all_route_types {
        set rt_name [get_db $route_type .name]
        
        if {[string match "clk_top" $rt_name]} {
            lappend clock_top_ndrs $rt_name
        } elseif {[string match "clk_trunk" $rt_name]} {
            lappend clock_trunk_ndrs $rt_name
        } elseif {[string match "clk_leaf" $rt_name]} {
            lappend clock_leaf_ndrs $rt_name
        } else {
            lappend other_ndrs $rt_name
        }
    }
    puts "\n=== CLOCK TOP NDRs ==="
    puts "======================"
    foreach ndr $clock_top_ndrs {
        puts "• $ndr"
    }
    
    puts "\n=== CLOCK TRUNK NDRs ==="
    puts "========================"
    foreach ndr $clock_trunk_ndrs {
        puts "• $ndr"
    }
    
    puts "\n=== CLOCK LEAF NDRs ==="
    puts "======================="
    foreach ndr $clock_leaf_ndrs {
        puts "• $ndr"
    }
    
    puts "\n OTHER NDRs "
    puts "======================="
    foreach ndr $other_ndrs {
        puts "• $ndr"
    }
    
    return [list $clock_top_ndrs $clock_trunk_ndrs $clock_leaf_ndrs $other_ndrs]
}
set categorized_ndrs [categorize_clock_route_types]
puts "                                              "




puts "part 2 "
set a [get_db route_rules .name]
puts $a

puts "                                             "
