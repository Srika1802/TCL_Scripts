set a [get_attribute [get_site_rows unit_row_0] site_width]
set kw [expr $a * 4]
change_selection [get_cells [get_selection ] -filter "number_of_pins > 5"] {
    create_keepout_margin -outer "$kw 0 $kw 0" [get_selection ]
    legalize_placement -incremental
}
