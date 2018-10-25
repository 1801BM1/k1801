onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix octal /tb_014/nAD
add wave -noupdate -radix octal /tb_014/AD_in
add wave -noupdate -radix octal /tb_014/AD_out
add wave -noupdate /tb_014/AD_oe
add wave -noupdate /tb_014/nCS
add wave -noupdate /tb_014/nDIN
add wave -noupdate /tb_014/nDOUT
add wave -noupdate /tb_014/nSYNC
add wave -noupdate /tb_014/nINIT
add wave -noupdate /tb_014/nRPLY
add wave -noupdate /tb_014/nIRQ
add wave -noupdate /tb_014/nIAKI
add wave -noupdate /tb_014/nIAKO
add wave -noupdate /tb_014/Y_in
add wave -noupdate /tb_014/Y_out
add wave -noupdate /tb_014/X_in
add wave -noupdate /tb_014/CTRL
add wave -noupdate /tb_014/SHIFT
add wave -noupdate /tb_014/EC1
add wave -noupdate /tb_014/EC2
add wave -noupdate /tb_014/RP1_out
add wave -noupdate /tb_014/RP1_in
add wave -noupdate -label RP1.count -radix unsigned /tb_014/rp1/count
add wave -noupdate /tb_014/RP2_out
add wave -noupdate /tb_014/RP2_in
add wave -noupdate -label RP2.count -radix unsigned /tb_014/rp2/count
add wave -noupdate /tb_014/CLK
add wave -noupdate -label nIRQ /tb_014/vp_014/cell_L7/y8
add wave -noupdate -label READY /tb_014/vp_014/cell_I9/y2
add wave -noupdate -label nREADY /tb_014/vp_014/cell_I9/y4
add wave -noupdate -label DATRD /tb_014/vp_014/cell_D31/y3
add wave -noupdate -label BUSY /tb_014/vp_014/cell_H7/y4
add wave -noupdate -label RELEASE /tb_014/vp_014/cell_G9/y4
add wave -noupdate -label PRESS /tb_014/vp_014/cell_F9/y4
add wave -noupdate -label LOCK /tb_014/vp_014/cell_F20/y4
add wave -noupdate -label nLOCK /tb_014/vp_014/cell_D7/y4
add wave -noupdate -label WSTB /tb_014/vp_014/cell_D7/y9
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11806500 ps} 0}
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
WaveRestoreZoom {3546297 ps} {20235641 ps}
