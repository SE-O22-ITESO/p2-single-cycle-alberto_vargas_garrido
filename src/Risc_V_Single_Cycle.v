module Risc_V_Single_Cycle
(
    input clk,
    input reset,
    input [7:0] gpio_port_in,
    input uart_serial_input,
    
    output uart_serial_output,
    output [7:0] gpio_port_out
);

wire [31:0] out_address_wire;
wire [31:0] out_data_wire;
wire [31:0] data_address;
wire [31:0] pc_address;
wire [31:0] instruction_wire;
wire [31:0] read_data_out_wire;
wire [31:0] readdata_wire;
wire [31:0] writedata_wire;
wire [7:0] uart_received_data_wire;
wire [7:0] gpio_port_read_out_wire;
wire [2:0] out_write_en;
wire in_write_en;
wire write_en_sel;
wire finished_tx_wire;
wire parity_error_wire;
wire rx_interrupt_wire;

wire clk_n; 
wire rst_n;

assign clk_n = clk;
assign rst_n = reset;

RISC_V_processor
#(
	.memory_depth(64)
)
core
(
    .clk(clk_n),
    .reset(rst_n),
	.intruction(instruction_wire),
    .received_data(read_data_out_wire),

    .memwrite(in_write_en),
	.memread(),
    .writedata(writedata_wire),
    .pc_address(pc_address),
	.data_address(data_address)
    //.aluresultout()
);


//******************************************************************/
//******adder - divider*********************************************/

//******************************************************************/
//******memmory****************************************************/


programmemory
#(	.data_width(32),
 	.memory_depth(64)
)
romprogrammemory
(
	.address((pc_address - 'h00400000) >> 2),

	.instruction(instruction_wire)
);


datamemory
#(
	.data_width(32),
 	.memory_depth(64)
) //conforme a las especificaciones del documento
datamemory
(
	//inputs
	.writedata(out_data_wire), //32
	.address(out_address_wire), //32
	// 1 ln input
	.memwrite(out_write_en[0]),
	.memread(1'b1),
	.clk(clk_n),

	//output
	.readdata(readdata_wire) //32
);

top_memory_x
top_memory_system
(
	.in_address(data_address),
	.in_data(writedata_wire),
	.in_write_en(in_write_en),
	.in_read_data0(32'h00000000),
	.in_read_data1(readdata_wire),
	.in_read_data2({24'h000000, gpio_port_read_out_wire}),
	.in_read_data3({21'h000000, finished_tx_wire, parity_error_wire, rx_interrupt_wire, uart_received_data_wire}),
	
	.out_address(out_address_wire),
	.out_data(out_data_wire),
	.out_write_en(out_write_en),
	.out_read_data(read_data_out_wire)
);


gpio_top
gpio
(
	.gpio_clk(clk_n),
    .wite_to_gpio(out_write_en[1]),
    .gpio_port_read_in(gpio_port_in),
    .gpio_port_write_in(out_data_wire[7:0]),

    .gpio_port_read_out(gpio_port_read_out_wire),
    .gpio_port_write_out(gpio_port_out)
);


uart_top
uart
(
	// Input - Input clock
	.clk(clk_n),
	// Input - Reset	/
	.rst(rst_n),
	.serialDataRX(uart_serial_input),
	.clearInterrupt(),
	.transmit(out_write_en[2]),
	.dataToTransmit(out_data_wire[7:0]),

	.receivedData(uart_received_data_wire),
	.rxInterrupt(rx_interrupt_wire),
	.parityError(parity_error_wire),
	.finished_tx(finished_tx_wire),
	.serialOutputTx(uart_serial_output)
);

endmodule
