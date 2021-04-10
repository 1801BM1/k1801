onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix octal /tb_pio/nAD
add wave -noupdate -radix octal /tb_pio/AD_in
add wave -noupdate -radix octal /tb_pio/AD_out
add wave -noupdate /tb_pio/AD_oe
add wave -noupdate /tb_pio/nBS
add wave -noupdate /tb_pio/nSYNC
add wave -noupdate /tb_pio/nWTBT
add wave -noupdate /tb_pio/nDOUT
add wave -noupdate /tb_pio/nDIN
add wave -noupdate /tb_pio/nRPLY
add wave -noupdate /tb_pio/nINIT
add wave -noupdate /tb_pio/nIAKI
add wave -noupdate /tb_pio/nVIRQ
add wave -noupdate /tb_pio/nIAKO
add wave -noupdate /tb_pio/RDO
add wave -noupdate /tb_pio/RDI
add wave -noupdate /tb_pio/nB0R
add wave -noupdate /tb_pio/nB1R
add wave -noupdate /tb_pio/nDTR
add wave -noupdate /tb_pio/nNDR
add wave -noupdate /tb_pio/nORR
add wave -noupdate /tb_pio/CSR0
add wave -noupdate /tb_pio/CSR1
add wave -noupdate /tb_pio/REQA
add wave -noupdate /tb_pio/REQB
add wave -noupdate -group vp_pio /tb_pio/vp_pio/REQB
add wave -noupdate -group vp_pio /tb_pio/vp_pio/nREQA
add wave -noupdate -group vp_pio /tb_pio/vp_pio/nREQB
add wave -noupdate -group vp_pio /tb_pio/vp_pio/nIRQ
add wave -noupdate -group vp_pio -group c32 /tb_pio/vp_pio/cell_C32/q3
add wave -noupdate -group vp_pio -group c32 /tb_pio/vp_pio/cell_C32/q4
add wave -noupdate -group vp_pio -group c32 /tb_pio/vp_pio/cell_C32/r1
add wave -noupdate -group vp_pio -group c32 /tb_pio/vp_pio/cell_C32/s6
add wave -noupdate -group vp_pio -group c32 /tb_pio/vp_pio/cell_C32/x2
add wave -noupdate -group vp_pio -group c32 /tb_pio/vp_pio/cell_C32/y7
add wave -noupdate -group vp_pio -group c33 /tb_pio/vp_pio/cell_C33/c1
add wave -noupdate -group vp_pio -group c33 /tb_pio/vp_pio/cell_C33/q3
add wave -noupdate -group vp_pio -group c33 /tb_pio/vp_pio/cell_C33/q4
add wave -noupdate -group vp_pio -group c33 /tb_pio/vp_pio/cell_C33/r2
add wave -noupdate -group vp_pio -group c33 /tb_pio/vp_pio/cell_C33/r5
add wave -noupdate -group vp_pio -group c33 /tb_pio/vp_pio/cell_C33/s10
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4133250 ps} 0}
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
WaveRestoreZoom {0 ps} {8707136 ps}
