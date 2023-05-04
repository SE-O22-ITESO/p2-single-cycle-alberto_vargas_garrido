onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RISC_V_processor_TB/clk
add wave -noupdate /RISC_V_processor_TB/rst
add wave -noupdate /RISC_V_processor_TB/top/uart_serial_input
add wave -noupdate /RISC_V_processor_TB/top/uart_serial_output
add wave -noupdate /RISC_V_processor_TB/top/uart/finished_tx
add wave -noupdate /RISC_V_processor_TB/top/uart/rxInterrupt
add wave -noupdate /RISC_V_processor_TB/top/uart/transmit
add wave -noupdate /RISC_V_processor_TB/top/uart/uart_tx/pipo_tx/dataoutput
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand /RISC_V_processor_TB/top/datamemory/ram
add wave -noupdate /RISC_V_processor_TB/top/datamemory/readdata
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/forwardwd_mux/selector
add wave -noupdate /RISC_V_processor_TB/top/core/forwardwd_mux/mux_data0
add wave -noupdate /RISC_V_processor_TB/top/core/forwardwd_mux/mux_data1
add wave -noupdate /RISC_V_processor_TB/top/core/forwardwd_mux/mux_data2
add wave -noupdate /RISC_V_processor_TB/top/core/forwardwd_mux/mux_data3
add wave -noupdate /RISC_V_processor_TB/top/core/forwardwd_mux/mux_output
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/intruction
add wave -noupdate /RISC_V_processor_TB/top/core/received_data
add wave -noupdate /RISC_V_processor_TB/top/core/memwrite
add wave -noupdate /RISC_V_processor_TB/top/core/memread
add wave -noupdate /RISC_V_processor_TB/top/core/data_address
add wave -noupdate /RISC_V_processor_TB/top/core/writedata
add wave -noupdate /RISC_V_processor_TB/top/core/pc_address
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/mux_new_address/selector
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/mux_new_address/mux_data0
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/mux_new_address/mux_data1
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/mux_new_address/mux_data2
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/mux_new_address/mux_data3
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/mux_new_address/mux_output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1196240000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 395
configure wave -valuecolwidth 97
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
WaveRestoreZoom {598199200 ps} {1794280800 ps}
