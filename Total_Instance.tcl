# Total count of instances and Total count of instances with excluding the physical cells
puts "                                           "
puts "Total count of instances and Total count of instances with excluding the physical cells"
set insts [get_db insts]
set logic_insts [get_db insts -if { !.is_physical }]

set inst_count [llength $insts]
set logic_count [llength $logic_insts]

puts "Total count of instances $inst_count "
puts "Total count of logic instances $logic_count"
puts "                                               "
