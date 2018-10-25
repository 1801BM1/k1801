onerror {resume}
quietly virtual signal -install /tb_096 { (context /tb_096 )&{low_095/cell_O22/q2 , low_095/cell_N22/q2 , low_095/cell_M22/q2 , low_095/cell_J22/q2 , low_095/cell_I22/q2 , low_095/cell_G22/q2 , low_095/cell_C22/q2 , low_095/cell_A22/q2 , high_095/cell_O22/q2 , high_095/cell_N22/q2 , high_095/cell_M22/q2 , high_095/cell_J22/q2 , high_095/cell_I22/q2 , high_095/cell_G22/q2 , high_095/cell_C22/q2 , high_095/cell_A22/q2 }} RD
quietly virtual signal -install /tb_096 { (concat_range (0 to 15) )( (context /tb_096 )&{low_095/cell_O22/q2 , low_095/cell_N22/q2 , low_095/cell_M22/q2 , low_095/cell_J22/q2 , low_095/cell_I22/q2 , low_095/cell_G22/q2 , low_095/cell_C22/q2 , low_095/cell_A22/q2 , high_095/cell_O22/q2 , high_095/cell_N22/q2 , high_095/cell_M22/q2 , high_095/cell_J22/q2 , high_095/cell_I22/q2 , high_095/cell_G22/q2 , high_095/cell_C22/q2 , high_095/cell_A22/q2 } )} RD001
quietly virtual signal -install /tb_096 { (context /tb_096 )&{low_095/cell_O22/q2 , low_095/cell_N22/q2 , low_095/cell_M22/q2 , low_095/cell_J22/q2 , low_095/cell_I22/q2 , low_095/cell_G22/q2 , low_095/cell_C22/q2 , low_095/cell_A22/q2 , high_095/cell_O22/q2 , high_095/cell_N22/q2 , high_095/cell_M22/q2 , high_095/cell_J22/q2 , high_095/cell_I22/q2 , high_095/cell_G22/q2 , high_095/cell_C22/q2 , high_095/cell_A22/q2 }} RDAT
quietly virtual signal -install /tb_096 { (concat_range (0 to 15) )( (context /tb_096 )&{high_095/cell_A22/q2 , high_095/cell_C22/q2 , high_095/cell_G22/q2 , high_095/cell_I22/q2 , high_095/cell_J22/q2 , high_095/cell_M22/q2 , high_095/cell_N22/q2 , high_095/cell_O22/q2 , low_095/cell_A22/q2 , low_095/cell_C22/q2 , low_095/cell_G22/q2 , low_095/cell_I22/q2 , low_095/cell_J22/q2 , low_095/cell_M22/q2 , low_095/cell_N22/q2 , low_095/cell_O22/q2 } )} RDAT001
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_096/CLK
add wave -noupdate -expand -group nDxx /tb_096/nDLA
add wave -noupdate -expand -group nDxx /tb_096/nDLD
add wave -noupdate -expand -group nDxx /tb_096/nDLV
add wave -noupdate -expand -group nDxx /tb_096/nCLD
add wave -noupdate -group nRWx /tb_096/nWWC
add wave -noupdate -group nRWx /tb_096/nRDC
add wave -noupdate -group nRWx /tb_096/nWWP
add wave -noupdate -group nRWx /tb_096/nRDP
add wave -noupdate /tb_096/nBSI
add wave -noupdate /tb_096/nBSO
add wave -noupdate /tb_096/nCMPC
add wave -noupdate /tb_096/nCMPP
add wave -noupdate /tb_096/nRQ
add wave -noupdate /tb_096/nWD
add wave -noupdate -group Creg /tb_096/nSYNC_reg
add wave -noupdate -group Creg /tb_096/nDIN_reg
add wave -noupdate -group Creg /tb_096/nDOUT_reg
add wave -noupdate -group Creg /tb_096/nRPLY_reg
add wave -noupdate -group Creg -radix octal -childformat {{{/tb_096/ADC_reg[21]} -radix octal} {{/tb_096/ADC_reg[20]} -radix octal} {{/tb_096/ADC_reg[19]} -radix octal} {{/tb_096/ADC_reg[18]} -radix octal} {{/tb_096/ADC_reg[17]} -radix octal} {{/tb_096/ADC_reg[16]} -radix octal} {{/tb_096/ADC_reg[15]} -radix octal} {{/tb_096/ADC_reg[14]} -radix octal} {{/tb_096/ADC_reg[13]} -radix octal} {{/tb_096/ADC_reg[12]} -radix octal} {{/tb_096/ADC_reg[11]} -radix octal} {{/tb_096/ADC_reg[10]} -radix octal} {{/tb_096/ADC_reg[9]} -radix octal} {{/tb_096/ADC_reg[8]} -radix octal} {{/tb_096/ADC_reg[7]} -radix octal} {{/tb_096/ADC_reg[6]} -radix octal} {{/tb_096/ADC_reg[5]} -radix octal} {{/tb_096/ADC_reg[4]} -radix octal} {{/tb_096/ADC_reg[3]} -radix octal} {{/tb_096/ADC_reg[2]} -radix octal} {{/tb_096/ADC_reg[1]} -radix octal} {{/tb_096/ADC_reg[0]} -radix octal}} -subitemconfig {{/tb_096/ADC_reg[21]} {-height 15 -radix octal} {/tb_096/ADC_reg[20]} {-height 15 -radix octal} {/tb_096/ADC_reg[19]} {-height 15 -radix octal} {/tb_096/ADC_reg[18]} {-height 15 -radix octal} {/tb_096/ADC_reg[17]} {-height 15 -radix octal} {/tb_096/ADC_reg[16]} {-height 15 -radix octal} {/tb_096/ADC_reg[15]} {-height 15 -radix octal} {/tb_096/ADC_reg[14]} {-height 15 -radix octal} {/tb_096/ADC_reg[13]} {-height 15 -radix octal} {/tb_096/ADC_reg[12]} {-height 15 -radix octal} {/tb_096/ADC_reg[11]} {-height 15 -radix octal} {/tb_096/ADC_reg[10]} {-height 15 -radix octal} {/tb_096/ADC_reg[9]} {-height 15 -radix octal} {/tb_096/ADC_reg[8]} {-height 15 -radix octal} {/tb_096/ADC_reg[7]} {-height 15 -radix octal} {/tb_096/ADC_reg[6]} {-height 15 -radix octal} {/tb_096/ADC_reg[5]} {-height 15 -radix octal} {/tb_096/ADC_reg[4]} {-height 15 -radix octal} {/tb_096/ADC_reg[3]} {-height 15 -radix octal} {/tb_096/ADC_reg[2]} {-height 15 -radix octal} {/tb_096/ADC_reg[1]} {-height 15 -radix octal} {/tb_096/ADC_reg[0]} {-height 15 -radix octal}} /tb_096/ADC_reg
add wave -noupdate -group Creg -radix binary /tb_096/ADC_oe
add wave -noupdate -expand -group Cbus -radix octal -childformat {{{/tb_096/nADC[21]} -radix octal} {{/tb_096/nADC[20]} -radix octal} {{/tb_096/nADC[19]} -radix octal} {{/tb_096/nADC[18]} -radix octal} {{/tb_096/nADC[17]} -radix octal} {{/tb_096/nADC[16]} -radix octal} {{/tb_096/nADC[15]} -radix octal} {{/tb_096/nADC[14]} -radix octal} {{/tb_096/nADC[13]} -radix octal} {{/tb_096/nADC[12]} -radix octal} {{/tb_096/nADC[11]} -radix octal} {{/tb_096/nADC[10]} -radix octal} {{/tb_096/nADC[9]} -radix octal} {{/tb_096/nADC[8]} -radix octal} {{/tb_096/nADC[7]} -radix octal} {{/tb_096/nADC[6]} -radix octal} {{/tb_096/nADC[5]} -radix octal} {{/tb_096/nADC[4]} -radix octal} {{/tb_096/nADC[3]} -radix octal} {{/tb_096/nADC[2]} -radix octal} {{/tb_096/nADC[1]} -radix octal} {{/tb_096/nADC[0]} -radix octal}} -subitemconfig {{/tb_096/nADC[21]} {-height 15 -radix octal} {/tb_096/nADC[20]} {-height 15 -radix octal} {/tb_096/nADC[19]} {-height 15 -radix octal} {/tb_096/nADC[18]} {-height 15 -radix octal} {/tb_096/nADC[17]} {-height 15 -radix octal} {/tb_096/nADC[16]} {-height 15 -radix octal} {/tb_096/nADC[15]} {-height 15 -radix octal} {/tb_096/nADC[14]} {-height 15 -radix octal} {/tb_096/nADC[13]} {-height 15 -radix octal} {/tb_096/nADC[12]} {-height 15 -radix octal} {/tb_096/nADC[11]} {-height 15 -radix octal} {/tb_096/nADC[10]} {-height 15 -radix octal} {/tb_096/nADC[9]} {-height 15 -radix octal} {/tb_096/nADC[8]} {-height 15 -radix octal} {/tb_096/nADC[7]} {-height 15 -radix octal} {/tb_096/nADC[6]} {-height 15 -radix octal} {/tb_096/nADC[5]} {-height 15 -radix octal} {/tb_096/nADC[4]} {-height 15 -radix octal} {/tb_096/nADC[3]} {-height 15 -radix octal} {/tb_096/nADC[2]} {-height 15 -radix octal} {/tb_096/nADC[1]} {-height 15 -radix octal} {/tb_096/nADC[0]} {-height 15 -radix octal}} /tb_096/nADC
add wave -noupdate -expand -group Cbus /tb_096/nSYNCC
add wave -noupdate -expand -group Cbus /tb_096/nWTBTC
add wave -noupdate -expand -group Cbus /tb_096/nDINC
add wave -noupdate -expand -group Cbus /tb_096/nDOUTC
add wave -noupdate -expand -group Cbus /tb_096/nRPLYC
add wave -noupdate -expand -group Cirq -group 096_IRQ /tb_096/ctrl_096/VIRQ
add wave -noupdate -expand -group Cirq -group 096_IRQ /tb_096/ctrl_096/nVIRQ
add wave -noupdate -expand -group Cirq -group 096_IRQ /tb_096/ctrl_096/IRQ
add wave -noupdate -expand -group Cirq /tb_096/nIAKIC
add wave -noupdate -expand -group Cirq /tb_096/nIAKO
add wave -noupdate -expand -group Cirq /tb_096/nVIRQC
add wave -noupdate -expand -group Cgnt /tb_096/GNT
add wave -noupdate -expand -group Cgnt /tb_096/nDMRC
add wave -noupdate -expand -group Cgnt /tb_096/nDMGIC
add wave -noupdate -expand -group Cgnt /tb_096/nDMGO
add wave -noupdate -expand -group Cgnt /tb_096/SACK
add wave -noupdate -expand -group Cgnt /tb_096/nSACK
add wave -noupdate -group Preg -radix octal /tb_096/ADP_reg
add wave -noupdate -group Preg /tb_096/ADP_oe
add wave -noupdate -expand -group Pbus -radix octal -childformat {{{/tb_096/nADP[15]} -radix octal} {{/tb_096/nADP[14]} -radix octal} {{/tb_096/nADP[13]} -radix octal} {{/tb_096/nADP[12]} -radix octal} {{/tb_096/nADP[11]} -radix octal} {{/tb_096/nADP[10]} -radix octal} {{/tb_096/nADP[9]} -radix octal} {{/tb_096/nADP[8]} -radix octal} {{/tb_096/nADP[7]} -radix octal} {{/tb_096/nADP[6]} -radix octal} {{/tb_096/nADP[5]} -radix octal} {{/tb_096/nADP[4]} -radix octal} {{/tb_096/nADP[3]} -radix octal} {{/tb_096/nADP[2]} -radix octal} {{/tb_096/nADP[1]} -radix octal} {{/tb_096/nADP[0]} -radix octal}} -subitemconfig {{/tb_096/nADP[15]} {-height 15 -radix octal} {/tb_096/nADP[14]} {-height 15 -radix octal} {/tb_096/nADP[13]} {-height 15 -radix octal} {/tb_096/nADP[12]} {-height 15 -radix octal} {/tb_096/nADP[11]} {-height 15 -radix octal} {/tb_096/nADP[10]} {-height 15 -radix octal} {/tb_096/nADP[9]} {-height 15 -radix octal} {/tb_096/nADP[8]} {-height 15 -radix octal} {/tb_096/nADP[7]} {-height 15 -radix octal} {/tb_096/nADP[6]} {-height 15 -radix octal} {/tb_096/nADP[5]} {-height 15 -radix octal} {/tb_096/nADP[4]} {-height 15 -radix octal} {/tb_096/nADP[3]} {-height 15 -radix octal} {/tb_096/nADP[2]} {-height 15 -radix octal} {/tb_096/nADP[1]} {-height 15 -radix octal} {/tb_096/nADP[0]} {-height 15 -radix octal}} /tb_096/nADP
add wave -noupdate -expand -group Pbus /tb_096/nSYNCP
add wave -noupdate -expand -group Pbus /tb_096/nWTBTP
add wave -noupdate -expand -group Pbus /tb_096/nDINP
add wave -noupdate -expand -group Pbus /tb_096/nDOUTP
add wave -noupdate -expand -group Pbus /tb_096/nRPLYP
add wave -noupdate -expand -group Pbus /tb_096/nINITP
add wave -noupdate /tb_096/nCON
add wave -noupdate /tb_096/CON
add wave -noupdate /tb_096/nBSC
add wave -noupdate /tb_096/nBSP
add wave -noupdate -label RDAT -radix octal -childformat {{{/tb_096/RDAT001[0]} -radix octal} {{/tb_096/RDAT001[1]} -radix octal} {{/tb_096/RDAT001[2]} -radix octal} {{/tb_096/RDAT001[3]} -radix octal} {{/tb_096/RDAT001[4]} -radix octal} {{/tb_096/RDAT001[5]} -radix octal} {{/tb_096/RDAT001[6]} -radix octal} {{/tb_096/RDAT001[7]} -radix octal} {{/tb_096/RDAT001[8]} -radix octal} {{/tb_096/RDAT001[9]} -radix octal} {{/tb_096/RDAT001[10]} -radix octal} {{/tb_096/RDAT001[11]} -radix octal} {{/tb_096/RDAT001[12]} -radix octal} {{/tb_096/RDAT001[13]} -radix octal} {{/tb_096/RDAT001[14]} -radix octal} {{/tb_096/RDAT001[15]} -radix octal}} -subitemconfig {/tb_096/high_095/cell_A22/q2 {-radix octal} /tb_096/high_095/cell_C22/q2 {-radix octal} /tb_096/high_095/cell_G22/q2 {-radix octal} /tb_096/high_095/cell_I22/q2 {-radix octal} /tb_096/high_095/cell_J22/q2 {-radix octal} /tb_096/high_095/cell_M22/q2 {-radix octal} /tb_096/high_095/cell_N22/q2 {-radix octal} /tb_096/high_095/cell_O22/q2 {-radix octal} /tb_096/low_095/cell_A22/q2 {-radix octal} /tb_096/low_095/cell_C22/q2 {-radix octal} /tb_096/low_095/cell_G22/q2 {-radix octal} /tb_096/low_095/cell_I22/q2 {-radix octal} /tb_096/low_095/cell_J22/q2 {-radix octal} /tb_096/low_095/cell_M22/q2 {-radix octal} /tb_096/low_095/cell_N22/q2 {-radix octal} /tb_096/low_095/cell_O22/q2 {-radix octal}} /tb_096/RDAT001
add wave -noupdate -group 096_SACK /tb_096/ctrl_096/SACK_C1
add wave -noupdate -group 096_SACK /tb_096/ctrl_096/SACK_F1
add wave -noupdate -group 096_SACK /tb_096/ctrl_096/nSACK_F1
add wave -noupdate -group 096_SACK /tb_096/ctrl_096/SACK_F2
add wave -noupdate -group 096_SACK /tb_096/ctrl_096/nSACK_F2
add wave -noupdate -group 096_SACK /tb_096/ctrl_096/SACK_F3
add wave -noupdate -group 096_SACK /tb_096/ctrl_096/nSACK_F3
add wave -noupdate -group 096_SACK /tb_096/ctrl_096/SACK_F4
add wave -noupdate -group 096_SACK /tb_096/ctrl_096/nSACK_F4
add wave -noupdate -group 096_SACK /tb_096/ctrl_096/SACK_S1
add wave -noupdate -label CSR0 /tb_096/low_095/cell_O26/q2
add wave -noupdate -label CSR1 /tb_096/low_095/cell_N26/q2
add wave -noupdate -label CSR2 /tb_096/low_095/cell_M26/q2
add wave -noupdate -label CSR3 /tb_096/low_095/cell_J26/q2
add wave -noupdate -label CSR4 /tb_096/low_095/cell_I26/q2
add wave -noupdate -label CSR5 /tb_096/low_095/cell_H28/q2
add wave -noupdate -label CSR6 /tb_096/low_095/cell_C26/q2
add wave -noupdate -label CSR7 /tb_096/low_095/cell_A24/q2
add wave -noupdate -label CSR8 /tb_096/high_095/cell_O26/q2
add wave -noupdate -label CSR9 /tb_096/high_095/cell_N26/q2
add wave -noupdate -label CSR10 /tb_096/high_095/cell_M26/q2
add wave -noupdate -label CSR11 /tb_096/high_095/cell_J26/q2
add wave -noupdate -label CSR12 /tb_096/high_095/cell_I26/q2
add wave -noupdate -label CSR13 /tb_096/high_095/cell_H28/q2
add wave -noupdate -label CSR14 /tb_096/high_095/cell_C26/q2
add wave -noupdate -label CSR15 /tb_096/high_095/cell_A24/q2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2559977 ps} 0}
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
WaveRestoreZoom {0 ps} {5964660 ps}
