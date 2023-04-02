module register_sp
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
		dataoutput <= 'h7fffeffc;
	else
		if(enable==1)
			dataoutput<=datainput;
end

endmodule
