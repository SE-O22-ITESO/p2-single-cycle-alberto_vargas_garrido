/******************************************************************
* description
*	this is a  an adder that can be parameterized in its bit-width.
*	1.0
* author:
*	dr. josé luis pizano escalante
* email:
*	luispizano@iteso.mx
* date:
*	01/03/2014
******************************************************************/

module adder32bits
#
(
	parameter nbits=32
)
(
	input [nbits-1:0] data0,
	input [nbits-1:0] data1,
	
	output [nbits-1:0] result
);

assign result = data1 + data0;


endmodule
//adder32