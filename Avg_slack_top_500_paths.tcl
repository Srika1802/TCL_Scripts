#Average slack of top 500 paths

puts "Average slack of top 500 paths"
set path [report_timing -view func_tttt_v065_t100_max_tttt_100c -max_paths 500 -collection]
set slack_values [get_db $path .slack]
set total_slack 0
set count 0
foreach slack $slack_values {
    set total_slack [expr $total_slack + $slack]
    incr count
}
set average_slack [expr $total_slack / $count]
puts "Average slack: $average_slack"
puts "Total paths: $count"
puts "                                        "
