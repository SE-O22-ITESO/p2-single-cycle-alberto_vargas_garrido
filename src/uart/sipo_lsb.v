module sipo_lsb (
input               clk,//clock
input               rst,//asynchronous reset low active 
input               enb,//enable
input		    clear,
input               inp,//serial data input
output  [7:0]  out //parallel data output
);

reg[7:0]    rgstr_r; //temporal register

always@(posedge clk or negedge rst) begin
    if(!rst)
        rgstr_r  <= 8'b00000000;
    else begin
    	if (enb)
        	rgstr_r  <= {inp, rgstr_r[7:1]};//shift the data
        else if(clear)
        	rgstr_r  <= 8'b00000000;
    end
end

assign out  = rgstr_r;

endmodule
