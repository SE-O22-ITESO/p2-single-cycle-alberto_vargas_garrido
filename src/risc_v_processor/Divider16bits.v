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

module divider16bits
(
	input [15:0] dividend,
	input [15:0] divisor,
	
	output [15:0] result
);

reg [15:0] actual_result;

always@(dividend or divisor) begin
	if (divisor == 0)
		actual_result = dividend; // por conveniencia decido dejar sin cambiar el dividend, util para offset de 0($reg)
	else 
		actual_result = dividend / divisor;
end

assign result[15] = actual_result[15];
assign result[14] = actual_result[14];
assign result[13] = actual_result[13];
assign result[12] = actual_result[12];
assign result[11] = actual_result[11];
assign result[10] = actual_result[10];
assign result[09] = actual_result[09];
assign result[08] = actual_result[08];
assign result[07] = actual_result[07];
assign result[06] = actual_result[06];
assign result[05] = actual_result[05];
assign result[04] = actual_result[04];
assign result[03] = actual_result[03];
assign result[02] = actual_result[02];
assign result[01] = actual_result[01];
assign result[00] = actual_result[00];

endmodule
//adder32