module registerpipeline
#(
	parameter n=32
)
(
	input clk,
	input reset,
	input enable,
    input clear,
	input  [n-1:0] datainput,
	
	
	output reg [n-1:0] dataoutput
);

always@(negedge reset or negedge clk) begin
	if(!reset)
		dataoutput <= 0;
	else begin
		if(enable) begin 
				if(clear)
					dataoutput <= 0;
				else
					dataoutput<=datainput;
        end
    end
end
endmodule