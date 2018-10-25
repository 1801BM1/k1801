onerror {resume}
quietly virtual signal -install /tb_013/vp_013 { (concat_range (0 to 5) )( (context /tb_013/vp_013 )&{cell_O24/q3 , cell_O22/q3 , cell_N18/q3 , cell_D20/q3 , cell_D18/q3 , cell_F20/q3 } )} RC
quietly virtual signal -install /tb_013/vp_013 { (concat_range (0 to 7) )( (context /tb_013/vp_013 )&{cell_F6/q3 , cell_I6/q3 , cell_F4/q3 , cell_M4/q3 , cell_M6/q3 , cell_M8/q3 , cell_O10/q3 , cell_M10/q3 } )} RA
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix octal /tb_013/nAD
add wave -noupdate /tb_013/CLK
add wave -noupdate /tb_013/nDIN
add wave -noupdate /tb_013/nDOUT
add wave -noupdate /tb_013/nSYNC
add wave -noupdate /tb_013/nWTBT
add wave -noupdate /tb_013/nSEL
add wave -noupdate /tb_013/MSEL
add wave -noupdate /tb_013/RC
add wave -noupdate /tb_013/nRPLY
add wave -noupdate -radix octal -childformat {{{/tb_013/A[6]} -radix octal} {{/tb_013/A[5]} -radix octal} {{/tb_013/A[4]} -radix octal} {{/tb_013/A[3]} -radix octal} {{/tb_013/A[2]} -radix octal} {{/tb_013/A[1]} -radix octal} {{/tb_013/A[0]} -radix octal}} -subitemconfig {{/tb_013/A[6]} {-height 15 -radix octal} {/tb_013/A[5]} {-height 15 -radix octal} {/tb_013/A[4]} {-height 15 -radix octal} {/tb_013/A[3]} {-height 15 -radix octal} {/tb_013/A[2]} {-height 15 -radix octal} {/tb_013/A[1]} {-height 15 -radix octal} {/tb_013/A[0]} {-height 15 -radix octal}} /tb_013/A
add wave -noupdate {/tb_013/nRAS[1]}
add wave -noupdate {/tb_013/nRAS[0]}
add wave -noupdate {/tb_013/nCAS[1]}
add wave -noupdate {/tb_013/nCAS[0]}
add wave -noupdate /tb_013/nWE
add wave -noupdate /tb_013/nDME
add wave -noupdate /tb_013/RSTB
add wave -noupdate /tb_013/LOCK
add wave -noupdate -expand -group RESET -label nRESET /tb_013/vp_013/cell_M29/y2
add wave -noupdate -expand -group RESET -label RESET /tb_013/vp_013/cell_M29/y3
add wave -noupdate -expand -group RESET -label nTEST /tb_013/vp_013/cell_N34/y2
add wave -noupdate -expand -group RESET -label TEST /tb_013/vp_013/cell_N34/y3
add wave -noupdate -group PHx -label nPH0 /tb_013/vp_013/cell_I29/q3
add wave -noupdate -group PHx -label PH0 /tb_013/vp_013/cell_I29/q4
add wave -noupdate -group PHx -label PH1 /tb_013/vp_013/cell_I28/q3
add wave -noupdate -group PHx -label PH2 /tb_013/vp_013/cell_H29/q3
add wave -noupdate -group PHx -label nPH2 /tb_013/vp_013/cell_H29/q4
add wave -noupdate -group PHx -label PH3 /tb_013/vp_013/cell_H28/q3
add wave -noupdate -group PHx -label nPH3 /tb_013/vp_013/cell_H28/q4
add wave -noupdate -group PHx -label PH4 /tb_013/vp_013/cell_G29/q3
add wave -noupdate -group PHx -label nPH4 /tb_013/vp_013/cell_G29/q4
add wave -noupdate -group PHx -label PH5 /tb_013/vp_013/cell_G28/q3
add wave -noupdate -group PHx -label nPH5 /tb_013/vp_013/cell_G28/q4
add wave -noupdate -group PHx -label PH6 /tb_013/vp_013/cell_G16/q3
add wave -noupdate -group PHx -label nPH6 /tb_013/vp_013/cell_G16/q4
add wave -noupdate -radix unsigned -childformat {{{/tb_013/vp_013/RC[0]} -radix unsigned} {{/tb_013/vp_013/RC[1]} -radix unsigned} {{/tb_013/vp_013/RC[2]} -radix unsigned} {{/tb_013/vp_013/RC[3]} -radix unsigned} {{/tb_013/vp_013/RC[4]} -radix unsigned} {{/tb_013/vp_013/RC[5]} -radix unsigned}} -subitemconfig {/tb_013/vp_013/cell_O24/q3 {-radix unsigned} /tb_013/vp_013/cell_O22/q3 {-radix unsigned} /tb_013/vp_013/cell_N18/q3 {-radix unsigned} /tb_013/vp_013/cell_D20/q3 {-radix unsigned} /tb_013/vp_013/cell_D18/q3 {-radix unsigned} /tb_013/vp_013/cell_F20/q3 {-radix unsigned}} /tb_013/vp_013/RC
add wave -noupdate /tb_013/vp_013/RA
add wave -noupdate -label REFRESH /tb_013/vp_013/cell_E28/y3
add wave -noupdate -label ACCESS /tb_013/vp_013/cell_E26/y3
add wave -noupdate -label ACC_STB /tb_013/vp_013/cell_I24/y9
add wave -noupdate -label ACC_REQ /tb_013/vp_013/cell_L24/q3
add wave -noupdate -label nACC_REQ /tb_013/vp_013/cell_L24/q4
add wave -noupdate -label REF_DONE /tb_013/vp_013/cell_M24/y4
add wave -noupdate -label nREF_REQ /tb_013/vp_013/cell_G22/q4
add wave -noupdate -label ACC_DONE /tb_013/vp_013/cell_I37/y4
add wave -noupdate -label REF_GNT /tb_013/vp_013/cell_M20/y2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5063826 ps} 0}
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
WaveRestoreZoom {0 ps} {128666752 ps}
