onerror {resume}
quietly virtual signal -install /tb_034/vp_034_avic { (context /tb_034/vp_034_avic )&{D0 , D1 , D2 , D3 , D4 , D5 , D6 , D7 , D8 , D9 , D10 , D11 , D12 , D13 , D14 , D15 }} D
quietly virtual signal -install /tb_034/vp_034_avic { (context /tb_034/vp_034_avic )&{D15 , D14 , D13 , D12 , D11 , D10 , D9 , D8 , D7 , D6 , D5 , D4 , D3 , D2 , D1 , D0 }} D001
quietly WaveActivateNextPane {} 0
add wave -noupdate -group register -radix hexadecimal -childformat {{{/tb_034/lat_nAD[15]} -radix hexadecimal} {{/tb_034/lat_nAD[14]} -radix hexadecimal} {{/tb_034/lat_nAD[13]} -radix hexadecimal} {{/tb_034/lat_nAD[12]} -radix hexadecimal} {{/tb_034/lat_nAD[11]} -radix hexadecimal} {{/tb_034/lat_nAD[10]} -radix hexadecimal} {{/tb_034/lat_nAD[9]} -radix hexadecimal} {{/tb_034/lat_nAD[8]} -radix hexadecimal} {{/tb_034/lat_nAD[7]} -radix hexadecimal} {{/tb_034/lat_nAD[6]} -radix hexadecimal} {{/tb_034/lat_nAD[5]} -radix hexadecimal} {{/tb_034/lat_nAD[4]} -radix hexadecimal} {{/tb_034/lat_nAD[3]} -radix hexadecimal} {{/tb_034/lat_nAD[2]} -radix hexadecimal} {{/tb_034/lat_nAD[1]} -radix hexadecimal} {{/tb_034/lat_nAD[0]} -radix hexadecimal}} -subitemconfig {{/tb_034/lat_nAD[15]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[14]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[13]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[12]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[11]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[10]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[9]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[8]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[7]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[6]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[5]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[4]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[3]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[2]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[1]} {-height 15 -radix hexadecimal} {/tb_034/lat_nAD[0]} {-height 15 -radix hexadecimal}} /tb_034/lat_nAD
add wave -noupdate -group register -radix hexadecimal /tb_034/lat_nD
add wave -noupdate -group register /tb_034/lat_C
add wave -noupdate -group register /tb_034/lat_nDME
add wave -noupdate -group register /tb_034/vp_034_reg/DMEX0
add wave -noupdate -group register -group lat_AD7 /tb_034/vp_034_reg/cell_PINOU16/x1
add wave -noupdate -group register -group lat_AD7 /tb_034/vp_034_reg/cell_PINOU16/x2
add wave -noupdate -group register -group lat_AD7 /tb_034/vp_034_reg/cell_PINOU16/y1
add wave -noupdate -group register -group lat_AD15 /tb_034/vp_034_reg/cell_PINOU25/x1
add wave -noupdate -group register -group lat_AD15 /tb_034/vp_034_reg/cell_PINOU25/x2
add wave -noupdate -group register -group lat_AD15 /tb_034/vp_034_reg/cell_PINOU25/y1
add wave -noupdate -group pio -radix hexadecimal -childformat {{{/tb_034/pio_D[7]} -radix hexadecimal} {{/tb_034/pio_D[6]} -radix hexadecimal} {{/tb_034/pio_D[5]} -radix hexadecimal} {{/tb_034/pio_D[4]} -radix hexadecimal} {{/tb_034/pio_D[3]} -radix hexadecimal} {{/tb_034/pio_D[2]} -radix hexadecimal} {{/tb_034/pio_D[1]} -radix hexadecimal} {{/tb_034/pio_D[0]} -radix hexadecimal}} -subitemconfig {{/tb_034/pio_D[7]} {-height 15 -radix hexadecimal} {/tb_034/pio_D[6]} {-height 15 -radix hexadecimal} {/tb_034/pio_D[5]} {-height 15 -radix hexadecimal} {/tb_034/pio_D[4]} {-height 15 -radix hexadecimal} {/tb_034/pio_D[3]} {-height 15 -radix hexadecimal} {/tb_034/pio_D[2]} {-height 15 -radix hexadecimal} {/tb_034/pio_D[1]} {-height 15 -radix hexadecimal} {/tb_034/pio_D[0]} {-height 15 -radix hexadecimal}} /tb_034/pio_D
add wave -noupdate -group pio -radix hexadecimal -childformat {{{/tb_034/pio_nC[7]} -radix hexadecimal} {{/tb_034/pio_nC[6]} -radix hexadecimal} {{/tb_034/pio_nC[5]} -radix hexadecimal} {{/tb_034/pio_nC[4]} -radix hexadecimal} {{/tb_034/pio_nC[3]} -radix hexadecimal} {{/tb_034/pio_nC[2]} -radix hexadecimal} {{/tb_034/pio_nC[1]} -radix hexadecimal} {{/tb_034/pio_nC[0]} -radix hexadecimal}} -subitemconfig {{/tb_034/pio_nC[7]} {-height 15 -radix hexadecimal} {/tb_034/pio_nC[6]} {-height 15 -radix hexadecimal} {/tb_034/pio_nC[5]} {-height 15 -radix hexadecimal} {/tb_034/pio_nC[4]} {-height 15 -radix hexadecimal} {/tb_034/pio_nC[3]} {-height 15 -radix hexadecimal} {/tb_034/pio_nC[2]} {-height 15 -radix hexadecimal} {/tb_034/pio_nC[1]} {-height 15 -radix hexadecimal} {/tb_034/pio_nC[0]} {-height 15 -radix hexadecimal}} /tb_034/pio_nC
add wave -noupdate -group pio /tb_034/pio_nCOM
add wave -noupdate -group pio -radix hexadecimal /tb_034/pio_A
add wave -noupdate -group pio -radix hexadecimal /tb_034/pio_B
add wave -noupdate -group pio /tb_034/pio_nR
add wave -noupdate -group pio /tb_034/pio_nST
add wave -noupdate -group pio /tb_034/pio_nCA
add wave -noupdate -group pio /tb_034/pio_nCB
add wave -noupdate -group pio /tb_034/pio_nCD
add wave -noupdate -group avic -label D -radix octal -childformat {{{/tb_034/vp_034_avic/D001[15]} -radix octal} {{/tb_034/vp_034_avic/D001[14]} -radix octal} {{/tb_034/vp_034_avic/D001[13]} -radix octal} {{/tb_034/vp_034_avic/D001[12]} -radix octal} {{/tb_034/vp_034_avic/D001[11]} -radix octal} {{/tb_034/vp_034_avic/D001[10]} -radix octal} {{/tb_034/vp_034_avic/D001[9]} -radix octal} {{/tb_034/vp_034_avic/D001[8]} -radix octal} {{/tb_034/vp_034_avic/D001[7]} -radix octal} {{/tb_034/vp_034_avic/D001[6]} -radix octal} {{/tb_034/vp_034_avic/D001[5]} -radix octal} {{/tb_034/vp_034_avic/D001[4]} -radix octal} {{/tb_034/vp_034_avic/D001[3]} -radix octal} {{/tb_034/vp_034_avic/D001[2]} -radix octal} {{/tb_034/vp_034_avic/D001[1]} -radix octal} {{/tb_034/vp_034_avic/D001[0]} -radix octal}} -subitemconfig {/tb_034/vp_034_avic/D15 {-radix octal} /tb_034/vp_034_avic/D14 {-radix octal} /tb_034/vp_034_avic/D13 {-radix octal} /tb_034/vp_034_avic/D12 {-radix octal} /tb_034/vp_034_avic/D11 {-radix octal} /tb_034/vp_034_avic/D10 {-radix octal} /tb_034/vp_034_avic/D9 {-radix octal} /tb_034/vp_034_avic/D8 {-radix octal} /tb_034/vp_034_avic/D7 {-radix octal} /tb_034/vp_034_avic/D6 {-radix octal} /tb_034/vp_034_avic/D5 {-radix octal} /tb_034/vp_034_avic/D4 {-radix octal} /tb_034/vp_034_avic/D3 {-radix octal} /tb_034/vp_034_avic/D2 {-radix octal} /tb_034/vp_034_avic/D1 {-radix octal} /tb_034/vp_034_avic/D0 {-radix octal}} /tb_034/vp_034_avic/D001
add wave -noupdate -group avic -radix octal /tb_034/nAD
add wave -noupdate -group avic /tb_034/nSB
add wave -noupdate -group avic /tb_034/nVIRQ
add wave -noupdate -group avic -radix octal -childformat {{{/tb_034/av_nAD[12]} -radix octal} {{/tb_034/av_nAD[11]} -radix octal} {{/tb_034/av_nAD[10]} -radix octal} {{/tb_034/av_nAD[9]} -radix octal} {{/tb_034/av_nAD[8]} -radix octal} {{/tb_034/av_nAD[7]} -radix octal} {{/tb_034/av_nAD[6]} -radix octal} {{/tb_034/av_nAD[5]} -radix octal} {{/tb_034/av_nAD[4]} -radix octal} {{/tb_034/av_nAD[3]} -radix octal} {{/tb_034/av_nAD[2]} -radix octal}} -subitemconfig {{/tb_034/av_nAD[12]} {-height 15 -radix octal} {/tb_034/av_nAD[11]} {-height 15 -radix octal} {/tb_034/av_nAD[10]} {-height 15 -radix octal} {/tb_034/av_nAD[9]} {-height 15 -radix octal} {/tb_034/av_nAD[8]} {-height 15 -radix octal} {/tb_034/av_nAD[7]} {-height 15 -radix octal} {/tb_034/av_nAD[6]} {-height 15 -radix octal} {/tb_034/av_nAD[5]} {-height 15 -radix octal} {/tb_034/av_nAD[4]} {-height 15 -radix octal} {/tb_034/av_nAD[3]} {-height 15 -radix octal} {/tb_034/av_nAD[2]} {-height 15 -radix octal}} /tb_034/av_nAD
add wave -noupdate -group avic /tb_034/av_nBS
add wave -noupdate -group avic /tb_034/av_NC
add wave -noupdate -group avic -radix octal /tb_034/av_A
add wave -noupdate -group avic /tb_034/av_V
add wave -noupdate -group avic /tb_034/nIAKI
add wave -noupdate -group avic /tb_034/nSYNC
add wave -noupdate -group avic /tb_034/nDIN
add wave -noupdate -group avic /tb_034/nVIRI
add wave -noupdate -group avic /tb_034/nRPLY
add wave -noupdate -group avic /tb_034/vp_034_avic/MATCH
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1026089 ps} 0}
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
WaveRestoreZoom {0 ps} {2680970 ps}
