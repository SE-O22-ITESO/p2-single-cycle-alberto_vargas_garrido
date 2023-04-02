/******************************************************************
* description
*	this is a register of 32-bit that corresponds to the pc counter. 
*	this register does not have an enable signal.
* version:
*	1.0
* author:
*	dr. josé luis pizano escalante
* email:
*	luispizano@iteso.mx
* date:
*	01/03/2014
******************************************************************/

module pc_register
#(
	parameter n=32
)
(
	input clk,
	input reset,
	input enable,
	input [n-1:0] newpc,
	
	
	output reg [n-1:0] pcvalue
);

always@(negedge reset or posedge clk) begin
	if(!reset)
		pcvalue <= 'h400000;
	else
		if(enable)
			pcvalue<=newpc;
end

endmodule
//pcreg
