##### Problem statement: Voltage area is not aligning with site row and site coloumn due to this the sie row and site coloumn is getting wasted #####
#### Script helps that will allow voltage area to align with site row and site coloumn ####

remove_voltage_area *
#step 1: Calculate area required to place all cells

set a 0
foreach_in_collection c [get_flat_cells -filter "power_domain == PD_RISC_CORE"] {
    set c_a [get_attribute [get_cells $c] area]
    set a [expr $a + $c_a]
}

puts $a

set ta [expr $a / 0.8]

# step 2: Find width and height
set mh [get_attribute [get_cells I_RISC_CORE/I_REG_FILE/REG_FILE_D_RAM] height ]

set h [expr (2 * $mh) + 15 + 10 + 10]

set w [expr $ta / $h]

# Find (llx lly ) (urx ury)
set llx 5
set lly 5

set urx [expr ((ceil($w / 0.152)) * 0.152) + 5]
set ury [expr ((ceil($h / 1.872)) * 1.872) + 5]

# Find New (llx lly ) (urx ury) by moving voltage area to right and top
set llx [expr $llx + 5.016]
set lly [expr $lly + 5.016]
set urx [expr $urx + 5.016]
set ury [expr $ury + 5.016]

set co_list "($llx $lly) ($urx $ury)"
create_voltage_area -power_domains PD_RISC_CORE -region $co_list -guard_band {{5.016 5.016}}
