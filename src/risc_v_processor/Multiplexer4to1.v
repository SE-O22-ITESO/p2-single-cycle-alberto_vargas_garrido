/******************************************************************
* description
*	this is a  an 2to1 multiplexer that can be parameterized in its bit-width.
*	1.0
* author:
*	dr. josé luis pizano escalante
* email:
*	luispizano@iteso.mx
* date:
*	01/03/2014
******************************************************************/

module multiplexer4to1
#(
	parameter nbits=32
)
(
	input [1:0] selector,
	input [nbits-1:0] mux_data0,
	input [nbits-1:0] mux_data1,
	input [nbits-1:0] mux_data2,
	input [nbits-1:0] mux_data3,
	
	output reg [nbits-1:0] mux_output

);

	always@(selector,mux_data3,mux_data2,mux_data1,mux_data0) begin
		if(selector == 2'h0)
			mux_output = mux_data0;
		else if(selector == 2'h1)
			mux_output = mux_data1;
		else if(selector == 2'h2)
			mux_output = mux_data2;
		else
			mux_output = mux_data3;
	end

endmodule
//mux21
