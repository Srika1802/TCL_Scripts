# Number of paths to consider
set num_paths 500

# ================================
# Part 1: Compute Average RC Delay
# ================================
# Get top num_paths timing paths with specific view
set top_paths [report_timing -view func_tttt_v065_t100_max_tttt_100c -nworst $num_paths -collection]

set total_rc_delay 0

foreach_in_collection path $top_paths {
    set pd [get_db $path .path_delay] 
    set total_rc_delay [expr {$total_rc_delay + $pd}]
}

set avg_rc_delay [expr {$total_rc_delay / $num_paths}]
puts "Average RC Delay of top $num_paths paths: $avg_rc_delay"

# ================================
# Part 2: Compute Average Gate Depth
# ================================
# Get top num_paths timing paths (generic)
set paths [report_timing -max_paths $num_paths -collection]

set total_depth 0
set count 0

foreach_in_collection p $paths {
    set logic_depth 0

    # Iterate all instances on this path
    foreach inst [get_db $p .nets.pins.inst] {
        if {$inst ne ""} {
            set is_seq [get_db $inst .is_sequential]
            if {!$is_seq} {
                incr logic_depth
            }
        }
    }

    # Accumulate total for average calculation
    set total_depth [expr {$total_depth + $logic_depth}]
    incr count

    # Optional: print each path's depth
    puts "Path $count logic depth = $logic_depth"
}

# Compute average
if {$count > 0} {
    set avg_depth [expr {$total_depth / $count}]
} else {
    set avg_depth 0
}

puts "=== Summary ==="
puts "Total paths considered: $count"
puts "Average gate depth: $avg_depth"
