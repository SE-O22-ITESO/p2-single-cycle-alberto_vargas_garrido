vlog -vlog01compat -work uart_tb ../src/Adder32bits.v
vlog -vlog01compat -work uart_tb ../src/ALU.v
vlog -vlog01compat -work uart_tb ../src/ANDGate.v
vlog -vlog01compat -work uart_tb ../src/Control.v
vlog -vlog01compat -work uart_tb ../src/Multiplexer2to1.v
vlog -vlog01compat -work uart_tb ../src/Multiplexer4to1.v
vlog -vlog01compat -work uart_tb ../src/MUXRegisterFile.v
vlog -vlog01compat -work uart_tb ../src/Register.v
vlog -vlog01compat -work uart_tb ../src/RegisterFile.v
vlog -vlog01compat -work uart_tb ../src/ShiftLeft2.v
vlog -vlog01compat -work uart_tb ../src/SignExtend.v

vlog -vlog01compat -work uart_tb ../src/uart/fsm_uart_rx.v
vlog -vlog01compat -work uart_tb ../src/uart/fsm_uart_tx.v
vlog -vlog01compat -work uart_tb ../src/uart/piso_lsb.v
vlog -vlog01compat -work uart_tb ../src/uart/sipo_lsb.v
vlog -vlog01compat -work uart_tb ../src/uart/counter.v
vlog -vlog01compat -work uart_tb ../src/uart/device_uart_rx.v
vlog -vlog01compat -work uart_tb ../src/uart/device_uart_tx.v
vlog -vlog01compat -work uart_tb ../src/uart/uart_top.v
vlog -vlog01compat -work uart_tb ../src/uart/clk_div.v
vlog -vlog01compat -work uart_tb ./uart_tb.v

vsim -voptargs=+acc uart_tb.tb_uart
