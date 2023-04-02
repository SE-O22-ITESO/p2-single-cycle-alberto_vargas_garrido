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

module multiplexer2to1
#(
	parameter nbits=32
)
(
	input selector,
	input [nbits-1:0] mux_data0,
	input [nbits-1:0] mux_data1,
	
	output reg [nbits-1:0] mux_output

);

	always@(selector,mux_data1,mux_data0) begin
		if(selector)
			mux_output = mux_data1;
		else
			mux_output = mux_data0;
	end

endmodule
//mux21