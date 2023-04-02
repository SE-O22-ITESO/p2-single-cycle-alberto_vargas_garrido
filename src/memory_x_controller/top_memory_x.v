module top_memory_x
(
	input[31:0] in_address,
	input[31:0] in_data,
	input[31:0] in_read_data0,
	input[31:0] in_read_data1,
	input[31:0] in_read_data2,
	input[31:0] in_read_data3,
	input in_write_en,
	
	output[31:0] out_address,
	output[31:0] out_data,
	output[2:0] out_write_en,
	output[31:0] out_read_data
);

wire [31:0] data_w = in_data;
wire [31:0] new_address_wire;
wire [31:0] mux_read_data_out_wire;
wire [1:0] data_sel_wire;
wire [1:0] address_sel;

memory_x_control
x
(
    .in_write_en(in_write_en),
    .address(in_address),

    .out_write_en(out_write_en),
    .address_sel(address_sel),
    .data_sel(data_sel_wire)
);

multiplexer4to1
mux_new_address
(
	.selector(address_sel),
	.mux_data0((in_address - 'h00400000) >> 2),
	.mux_data1(((in_address - 'h7fffeefc) >> 2)-1),
	.mux_data2(32'h0000),
	.mux_data3(32'h0000),

	.mux_output(new_address_wire)

);

multiplexer4to1
mux_read_data
(
	.selector(data_sel_wire),
	.mux_data0(in_read_data0),
	.mux_data1(in_read_data1),
	.mux_data2(in_read_data2),
	.mux_data3(in_read_data3),

	.mux_output(mux_read_data_out_wire)

);

assign out_data = data_w;
assign out_read_data = mux_read_data_out_wire;
assign out_address = new_address_wire;

endmodule
