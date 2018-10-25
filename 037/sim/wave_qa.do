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
add wave -noupdate -radix octal -childformat {{{/tb_037/A[6]} -radix octal} {{/tb_037/A[5]} -radix octal} {{/tb_037/A[4]} -radix octal} {{/tb_037/A[3]} -radix octal} {{/tb_037/A[2]} -radix octal} {{/tb_037/A[1]} -radix octal} {{/tb_037/A[0]} -radix octal}} -subitemconfig {{/tb_037/A[6]} {-height 15 -radix octal} {/tb_037/A[5]} {-height 15 -radix octal} {/tb_037/A[4]} {-height 15 -radix octal} {/tb_037/A[3]} {-height 15 -radix octal} {/tb_037/A[2]} {-height 15 -radix octal} {/tb_037/A[1]} {-height 15 -radix octal} {/tb_037/A[0]} {-height 15 -radix octal}} /tb_037/A
add wave -noupdate /tb_037/nRAS
add wave -noupdate /tb_037/nCAS
add wave -noupdate /tb_037/nWE
add wave -noupdate /tb_037/nE
add wave -noupdate /tb_037/nBS
add wave -noupdate /tb_037/WTI
add wave -noupdate /tb_037/WTD
add wave -noupdate /tb_037/nVSYNC
add wave -noupdate -group PCx -radix octal -childformat {{{/tb_037/va_037/PC[2]} -radix octal} {{/tb_037/va_037/PC[1]} -radix octal} {{/tb_037/va_037/PC[0]} -radix octal}} -expand -subitemconfig {{/tb_037/va_037/PC[2]} {-height 15 -radix octal} {/tb_037/va_037/PC[1]} {-height 15 -radix octal} {/tb_037/va_037/PC[0]} {-height 15 -radix octal}} /tb_037/va_037/PC
add wave -noupdate -group PCx /tb_037/CLK
add wave -noupdate -group PCx /tb_037/va_037/PC90
add wave -noupdate /tb_037/va_037/AMUXSEL
add wave -noupdate -radix octal -childformat {{{/tb_037/va_037/VA[13]} -radix octal} {{/tb_037/va_037/VA[12]} -radix octal} {{/tb_037/va_037/VA[11]} -radix octal} {{/tb_037/va_037/VA[10]} -radix octal} {{/tb_037/va_037/VA[9]} -radix octal} {{/tb_037/va_037/VA[8]} -radix octal} {{/tb_037/va_037/VA[7]} -radix octal} {{/tb_037/va_037/VA[6]} -radix octal} {{/tb_037/va_037/VA[5]} -radix octal} {{/tb_037/va_037/VA[4]} -radix octal} {{/tb_037/va_037/VA[3]} -radix octal} {{/tb_037/va_037/VA[2]} -radix octal} {{/tb_037/va_037/VA[1]} -radix octal}} -subitemconfig {{/tb_037/va_037/VA[13]} {-height 15 -radix octal} {/tb_037/va_037/VA[12]} {-height 15 -radix octal} {/tb_037/va_037/VA[11]} {-height 15 -radix octal} {/tb_037/va_037/VA[10]} {-height 15 -radix octal} {/tb_037/va_037/VA[9]} {-height 15 -radix octal} {/tb_037/va_037/VA[8]} {-height 15 -radix octal} {/tb_037/va_037/VA[7]} {-height 15 -radix octal} {/tb_037/va_037/VA[6]} {-height 15 -radix octal} {/tb_037/va_037/VA[5]} {-height 15 -radix octal} {/tb_037/va_037/VA[4]} {-height 15 -radix octal} {/tb_037/va_037/VA[3]} {-height 15 -radix octal} {/tb_037/va_037/VA[2]} {-height 15 -radix octal} {/tb_037/va_037/VA[1]} {-height 15 -radix octal}} /tb_037/va_037/VA
add wave -noupdate -radix octal -childformat {{{/tb_037/va_037/LC[7]} -radix octal} {{/tb_037/va_037/LC[6]} -radix octal} {{/tb_037/va_037/LC[5]} -radix octal} {{/tb_037/va_037/LC[4]} -radix octal} {{/tb_037/va_037/LC[3]} -radix octal} {{/tb_037/va_037/LC[2]} -radix octal} {{/tb_037/va_037/LC[1]} -radix octal} {{/tb_037/va_037/LC[0]} -radix octal}} -subitemconfig {{/tb_037/va_037/LC[7]} {-height 15 -radix octal} {/tb_037/va_037/LC[6]} {-height 15 -radix octal} {/tb_037/va_037/LC[5]} {-height 15 -radix octal} {/tb_037/va_037/LC[4]} {-height 15 -radix octal} {/tb_037/va_037/LC[3]} {-height 15 -radix octal} {/tb_037/va_037/LC[2]} {-height 15 -radix octal} {/tb_037/va_037/LC[1]} {-height 15 -radix octal} {/tb_037/va_037/LC[0]} {-height 15 -radix octal}} /tb_037/va_037/LC
add wave -noupdate -radix octal -childformat {{{/tb_037/va_037/RA[7]} -radix octal} {{/tb_037/va_037/RA[6]} -radix octal} {{/tb_037/va_037/RA[5]} -radix octal} {{/tb_037/va_037/RA[4]} -radix octal} {{/tb_037/va_037/RA[3]} -radix octal} {{/tb_037/va_037/RA[2]} -radix octal} {{/tb_037/va_037/RA[1]} -radix octal} {{/tb_037/va_037/RA[0]} -radix octal}} -subitemconfig {{/tb_037/va_037/RA[7]} {-height 15 -radix octal} {/tb_037/va_037/RA[6]} {-height 15 -radix octal} {/tb_037/va_037/RA[5]} {-height 15 -radix octal} {/tb_037/va_037/RA[4]} {-height 15 -radix octal} {/tb_037/va_037/RA[3]} {-height 15 -radix octal} {/tb_037/va_037/RA[2]} {-height 15 -radix octal} {/tb_037/va_037/RA[1]} {-height 15 -radix octal} {/tb_037/va_037/RA[0]} {-height 15 -radix octal}} /tb_037/va_037/RA
add wave -noupdate /tb_037/va_037/ALOAD
add wave -noupdate /tb_037/va_037/FREEZ
add wave -noupdate /tb_037/va_037/HGATE
add wave -noupdate /tb_037/va_037/VGATE
add wave -noupdate /tb_037/va_037/RASEL
add wave -noupdate /tb_037/nVSYNC
add wave -noupdate /tb_037/va_037/SYNC2
add wave -noupdate /tb_037/va_037/SYNC5
add wave -noupdate /tb_037/CLK
add wave -noupdate /tb_037/va_037/VTSYN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1245808 ps} 0} {{Cursor 2} {1261071000 ps} 1}
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
WaveRestoreZoom {0 ps} {3933368 ps}
