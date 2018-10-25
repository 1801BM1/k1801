onerror {resume}
quietly virtual function -install /tb_128 -env /tb_128/#INITIAL#57 { &{/tb_128/nDI, /tb_128/vp_128/cell_F35/y4, /tb_128/vp_128/cell_G27/y4, /tb_128/vp_128/cell_G27/y3 }} RDATA
quietly virtual signal -install /tb_128/vp_128 { (concat_range (0 to 3) )( (context /tb_128/vp_128 )&{cell_F19/y2 , cell_G19/y2 , cell_H19/y2 , cell_I19/y2 } )} BCNT
quietly virtual signal -install /tb_128/vp_128 { (concat_range (0 to 7) )( (context /tb_128/vp_128 )&{cell_C11/q3 , cell_D11/q3 , cell_F11/q3 , cell_G11/q3 , cell_H11/q3 , cell_I11/q3 , cell_J11/q3 , cell_L11/q3 } )} SREG
quietly virtual signal -install /tb_128/vp_128 { (concat_range (0 to 15) )( (context /tb_128/vp_128 )&{cell_L36/q3 , cell_L34/q3 , cell_L30/q3 , cell_L28/q3 , cell_L26/q3 , cell_N36/q3 , cell_N34/q3 , cell_N30/q3 , cell_N28/q3 , cell_N26/q3 , cell_M36/q3 , cell_M34/q3 , cell_M30/q3 , cell_M28/q3 , cell_M26/q3 , cell_M22/q3 } )} CRC
quietly virtual signal -install /tb_128/vp_128 { (concat_range (0 to 2) )( (context /tb_128/vp_128 )&{cell_D25/y2 , cell_C25/y2 , cell_A25/y4 } )} PLL_CNT
quietly virtual signal -install /tb_128/vp_128 { (concat_range (0 to 15) )( (context /tb_128/vp_128 )&{cell_B2/q3 , cell_B1/q3 , cell_A0/q3 , cell_B0/q3 , cell_D0/q3 , cell_F0/q3 , cell_H0/q3 , cell_I0/q3 , cell_J0/q3 , cell_M0/q3 , cell_N0/q3 , cell_O0/q3 , cell_O1/q3 , cell_O4/q3 , cell_O6/q3 , cell_O10/q3 } )} RDR
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix octal /tb_128/nAD
add wave -noupdate -radix octal /tb_128/AD_in
add wave -noupdate -radix octal -childformat {{{/tb_128/AD_out[15]} -radix octal} {{/tb_128/AD_out[14]} -radix octal} {{/tb_128/AD_out[13]} -radix octal} {{/tb_128/AD_out[12]} -radix octal} {{/tb_128/AD_out[11]} -radix octal} {{/tb_128/AD_out[10]} -radix octal} {{/tb_128/AD_out[9]} -radix octal} {{/tb_128/AD_out[8]} -radix octal} {{/tb_128/AD_out[7]} -radix octal} {{/tb_128/AD_out[6]} -radix octal} {{/tb_128/AD_out[5]} -radix octal} {{/tb_128/AD_out[4]} -radix octal} {{/tb_128/AD_out[3]} -radix octal} {{/tb_128/AD_out[2]} -radix octal} {{/tb_128/AD_out[1]} -radix octal} {{/tb_128/AD_out[0]} -radix octal}} -subitemconfig {{/tb_128/AD_out[15]} {-height 15 -radix octal} {/tb_128/AD_out[14]} {-height 15 -radix octal} {/tb_128/AD_out[13]} {-height 15 -radix octal} {/tb_128/AD_out[12]} {-height 15 -radix octal} {/tb_128/AD_out[11]} {-height 15 -radix octal} {/tb_128/AD_out[10]} {-height 15 -radix octal} {/tb_128/AD_out[9]} {-height 15 -radix octal} {/tb_128/AD_out[8]} {-height 15 -radix octal} {/tb_128/AD_out[7]} {-height 15 -radix octal} {/tb_128/AD_out[6]} {-height 15 -radix octal} {/tb_128/AD_out[5]} {-height 15 -radix octal} {/tb_128/AD_out[4]} {-height 15 -radix octal} {/tb_128/AD_out[3]} {-height 15 -radix octal} {/tb_128/AD_out[2]} {-height 15 -radix octal} {/tb_128/AD_out[1]} {-height 15 -radix octal} {/tb_128/AD_out[0]} {-height 15 -radix octal}} /tb_128/AD_out
add wave -noupdate /tb_128/AD_oe
add wave -noupdate /tb_128/nSYNC
add wave -noupdate /tb_128/nDIN
add wave -noupdate /tb_128/nDOUT
add wave -noupdate /tb_128/nINIT
add wave -noupdate /tb_128/nRPLY
add wave -noupdate /tb_128/nDS
add wave -noupdate /tb_128/nMSW
add wave -noupdate /tb_128/nST
add wave -noupdate /tb_128/DIR
add wave -noupdate /tb_128/HS
add wave -noupdate /tb_128/nWRE
add wave -noupdate /tb_128/CLK
add wave -noupdate -expand /tb_128/nDO
add wave -noupdate -label WDATA /tb_128/vp_128/cell_D32/y4
add wave -noupdate -label WCLK /tb_128/vp_128/cell_D31/y9
add wave -noupdate -label nWCLK /tb_128/vp_128/cell_D33/y9
add wave -noupdate /tb_128/nREZ
add wave -noupdate -expand -group RDATA /tb_128/nDI
add wave -noupdate -expand -group RDATA -label RDATA /tb_128/vp_128/cell_F35/y4
add wave -noupdate -expand -group RDATA -label RD_y /tb_128/vp_128/cell_G27/y4
add wave -noupdate -expand -group RDATA -label nRD_y /tb_128/vp_128/cell_G27/y3
add wave -noupdate /tb_128/IND
add wave -noupdate -label IND_M21 /tb_128/vp_128/cell_M21/y4
add wave -noupdate -label IND_CLK /tb_128/vp_128/cell_H15/y4
add wave -noupdate /tb_128/TR0
add wave -noupdate /tb_128/RDY
add wave -noupdate /tb_128/WRP
add wave -noupdate -group PLL -label PLL_CLK /tb_128/vp_128/cell_D19/y3
add wave -noupdate -group PLL -label PLL_A /tb_128/vp_128/cell_A25/y4
add wave -noupdate -group PLL -label PLL_B /tb_128/vp_128/cell_C25/y2
add wave -noupdate -group PLL -label PLL_C /tb_128/vp_128/cell_D25/y2
add wave -noupdate -group PLL -label nPLL_Z /tb_128/vp_128/cell_G26/y9
add wave -noupdate -expand -group CLK -label nAPC_CLK /tb_128/vp_128/cell_A19/y2
add wave -noupdate -expand -group CLK -label APC_CLK /tb_128/vp_128/cell_A19/y4
add wave -noupdate -expand -group CLK -label BIT_CLK /tb_128/vp_128/cell_E24/y3
add wave -noupdate -expand -group CLK -label nBIT_CLK /tb_128/vp_128/cell_E30/y3
add wave -noupdate -expand -group CLK -label nRDD_CLK /tb_128/vp_128/cell_F24/y3
add wave -noupdate -expand -group CLK -label RDD_CLK /tb_128/vp_128/cell_F24/y4
add wave -noupdate -expand -group CLK -label nP90_CLK /tb_128/vp_128/cell_B19/y4
add wave -noupdate -expand -group CLK -label P90_CLK /tb_128/vp_128/cell_B20/y4
add wave -noupdate -expand -group CLK -label BCNT_CLK /tb_128/vp_128/cell_C18/y4
add wave -noupdate -radix unsigned -childformat {{{/tb_128/vp_128/BCNT[0]} -radix decimal} {{/tb_128/vp_128/BCNT[1]} -radix decimal} {{/tb_128/vp_128/BCNT[2]} -radix decimal} {{/tb_128/vp_128/BCNT[3]} -radix decimal}} -subitemconfig {/tb_128/vp_128/cell_F19/y2 {-radix decimal} /tb_128/vp_128/cell_G19/y2 {-radix decimal} /tb_128/vp_128/cell_H19/y2 {-radix decimal} /tb_128/vp_128/cell_I19/y2 {-radix decimal}} /tb_128/vp_128/BCNT
add wave -noupdate -radix hexadecimal /tb_128/vp_128/SREG
add wave -noupdate -radix hexadecimal -childformat {{{/tb_128/vp_128/CRC[0]} -radix hexadecimal} {{/tb_128/vp_128/CRC[1]} -radix hexadecimal} {{/tb_128/vp_128/CRC[2]} -radix hexadecimal} {{/tb_128/vp_128/CRC[3]} -radix hexadecimal} {{/tb_128/vp_128/CRC[4]} -radix hexadecimal} {{/tb_128/vp_128/CRC[5]} -radix hexadecimal} {{/tb_128/vp_128/CRC[6]} -radix hexadecimal} {{/tb_128/vp_128/CRC[7]} -radix hexadecimal} {{/tb_128/vp_128/CRC[8]} -radix hexadecimal} {{/tb_128/vp_128/CRC[9]} -radix hexadecimal} {{/tb_128/vp_128/CRC[10]} -radix hexadecimal} {{/tb_128/vp_128/CRC[11]} -radix hexadecimal} {{/tb_128/vp_128/CRC[12]} -radix hexadecimal} {{/tb_128/vp_128/CRC[13]} -radix hexadecimal} {{/tb_128/vp_128/CRC[14]} -radix hexadecimal} {{/tb_128/vp_128/CRC[15]} -radix hexadecimal}} -subitemconfig {/tb_128/vp_128/cell_L36/q3 {-radix hexadecimal} /tb_128/vp_128/cell_L34/q3 {-radix hexadecimal} /tb_128/vp_128/cell_L30/q3 {-radix hexadecimal} /tb_128/vp_128/cell_L28/q3 {-radix hexadecimal} /tb_128/vp_128/cell_L26/q3 {-radix hexadecimal} /tb_128/vp_128/cell_N36/q3 {-radix hexadecimal} /tb_128/vp_128/cell_N34/q3 {-radix hexadecimal} /tb_128/vp_128/cell_N30/q3 {-radix hexadecimal} /tb_128/vp_128/cell_N28/q3 {-radix hexadecimal} /tb_128/vp_128/cell_N26/q3 {-radix hexadecimal} /tb_128/vp_128/cell_M36/q3 {-radix hexadecimal} /tb_128/vp_128/cell_M34/q3 {-radix hexadecimal} /tb_128/vp_128/cell_M30/q3 {-radix hexadecimal} /tb_128/vp_128/cell_M28/q3 {-radix hexadecimal} /tb_128/vp_128/cell_M26/q3 {-radix hexadecimal} /tb_128/vp_128/cell_M22/q3 {-radix hexadecimal}} /tb_128/vp_128/CRC
add wave -noupdate -expand -group CRC -label CRC_VALID /tb_128/vp_128/cell_J35/y2
add wave -noupdate -expand -group CRC -label CRC_IN0 /tb_128/vp_128/cell_J37/y4
add wave -noupdate -expand -group CRC -label nCRC_RST /tb_128/vp_128/cell_I39/y2
add wave -noupdate -expand -group CRC -label CSR_CRC /tb_128/vp_128/cell_J36/y4
add wave -noupdate -label CSR_TR /tb_128/vp_128/cell_M12/q2
add wave -noupdate -label RDR_HSTB /tb_128/vp_128/cell_K19/y3
add wave -noupdate -label RDR_LSTB /tb_128/vp_128/cell_K13/y3
add wave -noupdate -label RDINIT0 /tb_128/vp_128/cell_K22/y3
add wave -noupdate -label RDINIT1 /tb_128/vp_128/cell_K21/y3
add wave -noupdate -label nGDR /tb_128/vp_128/cell_G35/q4
add wave -noupdate -radix hexadecimal -childformat {{{/tb_128/vp_128/RDR[0]} -radix hexadecimal} {{/tb_128/vp_128/RDR[1]} -radix hexadecimal} {{/tb_128/vp_128/RDR[2]} -radix hexadecimal} {{/tb_128/vp_128/RDR[3]} -radix hexadecimal} {{/tb_128/vp_128/RDR[4]} -radix hexadecimal} {{/tb_128/vp_128/RDR[5]} -radix hexadecimal} {{/tb_128/vp_128/RDR[6]} -radix hexadecimal} {{/tb_128/vp_128/RDR[7]} -radix hexadecimal} {{/tb_128/vp_128/RDR[8]} -radix hexadecimal} {{/tb_128/vp_128/RDR[9]} -radix hexadecimal} {{/tb_128/vp_128/RDR[10]} -radix hexadecimal} {{/tb_128/vp_128/RDR[11]} -radix hexadecimal} {{/tb_128/vp_128/RDR[12]} -radix hexadecimal} {{/tb_128/vp_128/RDR[13]} -radix hexadecimal} {{/tb_128/vp_128/RDR[14]} -radix hexadecimal} {{/tb_128/vp_128/RDR[15]} -radix hexadecimal}} -subitemconfig {/tb_128/vp_128/cell_B2/q3 {-radix hexadecimal} /tb_128/vp_128/cell_B1/q3 {-radix hexadecimal} /tb_128/vp_128/cell_A0/q3 {-radix hexadecimal} /tb_128/vp_128/cell_B0/q3 {-radix hexadecimal} /tb_128/vp_128/cell_D0/q3 {-radix hexadecimal} /tb_128/vp_128/cell_F0/q3 {-radix hexadecimal} /tb_128/vp_128/cell_H0/q3 {-radix hexadecimal} /tb_128/vp_128/cell_I0/q3 {-radix hexadecimal} /tb_128/vp_128/cell_J0/q3 {-radix hexadecimal} /tb_128/vp_128/cell_M0/q3 {-radix hexadecimal} /tb_128/vp_128/cell_N0/q3 {-radix hexadecimal} /tb_128/vp_128/cell_O0/q3 {-radix hexadecimal} /tb_128/vp_128/cell_O1/q3 {-radix hexadecimal} /tb_128/vp_128/cell_O4/q3 {-radix hexadecimal} /tb_128/vp_128/cell_O6/q3 {-radix hexadecimal} /tb_128/vp_128/cell_O10/q3 {-radix hexadecimal}} /tb_128/vp_128/RDR
add wave -noupdate -label MODE_nR/W /tb_128/vp_128/cell_E33/y3
add wave -noupdate -label MODE_R/nW /tb_128/vp_128/cell_N22/y4
add wave -noupdate -label LAST_WR /tb_128/vp_128/cell_L23/q1
add wave -noupdate -label LATCH_TR /tb_128/vp_128/cell_O18/y2
add wave -noupdate -label CSR_WM /tb_128/vp_128/cell_G39/q3
add wave -noupdate -label nMARK_A5 /tb_128/vp_128/cell_D31/y4
add wave -noupdate -label FIN_STB /tb_128/vp_128/cell_K15/y3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {444450392 ps} 0}
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
WaveRestoreZoom {273638514 ps} {671546986 ps}
