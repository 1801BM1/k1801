onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix octal /tb_bpic/nAD
add wave -noupdate -radix octal /tb_bpic/AD_in
add wave -noupdate -radix octal /tb_bpic/AD_out
add wave -noupdate /tb_bpic/AD_oe
add wave -noupdate /tb_bpic/nBS
add wave -noupdate /tb_bpic/nSYNC
add wave -noupdate /tb_bpic/nWTBT
add wave -noupdate /tb_bpic/nDOUT
add wave -noupdate /tb_bpic/nDIN
add wave -noupdate /tb_bpic/nRPLY
add wave -noupdate /tb_bpic/nINIT
add wave -noupdate /tb_bpic/nIAKI
add wave -noupdate /tb_bpic/nVIRQ
add wave -noupdate /tb_bpic/nIAKO
add wave -noupdate /tb_bpic/nIN
add wave -noupdate /tb_bpic/nOUT
add wave -noupdate /tb_bpic/nSET
add wave -noupdate /tb_bpic/ERR
add wave -noupdate /tb_bpic/DONE
add wave -noupdate /tb_bpic/TR
add wave -noupdate /tb_bpic/nAO_A
add wave -noupdate /tb_bpic/nAC_A
add wave -noupdate /tb_bpic/nSC_S
add wave -noupdate /tb_bpic/nAC_S
add wave -noupdate /tb_bpic/nSC_A
add wave -noupdate /tb_bpic/nSO_S
add wave -noupdate -group vp_bpic /tb_bpic/vp_bpic/nREQ
add wave -noupdate -group vp_bpic /tb_bpic/vp_bpic/nIRQ
add wave -noupdate -group vp_bpic /tb_bpic/vp_bpic/IRQA
add wave -noupdate -group vp_bpic /tb_bpic/vp_bpic/IRQB
add wave -noupdate -group vp_bpic /tb_bpic/vp_bpic/IEA
add wave -noupdate -group vp_bpic /tb_bpic/vp_bpic/IEB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2427967 ps} 0}
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
WaveRestoreZoom {0 ps} {8192 ns}
