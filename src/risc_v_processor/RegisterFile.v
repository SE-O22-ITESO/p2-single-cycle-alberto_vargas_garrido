/******************************************************************
* description
*	this is  module represents the register file where the registers 
*	like $s0-$s7 are store. 
*	of mips processor.
* version:
*	1.0
* author:
*	dr. josé luis pizano escalante
* email:
*	luispizano@iteso.mx
* date:
*	01/03/2014
******************************************************************/
module registerfile
#(
	parameter n=32
)
(
	input clk,
	input reset,
	input regwrite,
	input [4:0] writeregister,
	input [4:0] readregister1,
	input [4:0] readregister2,
	input  [31:0] writedata,
	
	output [31:0] readdata1,
	output [31:0] readdata2

);


wire [32*n-1:0]intercnection_wire;
wire [31:0] selectregister_wire;


decoderregisterfile
decoder
(
	.writeregister(writeregister),
	.selectregister(selectregister_wire)
);

/****************************************************************/
/****************************************************************/
/****************************************************************/
/****************************************************************/
/****************************************************************/

register
register_zero
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[0]&regwrite),
	.datainput(0),
	.dataoutput(intercnection_wire[n-1:0])
);


	
	
	
register
register_ra
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[1]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[2*n-1:1*n])
);	
	

	
register_sp
register_sp
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[2]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[3*n-1:2*n])
);	


register
register_gp
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[3]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[4*n-1:3*n])
);		
	


register
register_tp
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[4]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[5*n-1:4*n])
);



register
register_t0
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[5]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[6*n-1:5*n])
);



register
register_t1
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[6]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[7*n-1:6*n])
);




register
register_t2
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[7]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[8*n-1:7*n])
);



register
register_s0
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[8]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[9*n-1:8*n])
);



register
register_s1
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[9]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[10*n-1:9*n])
);



register
register_a0
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[10]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[11*n-1:10*n])
);



register
register_a1
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[11]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[12*n-1:11*n])
);



register
register_a2
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[12]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[13*n-1:12*n])
);



register
register_a3
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[13]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[14*n-1:13*n])
);



register
register_a4
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[14]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[15*n-1:14*n])
);



register
register_a5
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[15]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[16*n-1:15*n])
);


register
register_a6
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[16]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[17*n-1:16*n])
);



register
register_a7
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[17]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[18*n-1:17*n])
);



register
register_s2
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[18]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[19*n-1:18*n])
);



register
register_s3
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[19]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[20*n-1:19*n])
);




register
register_s4
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[20]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[21*n-1:20*n])
);




register
register_s5
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[21]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[22*n-1:21*n])
);




register
register_s6
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[22]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[23*n-1:22*n])
);




register
register_s7
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[23]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[24*n-1:23*n])
);



register
register_s8
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[24]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[25*n-1:24*n])
);

register
register_s9
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[25]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[26*n-1:25*n])
);



register
register_s10
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[26]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[27*n-1:26*n])
);
	


register
register_s11
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[27]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[28*n-1:27*n])
);	



register
register_t3
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[28]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[29*n-1:28*n])
);


register
register_t4
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[29]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[30*n-1:29*n])
);




register
register_t5
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[30]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[31*n-1:30*n])
);



register
register_t6
(
	.clk(clk),
	.reset(reset),
	.enable(selectregister_wire[31]&regwrite),
	.datainput(writedata),
	.dataoutput(intercnection_wire[32*n-1:31*n])
);




