onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_037/nAD
add wave -noupdate /tb_037/AD_in
add wave -noupdate /tb_037/AD_out
add wave -noupdate /tb_037/AD_oe
add wave -noupdate /tb_037/R
add wave -noupdate /tb_037/C
add wave -noupdate /tb_037/CLK
add wave -noupdate /tb_037/nDIN
add wave -noupdate /tb_037/nDOUT
add wave -noupdate /tb_037/nSYNC
add wave -noupdate /tb_037/nWTBT
add wave -noupdate /tb_037/nRPLY
add wave -noupdate -radix octal /tb_037/A
add wave -noupdate /tb_037/nRAS
add wave -noupdate -expand /tb_037/nCAS
add wave -noupdate /tb_037/nWE
add wave -noupdate /tb_037/nE
add wave -noupdate /tb_037/nBS
add wave -noupdate /tb_037/WTI
add wave -noupdate /tb_037/WTD
add wave -noupdate /tb_037/nVSYNC
add wave -noupdate -expand -group PCx /tb_037/CLK
add wave -noupdate -expand -group IRQ2 /tb_037/d28
add wave -noupdate -expand -group IRQ2 /tb_037/d3
add wave -noupdate -expand -group IRQ2 /tb_037/c28
add wave -noupdate -expand -group IRQ2 /tb_037/nIRQ2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4081097250 ps} 0} {{Cursor 2} {843070 ps} 0}
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
WaveRestoreZoom {3431599851 ps} {4665425947 ps}
