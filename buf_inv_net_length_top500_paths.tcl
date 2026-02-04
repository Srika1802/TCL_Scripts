set paths [report_timing -view func_tttt_v065_t100_max_tttt_100c \
                         -max_paths 1 -collection]

set path_index 1
foreach_in_collection path $paths {

    puts "================ PATH$path_index ================"
    foreach n [get_db $path .nets.pins.inst] {
        set master   [get_db $n .base_cell.name ]
        set cell_type ""
        if {[regexp -nocase {^...inv}  $master]} {
            set cell_type "INV"
        } elseif {[regexp -nocase {^...cinv} $master]} {
            set cell_type "INV"
        } elseif {[regexp -nocase {^...bf}   $master]} {
            set cell_type "BUF"
        } elseif {[regexp -nocase {^...cbf}  $master]} {
            set cell_type "BUF"
        }
        if {$cell_type ne ""} {
            puts "instname   : $n"
            puts "base_name  : $master"
            puts "cell_type  : $cell_type"

            # initialize sums
            set total_in_len  0.0
            set total_out_len 0.0
            set in_net_name ""
            set out_net_name ""

            foreach pin [get_db $n .pins] {
                set dire [get_db $pin .direction]
                set nete [get_db $pin .net_name]
                if {$dire eq "in"} {
                    if {$nete ne ""} {
                        set len_list [get_db [get_db nets $nete] .wires.length]
                        foreach l $len_list { set total_in_len [expr {$total_in_len + $l}] }
                    }
                    set in_net_name $nete
                } elseif {$dire eq "out"} {
                    if {$nete ne ""} {
                        set len_list [get_db [get_db nets $nete] .wires.length]
                        foreach l $len_list { set total_out_len [expr {$total_out_len + $l}] }
                    }
                    set out_net_name $nete
                }
            }

            # print once per inst
            if {$in_net_name ne ""} {
                puts "direction1 : in"
                puts "in_net_name  : $in_net_name"
                puts "in_length    : $total_in_len"
            }
            if {$out_net_name ne ""} {
                puts "direction1 : out"
                puts "out_net_name : $out_net_name"
                puts "out_length   : $total_out_len"
            }
            puts ""
        }
    }
    puts ""
    incr path_index
}
