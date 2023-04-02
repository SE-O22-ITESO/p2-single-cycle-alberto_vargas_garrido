/******************************************************************
* description
*	this module performes a sign-extend operation that is need with
*	in instruction like andi or ben.
* version:
*	1.0
* author:
*	dr. josé luis pizano escalante
* email:
*	luispizano@iteso.mx
* date:
*	01/03/2014
******************************************************************/
module signextend
(   
	input [31:0]  datainput,
	input [2:0]   select,
	output[31:0]  signextendoutput
);

localparam i_type_imm = 3'h0;
localparam s_type_imm = 3'h1;
localparam b_type_imm = 3'h2;
localparam u_type_imm = 3'h3;
localparam j_type_imm = 3'h4;

reg [31:0] signextendresult;

always@(select, datainput) begin
   casex(select)
      i_type_imm: begin
         signextendresult = {
            datainput[31], datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31], datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31], datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31], datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31:20]
         };
      end
      s_type_imm: begin
         signextendresult = {
            datainput[31], datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31], datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31], datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31], datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31:25], datainput[11:7]
         };
      end
      b_type_imm: begin
         signextendresult = {
            datainput[31], datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31], datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31], datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31], datainput[7], datainput[30:25], datainput[11:8], 1'b0
         };
      end
      u_type_imm: begin
         signextendresult = {
            datainput[31:12], 12'b000000000000
         };
      end
      j_type_imm: begin
         signextendresult = {
            datainput[31], datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31], datainput[31], datainput[31], datainput[31], datainput[31],
            datainput[31],
            datainput[31], datainput[19:12], datainput[20], datainput[30:21], 1'b0
         };
      end
		default: signextendresult = 32'h0000;
   endcase
end

assign  signextendoutput = signextendresult;

endmodule 
// signextend
