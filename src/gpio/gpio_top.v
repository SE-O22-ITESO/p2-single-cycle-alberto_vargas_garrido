module gpio_top
(
    input gpio_clk,
    input wite_to_gpio,
    input [7:0] gpio_port_read_in,
    input [7:0] gpio_port_write_in,

    output [7:0] gpio_port_read_out,
    output [7:0] gpio_port_write_out
);

register
#(.n(8))
gpio_buffer_in
(
	.clk(gpio_clk),
	.reset(1'b0),
	.enable(1'b1),
	.datainput(gpio_port_read_in),

	.dataoutput(gpio_port_read_out)
);

register
#(.n(8))
gpio_buffer_out
(
	.clk(gpio_clk),
	.reset(1'b0),
	.enable(wite_to_gpio),
	.datainput(gpio_port_write_in),

	.dataoutput(gpio_port_write_out)
);

endmodule