muxregisterfile
#(
	.n(32)
)
muxregister1
(
	.selector(readregister1),

	.data_0(intercnection_wire[1*n-1:0*n]),
	.data_1(intercnection_wire[2*n-1:1*n]),
	.data_2(intercnection_wire[3*n-1:2*n]),
	.data_3(intercnection_wire[4*n-1:3*n]),
	.data_4(intercnection_wire[5*n-1:4*n]),
	.data_5(intercnection_wire[6*n-1:5*n]),
	.data_6(intercnection_wire[7*n-1:6*n]),
	.data_7(intercnection_wire[8*n-1:7*n]),
	.data_8(intercnection_wire[9*n-1:8*n]),
   .data_9(intercnection_wire[10*n-1:9*n]),
	.data_10(intercnection_wire[11*n-1:10*n]),
	.data_11(intercnection_wire[12*n-1:11*n]),
	.data_12(intercnection_wire[13*n-1:12*n]),
	.data_13(intercnection_wire[14*n-1:13*n]),
	.data_14(intercnection_wire[15*n-1:14*n]),
	.data_15(intercnection_wire[16*n-1:15*n]),
	.data_16(intercnection_wire[17*n-1:16*n]),
	.data_17(intercnection_wire[18*n-1:17*n]),
	.data_18(intercnection_wire[19*n-1:18*n]),
	.data_19(intercnection_wire[20*n-1:19*n]),
	.data_20(intercnection_wire[21*n-1:20*n]),
	.data_21(intercnection_wire[22*n-1:21*n]),
	.data_22(intercnection_wire[23*n-1:22*n]),
	.data_23(intercnection_wire[24*n-1:23*n]),
	.data_24(intercnection_wire[25*n-1:24*n]),
	.data_25(intercnection_wire[26*n-1:25*n]),
	.data_26(intercnection_wire[27*n-1:26*n]),
	.data_27(intercnection_wire[28*n-1:27*n]),
	.data_28(intercnection_wire[29*n-1:28*n]),
	.data_29(intercnection_wire[30*n-1:29*n]),
	.data_30(intercnection_wire[31*n-1:30*n]),
	.data_31(intercnection_wire[32*n-1:31*n]),
	
	.mux_output(readdata1)
);


muxregisterfile
#(
	.n(32)
)
muxregister2
(
	.selector(readregister2),

		.data_0(intercnection_wire[1*n-1:0*n]),
	.data_1(intercnection_wire[2*n-1:1*n]),
	.data_2(intercnection_wire[3*n-1:2*n]),
	.data_3(intercnection_wire[4*n-1:3*n]),
	.data_4(intercnection_wire[5*n-1:4*n]),
	.data_5(intercnection_wire[6*n-1:5*n]),
	.data_6(intercnection_wire[7*n-1:6*n]),
	.data_7(intercnection_wire[8*n-1:7*n]),
	.data_8(intercnection_wire[9*n-1:8*n]),
   .data_9(intercnection_wire[10*n-1:9*n]),
	.data_10(intercnection_wire[11*n-1:10*n]),
	.data_11(intercnection_wire[12*n-1:11*n]),
	.data_12(intercnection_wire[13*n-1:12*n]),
	.data_13(intercnection_wire[14*n-1:13*n]),
	.data_14(intercnection_wire[15*n-1:14*n]),
	.data_15(intercnection_wire[16*n-1:15*n]),
	.data_16(intercnection_wire[17*n-1:16*n]),
	.data_17(intercnection_wire[18*n-1:17*n]),
	.data_18(intercnection_wire[19*n-1:18*n]),
	.data_19(intercnection_wire[20*n-1:19*n]),
	.data_20(intercnection_wire[21*n-1:20*n]),
	.data_21(intercnection_wire[22*n-1:21*n]),
	.data_22(intercnection_wire[23*n-1:22*n]),
	.data_23(intercnection_wire[24*n-1:23*n]),
	.data_24(intercnection_wire[25*n-1:24*n]),
	.data_25(intercnection_wire[26*n-1:25*n]),
	.data_26(intercnection_wire[27*n-1:26*n]),
	.data_27(intercnection_wire[28*n-1:27*n]),
	.data_28(intercnection_wire[29*n-1:28*n]),
	.data_29(intercnection_wire[30*n-1:29*n]),
	.data_30(intercnection_wire[31*n-1:30*n]),
	.data_31(intercnection_wire[32*n-1:31*n]),
	
	.mux_output(readdata2)
);
endmodule
//regfile
