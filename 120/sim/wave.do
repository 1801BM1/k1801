onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix octal -childformat {{{/tb_120/nADC[9]} -radix octal} {{/tb_120/nADC[8]} -radix octal} {{/tb_120/nADC[7]} -radix octal} {{/tb_120/nADC[6]} -radix octal} {{/tb_120/nADC[5]} -radix octal} {{/tb_120/nADC[4]} -radix octal} {{/tb_120/nADC[3]} -radix octal} {{/tb_120/nADC[2]} -radix octal} {{/tb_120/nADC[1]} -radix octal} {{/tb_120/nADC[0]} -radix octal}} -subitemconfig {{/tb_120/nADC[9]} {-radix octal} {/tb_120/nADC[8]} {-radix octal} {/tb_120/nADC[7]} {-radix octal} {/tb_120/nADC[6]} {-radix octal} {/tb_120/nADC[5]} {-radix octal} {/tb_120/nADC[4]} {-radix octal} {/tb_120/nADC[3]} {-radix octal} {/tb_120/nADC[2]} {-radix octal} {/tb_120/nADC[1]} {-radix octal} {/tb_120/nADC[0]} {-radix octal}} /tb_120/nADC
add wave -noupdate -radix octal /tb_120/ADC_out
add wave -noupdate -radix octal /tb_120/ADC_vec
add wave -noupdate -radix octal /tb_120/ADC_in
add wave -noupdate /tb_120/ADC_oe
add wave -noupdate /tb_120/nSYNCC
add wave -noupdate /tb_120/nDINC
add wave -noupdate /tb_120/nDOUTC
add wave -noupdate /tb_120/nINITC
add wave -noupdate /tb_120/nCSC
add wave -noupdate /tb_120/nARC
add wave -noupdate /tb_120/nRPLYC
add wave -noupdate /tb_120/nIAKIC
add wave -noupdate /tb_120/nIAKOC
add wave -noupdate /tb_120/nVIRQC
add wave -noupdate -radix octal /tb_120/nADP
add wave -noupdate -radix octal /tb_120/ADP_out
add wave -noupdate -radix octal /tb_120/ADP_vec
add wave -noupdate -radix octal /tb_120/ADP_in
add wave -noupdate /tb_120/ADP_oe
add wave -noupdate /tb_120/nSYNCP
add wave -noupdate /tb_120/nDINP
add wave -noupdate /tb_120/nDOUTP
add wave -noupdate /tb_120/nINITP
add wave -noupdate /tb_120/nCSP
add wave -noupdate /tb_120/nRPLYP
add wave -noupdate /tb_120/nIAKIP
add wave -noupdate /tb_120/nIAKOP
add wave -noupdate /tb_120/nVIRQP
add wave -noupdate /tb_120/A0
add wave -noupdate /tb_120/A1
add wave -noupdate /tb_120/nEP
add wave -noupdate /tb_120/CLK
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1121404 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {215800 ps} {2263800 ps}
