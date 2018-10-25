onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix octal -childformat {{{/tb_065/nAD[15]} -radix octal} {{/tb_065/nAD[14]} -radix octal} {{/tb_065/nAD[13]} -radix octal} {{/tb_065/nAD[12]} -radix octal} {{/tb_065/nAD[11]} -radix octal} {{/tb_065/nAD[10]} -radix octal} {{/tb_065/nAD[9]} -radix octal} {{/tb_065/nAD[8]} -radix octal} {{/tb_065/nAD[7]} -radix octal} {{/tb_065/nAD[6]} -radix octal} {{/tb_065/nAD[5]} -radix octal} {{/tb_065/nAD[4]} -radix octal} {{/tb_065/nAD[3]} -radix octal} {{/tb_065/nAD[2]} -radix octal} {{/tb_065/nAD[1]} -radix octal} {{/tb_065/nAD[0]} -radix octal}} -subitemconfig {{/tb_065/nAD[15]} {-height 15 -radix octal} {/tb_065/nAD[14]} {-height 15 -radix octal} {/tb_065/nAD[13]} {-height 15 -radix octal} {/tb_065/nAD[12]} {-height 15 -radix octal} {/tb_065/nAD[11]} {-height 15 -radix octal} {/tb_065/nAD[10]} {-height 15 -radix octal} {/tb_065/nAD[9]} {-height 15 -radix octal} {/tb_065/nAD[8]} {-height 15 -radix octal} {/tb_065/nAD[7]} {-height 15 -radix octal} {/tb_065/nAD[6]} {-height 15 -radix octal} {/tb_065/nAD[5]} {-height 15 -radix octal} {/tb_065/nAD[4]} {-height 15 -radix octal} {/tb_065/nAD[3]} {-height 15 -radix octal} {/tb_065/nAD[2]} {-height 15 -radix octal} {/tb_065/nAD[1]} {-height 15 -radix octal} {/tb_065/nAD[0]} {-height 15 -radix octal}} /tb_065/nAD
add wave -noupdate -radix octal /tb_065/AD_in
add wave -noupdate -radix octal /tb_065/AD_out
add wave -noupdate /tb_065/AD_oe
add wave -noupdate /tb_065/nINIT
add wave -noupdate /tb_065/nSYNC
add wave -noupdate /tb_065/nDIN
add wave -noupdate /tb_065/nDOUT
add wave -noupdate /tb_065/nRPLY
add wave -noupdate /tb_065/nDCLO
add wave -noupdate /tb_065/nBS
add wave -noupdate -expand /tb_065/nEVNT
add wave -noupdate -radix octal -childformat {{{/tb_065/nSEL[1]} -radix octal} {{/tb_065/nSEL[0]} -radix octal}} -subitemconfig {{/tb_065/nSEL[1]} {-height 15 -radix octal} {/tb_065/nSEL[0]} {-height 15 -radix octal}} /tb_065/nSEL
add wave -noupdate /tb_065/nVIRQ
add wave -noupdate /tb_065/nIAKI
add wave -noupdate /tb_065/nIAKO
add wave -noupdate /tb_065/master/FBAUD
add wave -noupdate /tb_065/CLK
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TCLO
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXBRK
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXCNT0
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXCNT1
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXCNT2
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXCNT3
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXCNTL
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXF
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXFRAME
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXIER
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXIRQ
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXIRQ_ACK
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXLD
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXLSB
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXPCLR
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXPSET
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXRDY
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXSHC
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXSTB
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXSTOP
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/TXTEST
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTB10
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTB105
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTB11
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTB12
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTB6
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTB7
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTB75
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTB9
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTB85
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTCLO
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTXCNT0
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTXCNT0B
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTXCNT1
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTXCNT2
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTXCNT3
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTXDATA
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTXF
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTXFRAME
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTXSHC
add wave -noupdate -expand -group Master -expand -group TX /tb_065/master/nTXTEST
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXBRK
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXCLK
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXCNT3
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXDATA
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXDIN
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXF
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXFCLR
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXFRAME
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXFSET
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXIER
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXIRQ
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXIRQ_ACK
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXLD
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXLD0
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXNEW
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXSTB
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/RXSTRT
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/nRXCLK
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/nRXCNT0
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/nRXCNT1
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/nRXCNT2
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/nRXCNT3
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/nRXEND
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/nRXFRAME
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/nRXSTB
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/nRXSTB0
add wave -noupdate -expand -group Master -expand -group RX /tb_065/master/nRXSTOP
add wave -noupdate -expand -group Master -group Baud /tb_065/master/F50
add wave -noupdate -expand -group Master -group Baud /tb_065/master/F75
add wave -noupdate -expand -group Master -group Baud /tb_065/master/F100
add wave -noupdate -expand -group Master -group Baud /tb_065/master/F150
add wave -noupdate -expand -group Master -group Baud /tb_065/master/F200
add wave -noupdate -expand -group Master -group Baud /tb_065/master/F300
add wave -noupdate -expand -group Master -group Baud /tb_065/master/F600
add wave -noupdate -expand -group Master -group Baud /tb_065/master/F1200
add wave -noupdate -expand -group Master -group Baud /tb_065/master/F2400
add wave -noupdate -expand -group Master -group Baud /tb_065/master/F4800
add wave -noupdate -expand -group Master -group Baud /tb_065/master/F9600
add wave -noupdate -expand -group Master -group Baud /tb_065/master/F19200
add wave -noupdate -expand -group Master -group Baud /tb_065/master/F57600
add wave -noupdate -expand -group Master -group Baud /tb_065/master/FBAUD
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TCLO
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXBRK
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXCNT0
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXCNT1
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXCNT2
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXCNT3
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXCNTL
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXF
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXFRAME
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXIER
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXIRQ
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXIRQ_ACK
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXLD
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXLSB
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXPCLR
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXPSET
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXRDY
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXSHC
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXSTB
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXSTOP
add wave -noupdate -expand -group Slave -group TX /tb_065/slave/TXTEST
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXBRK
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXCLK
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXCNT3
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXDATA
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXDIN
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXF
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXFCLR
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXFRAME
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXFSET
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXIER
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXIRQ
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXIRQ_ACK
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXLD
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXLD0
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXNEW
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXSTB
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/RXSTRT
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/nRXCLK
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/nRXCNT0
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/nRXCNT1
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/nRXCNT2
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/nRXCNT3
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/nRXEND
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/nRXFRAME
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/nRXSTB
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/nRXSTB0
add wave -noupdate -expand -group Slave -expand -group RX /tb_065/slave/nRXSTOP
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/F50
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/F75
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/F100
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/F150
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/F200
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/F300
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/F600
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/F1200
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/F2400
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/F4800
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/F19200
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/F57600
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/F9600
add wave -noupdate -expand -group Slave -group Baud /tb_065/slave/FBAUD
add wave -noupdate /tb_065/TXD
add wave -noupdate /tb_065/DTR
add wave -noupdate /tb_065/RXD
add wave -noupdate /tb_065/CTS
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 4} {57287476 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 136
configure wave -valuecolwidth 39
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
WaveRestoreZoom {0 ps} {232290991 ps}
