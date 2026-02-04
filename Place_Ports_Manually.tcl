#### input ports placing Program #######
# Obtain {llx lly} for placement blockage
set pbbox [get_attribute [get_placement_blockages pb_0] bbox]
set llx [lindex $pbbox 0 0]
set lly [lindex $pbbox 0 1]
# Find pitch of M5 layer 
# Because ports are in M5 layer
set pi [get_attribute [get_layers M5] pitch]
set off [expr 3* $pi] 
# 1 - llx, (lly + 0 * off)
# 2 - llx, (lly + 1 * off)
# 3 - llx, (lly + 2 * off)
# 4 - llx, (lly + 3 * off)

set i 0
foreach_in_collection po [all_inputs] {
    set llyn [expr $lly + ($i * $off)]
    set lo "$llx $llyn"
    set_individual_pin_constraints -location $lo -allowed_layers M5 -ports $po
    incr i
}

report_individual_pin_constraints -ports [all_inputs]
place_pins -ports [all_inputs]
