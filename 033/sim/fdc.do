onerror {resume}
quietly virtual signal -install /tb_fdc/vp_fdc { (context /tb_fdc/vp_fdc )&{AD7 , AD6 , AD5 , AD4 , AD3 , AD2 , AD1 , AD0 }} AD
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix octal -childformat {{{/tb_fdc/nAD[15]} -radix octal} {{/tb_fdc/nAD[14]} -radix octal} {{/tb_fdc/nAD[13]} -radix octal} {{/tb_fdc/nAD[12]} -radix octal} {{/tb_fdc/nAD[11]} -radix octal} {{/tb_fdc/nAD[10]} -radix octal} {{/tb_fdc/nAD[9]} -radix octal} {{/tb_fdc/nAD[8]} -radix octal} {{/tb_fdc/nAD[7]} -radix octal} {{/tb_fdc/nAD[6]} -radix octal} {{/tb_fdc/nAD[5]} -radix octal} {{/tb_fdc/nAD[4]} -radix octal} {{/tb_fdc/nAD[3]} -radix octal} {{/tb_fdc/nAD[2]} -radix octal} {{/tb_fdc/nAD[1]} -radix octal} {{/tb_fdc/nAD[0]} -radix octal}} -subitemconfig {{/tb_fdc/nAD[15]} {-height 15 -radix octal} {/tb_fdc/nAD[14]} {-height 15 -radix octal} {/tb_fdc/nAD[13]} {-height 15 -radix octal} {/tb_fdc/nAD[12]} {-height 15 -radix octal} {/tb_fdc/nAD[11]} {-height 15 -radix octal} {/tb_fdc/nAD[10]} {-height 15 -radix octal} {/tb_fdc/nAD[9]} {-height 15 -radix octal} {/tb_fdc/nAD[8]} {-height 15 -radix octal} {/tb_fdc/nAD[7]} {-height 15 -radix octal} {/tb_fdc/nAD[6]} {-height 15 -radix octal} {/tb_fdc/nAD[5]} {-height 15 -radix octal} {/tb_fdc/nAD[4]} {-height 15 -radix octal} {/tb_fdc/nAD[3]} {-height 15 -radix octal} {/tb_fdc/nAD[2]} {-height 15 -radix octal} {/tb_fdc/nAD[1]} {-height 15 -radix octal} {/tb_fdc/nAD[0]} {-height 15 -radix octal}} /tb_fdc/nAD
add wave -noupdate /tb_fdc/nSYNC
add wave -noupdate /tb_fdc/nDOUT
add wave -noupdate /tb_fdc/nDIN
add wave -noupdate /tb_fdc/nRPLY
add wave -noupdate /tb_fdc/nIAKI
add wave -noupdate -radix octal /tb_fdc/AD_in
add wave -noupdate -radix octal /tb_fdc/AD_out
add wave -noupdate /tb_fdc/AD_oe
add wave -noupdate /tb_fdc/nBS
add wave -noupdate /tb_fdc/nWTBT
add wave -noupdate /tb_fdc/nINIT
add wave -noupdate /tb_fdc/nVIRQ
add wave -noupdate /tb_fdc/RDO
add wave -noupdate /tb_fdc/nIAKO
add wave -noupdate /tb_fdc/nSHIFT
add wave -noupdate /tb_fdc/nOUT
add wave -noupdate /tb_fdc/nDI
add wave -noupdate /tb_fdc/nDO
add wave -noupdate /tb_fdc/nRUN
add wave -noupdate /tb_fdc/nSET
add wave -noupdate /tb_fdc/nERR
add wave -noupdate /tb_fdc/nDONE
add wave -noupdate /tb_fdc/nTR
add wave -noupdate /tb_fdc/vp_fdc/nSEL
add wave -noupdate -group vp_fdc /tb_fdc/vp_fdc/nM15
add wave -noupdate -group vp_fdc /tb_fdc/vp_fdc/F170
add wave -noupdate -group vp_fdc /tb_fdc/vp_fdc/F174
add wave -noupdate -group vp_fdc /tb_fdc/vp_fdc/F200
add wave -noupdate -group vp_fdc /tb_fdc/vp_fdc/FDC
add wave -noupdate -group vp_fdc -radix octal -childformat {{{/tb_fdc/vp_fdc/AD[7]} -radix octal} {{/tb_fdc/vp_fdc/AD[6]} -radix octal} {{/tb_fdc/vp_fdc/AD[5]} -radix octal} {{/tb_fdc/vp_fdc/AD[4]} -radix octal} {{/tb_fdc/vp_fdc/AD[3]} -radix octal} {{/tb_fdc/vp_fdc/AD[2]} -radix octal} {{/tb_fdc/vp_fdc/AD[1]} -radix octal} {{/tb_fdc/vp_fdc/AD[0]} -radix octal}} -subitemconfig {/tb_fdc/vp_fdc/AD7 {-radix octal} /tb_fdc/vp_fdc/AD6 {-radix octal} /tb_fdc/vp_fdc/AD5 {-radix octal} /tb_fdc/vp_fdc/AD4 {-radix octal} /tb_fdc/vp_fdc/AD3 {-radix octal} /tb_fdc/vp_fdc/AD2 {-radix octal} /tb_fdc/vp_fdc/AD1 {-radix octal} /tb_fdc/vp_fdc/AD0 {-radix octal}} /tb_fdc/vp_fdc/AD
add wave -noupdate -group vp_fdc /tb_fdc/vp_fdc/FRUN
add wave -noupdate -group vp_fdc /tb_fdc/vp_fdc/FSTR
add wave -noupdate -group vp_fdc /tb_fdc/vp_fdc/FSEL0
add wave -noupdate -group vp_fdc /tb_fdc/vp_fdc/FSEL2
add wave -noupdate -group vp_fdc /tb_fdc/vp_fdc/nSRUN0
add wave -noupdate -group vp_fdc /tb_fdc/vp_fdc/nSRUN2
add wave -noupdate -group vp_fdc /tb_fdc/vp_fdc/nDONE
add wave -noupdate -group vp_fdc -radix octal /tb_fdc/vp_rdx/cmd
add wave -noupdate -group vp_fdc -radix octal /tb_fdc/vp_rdx/dat
add wave -noupdate -group vp_fdc -radix decimal /tb_fdc/vp_rdx/cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16465873 ps} 0}
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
WaveRestoreZoom {0 ps} {50217984 ps}
