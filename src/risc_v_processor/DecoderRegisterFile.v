/******************************************************************
* description
*	this a decoder used in the register file.
*	1.0
* author:
*	dr. josé luis pizano escalante
* email:
*	luispizano@iteso.mx
* date:
*	01/03/2014
******************************************************************/
module decoderregisterfile
(
	input [4:0] writeregister,
	output [31:0] selectregister
);
reg [31:0] selectregister_reg;

always@(*)begin
	case(writeregister)
		0:   selectregister_reg = 32'b0000_0000_0000_0000_0000_0000_0000_0001;
		1:	  selectregister_reg = 32'b0000_0000_0000_0000_0000_0000_0000_0010;
		2:	  selectregister_reg = 32'b0000_0000_0000_0000_0000_0000_0000_0100;
		3:	  selectregister_reg = 32'b0000_0000_0000_0000_0000_0000_0000_1000;
		4:	  selectregister_reg = 32'b0000_0000_0000_0000_0000_0000_0001_0000;		
		5:	  selectregister_reg = 32'b0000_0000_0000_0000_0000_0000_0010_0000;
		6:	  selectregister_reg = 32'b0000_0000_0000_0000_0000_0000_0100_0000;
		7:	  selectregister_reg = 32'b0000_0000_0000_0000_0000_0000_1000_0000;
		8:	  selectregister_reg = 32'b0000_0000_0000_0000_0000_0001_0000_0000;
		9:	  selectregister_reg = 32'b0000_0000_0000_0000_0000_0010_0000_0000;
		10:  selectregister_reg = 32'b0000_0000_0000_0000_0000_0100_0000_0000;
		11:  selectregister_reg = 32'b0000_0000_0000_0000_0000_1000_0000_0000;
		12:  selectregister_reg = 32'b0000_0000_0000_0000_0001_0000_0000_0000;
		13:  selectregister_reg = 32'b0000_0000_0000_0000_0010_0000_0000_0000;
		14:  selectregister_reg = 32'b0000_0000_0000_0000_0100_0000_0000_0000;
		15:  selectregister_reg = 32'b0000_0000_0000_0000_1000_0000_0000_0000;
		16:  selectregister_reg = 32'b0000_0000_0000_0001_0000_0000_0000_0000;
		17:  selectregister_reg = 32'b0000_0000_0000_0010_0000_0000_0000_0000;
		18:  selectregister_reg = 32'b0000_0000_0000_0100_0000_0000_0000_0000;
		19:  selectregister_reg = 32'b0000_0000_0000_1000_0000_0000_0000_0000;
		20:  selectregister_reg = 32'b0000_0000_0001_0000_0000_0000_0000_0000;
		21:  selectregister_reg = 32'b0000_0000_0010_0000_0000_0000_0000_0000;		
		22:  selectregister_reg = 32'b0000_0000_0100_0000_0000_0000_0000_0000;
		23:  selectregister_reg = 32'b0000_0000_1000_0000_0000_0000_0000_0000;
		24:  selectregister_reg = 32'b0000_0001_0000_0000_0000_0000_0000_0000;
		25:  selectregister_reg = 32'b0000_0010_0000_0000_0000_0000_0000_0000;
		26:  selectregister_reg = 32'b0000_0100_0000_0000_0000_0000_0000_0000;
		27:  selectregister_reg = 32'b0000_1000_0000_0000_0000_0000_0000_0000;
		28:  selectregister_reg = 32'b0001_0000_0000_0000_0000_0000_0000_0000;
		29:  selectregister_reg = 32'b0010_0000_0000_0000_0000_0000_0000_0000;
		30:  selectregister_reg = 32'b0100_0000_0000_0000_0000_0000_0000_0000;
		31:  selectregister_reg = 32'b1000_0000_0000_0000_0000_0000_0000_0000;
	endcase
end

assign selectregister = selectregister_reg;

endmodule
//decoderregisterfile