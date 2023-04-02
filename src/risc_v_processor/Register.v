/******************************************************************
* description
*	this the basic register that is used in the register file
*	1.0
* author:
*	dr. josé luis pizano escalante
* email:
*	luispizano@iteso.mx
* date:
*	01/03/2014
******************************************************************/
module register
#(
	parameter n=32
)
(
	input clk,
	input reset,
	input enable,
	input  [n-1:0] datainput,
	
	
	output reg [n-1:0] dataoutput
);

always@(negedge reset or posedge clk) begin
	if(!reset)
		dataoutput <= 0;
	else	
		if(enable==1)
			dataoutput<=datainput;
end

endmodule
//register
