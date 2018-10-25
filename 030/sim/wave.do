onerror {resume}
quietly virtual signal -install /tb_030/vp_030 { (context /tb_030/vp_030 )&{cell_O25/q4 , cell_O26/q4 , cell_O27/q3 }} A
quietly virtual signal -install /tb_030/vp_030 { (context /tb_030/vp_030 )&{cell_F22/q3 , cell_G20/q3 , cell_F20/q3 , cell_F17/q3 }} STATE
quietly virtual signal -install /tb_030/vp_030 { (context /tb_030/vp_030 )&{cell_O21/q3 , cell_N20/q3 , cell_N26/q3 , cell_N30/q3 , cell_N34/q3 , cell_N38/q3 }} REFCNT
quietly virtual signal -install /tb_030/vp_030 { (concat_range (0 to 5) )( (context /tb_030/vp_030 )&{cell_O21/q3 , cell_N20/q3 , cell_N26/q3 , cell_N30/q3 , cell_N34/q3 , cell_N38/q3 } )} REFCNT001
quietly virtual signal -install /tb_030/vp_030 { (context /tb_030/vp_030 )&{cell_N38/q3 , cell_N34/q3 , cell_N30/q3 , cell_N26/q3 , cell_N20/q3 , cell_O21/q3 }} REFCNT002
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix octal /tb_030/nAD
add wave -noupdate -radix octal /tb_030/AD_in
add wave -noupdate /tb_030/AD_oe
add wave -noupdate /tb_030/CLK
add wave -noupdate /tb_030/nSYNC
add wave -noupdate /tb_030/nDIN
add wave -noupdate /tb_030/nDOUT
add wave -noupdate /tb_030/nRPLY
add wave -noupdate /tb_030/nWTBT
add wave -noupdate /tb_030/nDCLO
add wave -noupdate /tb_030/nRSEL
add wave -noupdate /tb_030/MSEL
add wave -noupdate -radix unsigned -childformat {{{/tb_030/nRAS[1]} -radix unsigned} {{/tb_030/nRAS[0]} -radix unsigned}} -expand -subitemconfig {{/tb_030/nRAS[1]} {-height 15 -radix unsigned} {/tb_030/nRAS[0]} {-height 15 -radix unsigned}} /tb_030/nRAS
add wave -noupdate -radix unsigned -childformat {{{/tb_030/nCAS[1]} -radix unsigned} {{/tb_030/nCAS[0]} -radix unsigned}} -expand -subitemconfig {{/tb_030/nCAS[1]} {-height 15 -radix unsigned} {/tb_030/nCAS[0]} {-height 15 -radix unsigned}} /tb_030/nCAS
add wave -noupdate -radix hexadecimal -childformat {{{/tb_030/A[6]} -radix hexadecimal} {{/tb_030/A[5]} -radix hexadecimal} {{/tb_030/A[4]} -radix hexadecimal} {{/tb_030/A[3]} -radix hexadecimal} {{/tb_030/A[2]} -radix hexadecimal} {{/tb_030/A[1]} -radix hexadecimal} {{/tb_030/A[0]} -radix hexadecimal}} -subitemconfig {{/tb_030/A[6]} {-height 15 -radix hexadecimal} {/tb_030/A[5]} {-height 15 -radix hexadecimal} {/tb_030/A[4]} {-height 15 -radix hexadecimal} {/tb_030/A[3]} {-height 15 -radix hexadecimal} {/tb_030/A[2]} {-height 15 -radix hexadecimal} {/tb_030/A[1]} {-height 15 -radix hexadecimal} {/tb_030/A[0]} {-height 15 -radix hexadecimal}} /tb_030/A
add wave -noupdate /tb_030/nWE
add wave -noupdate /tb_030/nDME
add wave -noupdate /tb_030/RSTB
add wave -noupdate /tb_030/LOCK
add wave -noupdate -label nCLK /tb_030/vp_030/cell_E1/y3
add wave -noupdate -label CLK /tb_030/vp_030/cell_E2/y3
add wave -noupdate -radix hexadecimal -childformat {{{/tb_030/vp_030/A[2]} -radix hexadecimal} {{/tb_030/vp_030/A[1]} -radix hexadecimal} {{/tb_030/vp_030/A[0]} -radix hexadecimal}} -subitemconfig {/tb_030/vp_030/cell_O25/q4 {-radix hexadecimal} /tb_030/vp_030/cell_O26/q4 {-radix hexadecimal} /tb_030/vp_030/cell_O27/q3 {-radix hexadecimal}} /tb_030/vp_030/A
add wave -noupdate -label RSTADR /tb_030/vp_030/cell_K15/y3
add wave -noupdate -label MFG_TEST /tb_030/vp_030/cell_F14/x3
add wave -noupdate -label nACCESS /tb_030/vp_030/cell_E14/y3
add wave -noupdate -label nREFRESH /tb_030/vp_030/cell_E15/y3
add wave -noupdate -label nREF_REQ /tb_030/vp_030/cell_F11/q4
add wave -noupdate -label nMEM_REQ /tb_030/vp_030/cell_H19/q3
add wave -noupdate -label MEM_REQ_SET /tb_030/vp_030/cell_I4/y2
add wave -noupdate -label REF_DONE /tb_030/vp_030/cell_D14/y4
add wave -noupdate -radix hexadecimal -childformat {{{/tb_030/vp_030/STATE[3]} -radix hexadecimal} {{/tb_030/vp_030/STATE[2]} -radix hexadecimal} {{/tb_030/vp_030/STATE[1]} -radix hexadecimal} {{/tb_030/vp_030/STATE[0]} -radix hexadecimal}} -subitemconfig {/tb_030/vp_030/cell_F22/q3 {-radix hexadecimal} /tb_030/vp_030/cell_G20/q3 {-radix hexadecimal} /tb_030/vp_030/cell_F20/q3 {-radix hexadecimal} /tb_030/vp_030/cell_F17/q3 {-radix hexadecimal}} /tb_030/vp_030/STATE
add wave -noupdate -label nWFLAG /tb_030/vp_030/cell_D36/q3
add wave -noupdate -label EARLY_REF_REQ /tb_030/vp_030/cell_G21/q4
add wave -noupdate -radix unsigned -childformat {{{/tb_030/vp_030/REFCNT002[5]} -radix unsigned} {{/tb_030/vp_030/REFCNT002[4]} -radix unsigned} {{/tb_030/vp_030/REFCNT002[3]} -radix unsigned} {{/tb_030/vp_030/REFCNT002[2]} -radix unsigned} {{/tb_030/vp_030/REFCNT002[1]} -radix unsigned} {{/tb_030/vp_030/REFCNT002[0]} -radix unsigned}} -subitemconfig {/tb_030/vp_030/cell_N38/q3 {-radix unsigned} /tb_030/vp_030/cell_N34/q3 {-radix unsigned} /tb_030/vp_030/cell_N30/q3 {-radix unsigned} /tb_030/vp_030/cell_N26/q3 {-radix unsigned} /tb_030/vp_030/cell_N20/q3 {-radix unsigned} /tb_030/vp_030/cell_O21/q3 {-radix unsigned}} /tb_030/vp_030/REFCNT002
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1271590 ps} 0}
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
WaveRestoreZoom {1020179 ps} {6467057 ps}
