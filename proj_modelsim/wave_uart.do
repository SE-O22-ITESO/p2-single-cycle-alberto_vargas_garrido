onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_uart/top/uart_tx/transmit
add wave -noupdate -radix binary /tb_uart/top/uart_tx/dataToTransmit
add wave -noupdate /tb_uart/top/uart_tx/serialOutputTx
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_uart/top/uart_tx/mux_uart_tx/selector
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_uart/top/uart_rx/fsm_rx/enb_cont
add wave -noupdate /tb_uart/top/uart_rx/fsm_rx/rx_data
add wave -noupdate /tb_uart/top/uart_rx/fsm_rx/clearInterrupt
add wave -noupdate /tb_uart/top/uart_rx/fsm_rx/enb_rx
add wave -noupdate /tb_uart/top/uart_rx/fsm_rx/enb_parity
add wave -noupdate /tb_uart/top/uart_rx/fsm_rx/enb_interrupt
add wave -noupdate /tb_uart/top/uart_rx/fsm_rx/state_current
add wave -noupdate /tb_uart/top/uart_rx/fsm_rx/enb_generator
add wave -noupdate /tb_uart/top/uart_rx/fsm_rx/o_enb_generator
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_uart/top/uart_rx/cntr_rx/enb
add wave -noupdate /tb_uart/top/uart_rx/cntr_rx/enb_cont
add wave -noupdate /tb_uart/top/uart_rx/cntr_r/cntr_r
add wave -noupdate /tb_uart/top/uart_rx/cntr_r/cntr_next
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_uart/top/uart_rx/cntr_r/clk
add wave -noupdate /tb_uart/top/uart_rx/cntr_r/rst
add wave -noupdate /tb_uart/top/uart_rx/cntr_r/enb
add wave -noupdate /tb_uart/top/uart_rx/cntr_r/enb_cont
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_uart/top/uart_rx/reg_input_data/enb
add wave -noupdate /tb_uart/top/uart_rx/reg_input_data/inp
add wave -noupdate /tb_uart/top/uart_rx/reg_input_data/out
add wave -noupdate /tb_uart/top/uart_rx/cntr_rx/cntr_r
add wave -noupdate /tb_uart/top/uart_rx/cntr_rx/cntr_next
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_uart/top/uart_rx/ff_d1/enable
add wave -noupdate /tb_uart/top/uart_rx/ff_d1/datainput
add wave -noupdate /tb_uart/top/uart_rx/ff_d1/dataoutput
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_uart/top/uart_rx/receivedData
add wave -noupdate -divider {New Divider}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {988060000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 247
configure wave -valuecolwidth 63
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2347810560 ps}
