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
	output[31:0]  signextendoutput
);

reg [2:0] select;

localparam i_type_imm = 3'h0;
localparam s_type_imm = 3'h1;
localparam b_type_imm = 3'h2;
localparam u_type_imm = 3'h3;
localparam j_type_imm = 3'h4;

reg [31:0] signextendresult;

always@(*) begin
   case(datainput[6:0])
      7'b0010011: select = i_type_imm;
      7'b0000011: select = i_type_imm;
      7'b1100111: select = i_type_imm;
      7'b0100011: select = s_type_imm;
      7'b1100011: select = b_type_imm;
      7'b0110111: select = u_type_imm;
      7'b0010111: select = u_type_imm;
      7'b1101111: select = j_type_imm;
		default: select = 3'b111;
   endcase
end

always@(*) begin
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
