
module muxregisterfile
#(
	parameter n=32
)
(
	input [4:0] selector,

	input [n-1:0] data_0,
	input [n-1:0] data_1,
	input [n-1:0] data_2,
	input [n-1:0] data_3,
	input [n-1:0] data_4,
	input [n-1:0] data_5,
	input [n-1:0] data_6,
	input [n-1:0] data_7,
	input [n-1:0] data_8,
	input [n-1:0] data_9,
	input [n-1:0] data_10,
	input [n-1:0] data_11,
	input [n-1:0] data_12,
	input [n-1:0] data_13,
	input [n-1:0] data_14,
	input [n-1:0] data_15,
	input [n-1:0] data_16,
	input [n-1:0] data_17,
	input [n-1:0] data_18,
	input [n-1:0] data_19,
	input [n-1:0] data_20,
	input [n-1:0] data_21,
	input [n-1:0] data_22,
	input [n-1:0] data_23,
	input [n-1:0] data_24,
	input [n-1:0] data_25,
	input [n-1:0] data_26,
	input [n-1:0] data_27,
	input [n-1:0] data_28,
	input [n-1:0] data_29,
	input [n-1:0] data_30,
	input [n-1:0] data_31,
	
	output reg [n-1:0] mux_output
	
);

always@(*)begin
	case(selector)
		0: mux_output = data_0;
		1: mux_output = data_1;
		2: mux_output = data_2;
		3: mux_output = data_3;
		4: mux_output = data_4;
		5: mux_output = data_5;
		6: mux_output = data_6;
		7: mux_output = data_7;
		8: mux_output = data_8;
		9: mux_output = data_9;
		10: mux_output = data_10;
		11: mux_output = data_11;
		12: mux_output = data_12;
		13: mux_output = data_13;
		14: mux_output = data_14;
		15: mux_output = data_15;
		16: mux_output = data_16;
		17: mux_output = data_17;
		18: mux_output = data_18;
		19: mux_output = data_19;
		20: mux_output = data_20;
		21: mux_output = data_21;
		22: mux_output = data_22;
		23: mux_output = data_23;
		24: mux_output = data_24;
		25: mux_output = data_25;
		26: mux_output = data_26;
		27: mux_output = data_27;
		28: mux_output = data_28;
		29: mux_output = data_29;
		30: mux_output = data_30;
		31: mux_output = data_31;
	endcase
end

endmodule
//muxregfile



