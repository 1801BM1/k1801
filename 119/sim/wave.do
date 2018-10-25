onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_119/CLK
add wave -noupdate /tb_119/RCLK
add wave -noupdate /tb_119/nSEL
add wave -noupdate -radix octal /tb_119/A
add wave -noupdate /tb_119/nTA
add wave -noupdate /tb_119/nSYNC
add wave -noupdate /tb_119/nESYNC
add wave -noupdate /tb_119/LA
add wave -noupdate /tb_119/nDIN
add wave -noupdate /tb_119/nDOUT
add wave -noupdate /tb_119/nWTBT
add wave -noupdate /tb_119/nSACK
add wave -noupdate /tb_119/nRPLY
add wave -noupdate /tb_119/nFRPY
add wave -noupdate /tb_119/nRAS0
add wave -noupdate /tb_119/nRAS1
add wave -noupdate /tb_119/nCAS
add wave -noupdate /tb_119/nWE
add wave -noupdate /tb_119/nWEC
add wave -noupdate /tb_119/S0
add wave -noupdate /tb_119/S1
add wave -noupdate /tb_119/nRB
add wave -noupdate /tb_119/CB0
add wave -noupdate /tb_119/CB1
add wave -noupdate /tb_119/nSROM
add wave -noupdate /tb_119/nSRAM0
add wave -noupdate /tb_119/nSRAM1
add wave -noupdate /tb_119/nIN
add wave -noupdate /tb_119/nOUT
add wave -noupdate /tb_119/DCE
add wave -noupdate /tb_119/DEF
add wave -noupdate /tb_119/nDCLO
add wave -noupdate /tb_119/nHLTM
add wave -noupdate -expand -group DRAM /tb_119/memc/nDR_ENA
add wave -noupdate -expand -group DRAM /tb_119/memc/DR_DIS
add wave -noupdate -expand -group DRAM /tb_119/memc/nDR_WIN
add wave -noupdate -expand -group DRAM /tb_119/memc/DR_RAS
add wave -noupdate -expand -group DRAM /tb_119/memc/DR_CAS
add wave -noupdate -expand -group DRAM /tb_119/memc/DR_PH2
add wave -noupdate -expand -group DRAM /tb_119/memc/DR_PH3
add wave -noupdate -expand -group DRAM /tb_119/memc/DR_PH4
add wave -noupdate -expand -group DRAM /tb_119/memc/DR_PW6
add wave -noupdate -expand -group DRAM /tb_119/memc/nDR_RAS
add wave -noupdate -expand -group DRAM /tb_119/memc/nDR_CAS
add wave -noupdate -expand -group DRAM /tb_119/memc/nDR_PH2
add wave -noupdate -expand -group DRAM /tb_119/memc/nDR_PH3
add wave -noupdate -expand -group DRAM /tb_119/memc/nDR_PH4
add wave -noupdate -expand -group DRAM /tb_119/memc/nDR_PW5
add wave -noupdate /tb_119/memc/WORDW
add wave -noupdate /tb_119/memc/nWBYTEF
add wave -noupdate /tb_119/memc/nWDONE
add wave -noupdate /tb_119/memc/nWTBTF
add wave -noupdate /tb_119/memc/nWTBT
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 126
configure wave -valuecolwidth 65
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
WaveRestoreZoom {629863 ps} {7845595 ps}
