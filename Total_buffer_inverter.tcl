# Total buffer area and total inverter area
# Buffer area

puts "Total buffer area and total inverter area"

set buf_insts [get_db insts -if {.is_buffer}]

set buf_area [get_db $buf_insts .area]  

set buf_total 0.0

foreach a $buf_area { 
set buf_total [expr {$buf_total + $a}] 
}

puts "The Total buffer area $buf_total"

#Inverter area 

set inv_insts [get_db insts -if {.is_inverter}]

set inv_area [get_db $inv_insts .area]  

set inv_total 0.0

foreach b $inv_area { 
set inv_total [expr {$inv_total + $b}] 
}

puts "The Total inverter area $inv_total"
puts "                                                        "
