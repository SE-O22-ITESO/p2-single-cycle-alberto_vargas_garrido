onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RISC_V_processor_TB/top/clk
add wave -noupdate /RISC_V_processor_TB/top/reset
add wave -noupdate /RISC_V_processor_TB/top/uart_serial_input
add wave -noupdate /RISC_V_processor_TB/top/uart_serial_output
add wave -noupdate /RISC_V_processor_TB/top/uart/uart_tx/control_tx/state_curr
add wave -noupdate /RISC_V_processor_TB/top/uart/uart_tx/piso_uart_tx/piso_input
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/uart/uart_tx/pipo_tx/enable
add wave -noupdate /RISC_V_processor_TB/top/uart/uart_tx/pipo_tx/datainput
add wave -noupdate /RISC_V_processor_TB/top/uart/uart_tx/pipo_tx/dataoutput
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/x/in_write_en
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/x/address
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/x/out_write_en
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/x/address_sel
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/x/data_sel
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/uart/serialDataRX
add wave -noupdate /RISC_V_processor_TB/top/uart/clearInterrupt
add wave -noupdate /RISC_V_processor_TB/top/uart/transmit
add wave -noupdate /RISC_V_processor_TB/top/uart/dataToTransmit
add wave -noupdate /RISC_V_processor_TB/top/uart/receivedData
add wave -noupdate /RISC_V_processor_TB/top/uart/finished_tx
add wave -noupdate /RISC_V_processor_TB/top/uart/rxInterrupt
add wave -noupdate /RISC_V_processor_TB/top/uart/parityError
add wave -noupdate /RISC_V_processor_TB/top/uart/serialOutputTx
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/in_address
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/in_data
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/in_read_data0
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/in_read_data1
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/in_read_data2
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/in_read_data3
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/in_write_en
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/out_address
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/out_data
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/out_write_en
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/out_read_data
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/ALUaut_mux/selector
add wave -noupdate /RISC_V_processor_TB/top/core/ALUaut_mux/mux_data0
add wave -noupdate /RISC_V_processor_TB/top/core/ALUaut_mux/mux_data1
add wave -noupdate /RISC_V_processor_TB/top/core/ALUaut_mux/mux_data2
add wave -noupdate /RISC_V_processor_TB/top/core/ALUaut_mux/mux_data3
add wave -noupdate /RISC_V_processor_TB/top/core/ALUaut_mux/mux_output
add wave -noupdate /RISC_V_processor_TB/top/core/controlunit/state
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/x/data_sel
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/regwrite
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/writeregister
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/writedata
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/aluoperation
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/a
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/b
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/zero
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/alessb
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/aluresult
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1196824376 ps} 0}
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
WaveRestoreZoom {1196756687 ps} {1196877495 ps}
