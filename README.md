# Find core area using formula and compare with actual core area
# core_area = total_cell_Area / utilization (0.7503)
# Here 0.7503 we get from report_utilization
# Assign all cells to a variable
set a [get_object_name [get_flat_cells]]
set ta 0
foreach_in_collection  b [get_flat_cells] {
    set ca [get_attribute [get_flat_cells $b] area]
    set ta [expr $ta + $ca]
}

puts "Total area of cells is : $ta"
set coa [expr $ta / 0.7503]
puts "Core area for utilization 0.7503 is : $coa"
