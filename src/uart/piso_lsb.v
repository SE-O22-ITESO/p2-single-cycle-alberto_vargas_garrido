module piso_lsb
(
	input               clk,    // Clock
	input               rst,    // asynchronous reset low active 
	input               enb,    // Enable
	input               l_s,    // load or shift
	input [7:0]	    piso_input,    // Parallel data input
	output              piso_out     // Serial output
);

reg [7:0] register_r;

always @(posedge clk) begin
	if(!rst)
		register_r <= 8'h00;
	else if(enb)
		if(l_s)
			register_r <= piso_input;
		else
			register_r <= {register_r[0], register_r[7:1]};		
end

assign piso_out = register_r[0];

endmodule
