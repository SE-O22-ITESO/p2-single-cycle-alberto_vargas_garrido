/******************************************************************
* description
*	this is the top-level of a mips processor
* this processor is written verilog-hdl. also, it is synthesizable into hardware.
* parameter memory_depth configures the program memory to allocate the program to
* be execute. if the size of the program changes, thus, memory_depth must change.
* this processor was made for computer organization class at iteso.
******************************************************************/

//******************************************************************/
//******top module**************************************************/
module RISC_V_processor
#(
	parameter memory_depth = 64 //if the size of the program changes, thus, memory_depth must change.
	// 92 es el numero de palabras en el archivo text.dat generado por mips.
	// Este es el numero de palabras de 32 bits en el que se traduce nuestro programa hanoi.asm por MARS
	// y se guarda en la memoria ROM (memoria del programa).
)(
	input clk,
	input reset,
	input [31:0] intruction,
	input [31:0] received_data,

	output memwrite,
	output memread,
	output [31:0] data_address,
	output [31:0] writedata,
	output [31:0] pc_address
	//output [31:0] aluresultout
);

wire clk_wire = clk;
//******wire decl.**************************************************/
// Se agregaron por separado señales de control para las instrucciones branch.
// Esto a fin de poderlas utilizar en conjunto con una compuerta AND con el valor zero
// de alu. Es necesario separarlas pues una ha de activarse con zero = 1 (BNE R[rs] != R[rt]), 
// mientras que la otra depende de zero = 0 (BEQ, pues ambos parametros eran R[rs] == R[rt]).
// Dichas compuestas se declaran en el selector de 1 MUX especializado (MUX PC1 - BRANCH) 
// para decidir el PC new value dependiendo de si procede o no una instruccion Branch.
wire branchne_wire;
wire brancheq_wire;
wire branchlt_wire;
wire branchge_wire;
//-------------------

wire regwrite_wire;
wire memwrite_wire;

wire [31:0] ifid_intruction_wire;

wire [31:0] branch_pc_mux_wire;

wire [31:0 ]immediateextend_wire;

wire [31:0] pc_wire;
wire [31:0] ifid_pc_wire;

wire [31:0] reg_instruction_wire;
wire [31:0] adder_pcimm_wire;

wire [31:0] readdata1_wire;
wire [31:0] readdata2_wire;

wire [31:0] aluresult_wire;

wire [31:0] aluout_mux_wire;

wire [31:0] a_mux_wire;
wire [31:0] b_mux_wire;

wire [3:0] aluop_wire;

wire [3:0] alu_control_wire;

wire [31:0] alu_pc_mux_wire;

wire [31:0] address_mux_wire;
wire address_sel_wire;

wire [1:0]memtoreg_wire;

wire alu_pc_sel_wire;

wire jal_wire;

wire a_alusrc_wire;
wire [1:0] b_alusrc_wire;

wire memread_wire;

wire zero_wire;
wire alessb_wire;

wire [31:0] adder_pc_wire;

////Forward////
wire [31:0] idex_forwardwd_mux_wire;
wire [31:0] forwarda_mux_wire;
wire [31:0] forwardb_mux_wire;
wire [31:0] forwardwd_mux_wire;
wire [1:0] out_forwardwd_sel_wire;

////Hazard////
wire ifid_clear_wire;
wire idex_clear_wire;
wire exmem_clear_wire;
wire hazard_pcwrite_wire;
wire hazard_ifidwrite_wire;
wire hazard_controlsel_wire;
wire [18:0] control_mux_wire;
wire [1:0] out_forwarda_sel_wire;
wire [1:0] out_forwardb_sel_wire;

////Pipelines wires////
wire [31:0] ifid_adder_pc_wire;

wire [31:0] idex_adder_pc_wire;
wire idex_address_sel_wire;
wire idex_jal_wire;
wire idex_alu_pc_sel_wire;
wire idex_brancheq_wire;
wire idex_branchne_wire;
wire idex_branchlt_wire;
wire idex_branchge_wire;
wire idex_a_alusrc_wire;
wire [1:0] idex_b_alusrc_wire;
wire [1:0] idex_memtoreg_wire;
wire idex_regwrite_wire;
wire idex_memread_wire;
wire idex_memwrite_wire;
wire [3:0] idex_aluop_wire;
wire [31:0] idex_pc_wire;
wire [31:0] idex_readdata1_wire; 
wire [31:0] idex_readdata2_wire; 
wire [31:0] idex_immediateextend_wire;
wire [31:0] idex_intruction_wire;

wire [4:0] exmem_intruction_wire; //5
wire [31:0] exmem_adder_pcimm_wire; //32
wire exmem_zero_wire; //1
wire exmem_alessb_wire; //1
wire [31:0] exmem_readdata2_wire; //32
wire [31:0] exmem_aluresult_wire; //32
wire exmem_memread_wire; //1
wire exmem_memwrite_wire; //1
wire exmem_brancheq_wire; //1
wire exmem_branchne_wire; //1
wire exmem_branchlt_wire; //1
wire exmem_branchge_wire; //1
wire exmem_jal_wire; //1
wire exmem_alu_pc_sel_wire; //1
wire [31:0] exmem_adder_pc_wire; //1
wire exmem_address_sel_wire;
wire [1:0] exmem_memtoreg_wire;
wire exmem_regwrite_wire;
//wire [31:0] exmem_adder_pc_wire;

wire [4:0] memwb_intruction_wire; //5
wire [31:0] memwb_received_data; //32
wire [31:0] memwb_aluresult_wire; //32
wire memewb_regwrite_wire; //1
wire [1:0] memewb_memtoreg_wire; //2
wire [31:0] memwb_adder_pc_wire;
//******************************************************************/
//******control units***********************************************/
control
controlunit
(
	// input
	.op(ifid_intruction_wire[6:0]),
	.func3(ifid_intruction_wire[14:12]),
	// Para identificar las instrucciones JR, asi como para activar offset cuando ocurre SW y LW
	// no basta con el codigo de operacion, pues las instrucciones R por ejemplo no se diferencian por opcode (todas 00).
	// Sino que se utiliza func en descripciones de compuertas logicas para tener el control correcto de dichas señales.
	
	// output
	.address_sel(address_sel_wire),
	.jal(jal_wire),
	.alu_pc_sel(alu_pc_sel_wire),
	.beq_out(brancheq_wire),
	.bne_out(branchne_wire),
	.blt_out(branchlt_wire),
	.bge_out(branchge_wire),
	.a_alusrc(a_alusrc_wire),
	.b_alusrc(b_alusrc_wire),
	.memtoreg(memtoreg_wire),
	.regwrite(regwrite_wire),
	.memread(memread_wire),
	.memwrite(memwrite_wire),
	.aluop(aluop_wire)
);

alucontrol
alu_control
(
	.aluop(idex_aluop_wire),
	.func3(idex_intruction_wire[14:12]),
	.func7(idex_intruction_wire[31:25]),
	
	.aluoperation(alu_control_wire)

);

//******************************************************************/
//******multiplexer*************************************************/

multiplexer2to1
#(
	.nbits(32)
)
branch_pc_mux
(
	.selector(
		((exmem_zero_wire & (exmem_brancheq_wire | exmem_branchge_wire)) |
		(~exmem_zero_wire & exmem_branchne_wire) |
		(exmem_alessb_wire & exmem_branchlt_wire) |
		(~exmem_alessb_wire & exmem_branchge_wire)) |
		exmem_jal_wire
	),
	.mux_data0(adder_pc_wire),
	.mux_data1(exmem_adder_pcimm_wire),
	
	.mux_output(branch_pc_mux_wire)

);

multiplexer2to1
#(
	.nbits(32)
)
alu_pc_mux
(
	.selector(exmem_alu_pc_sel_wire),
	.mux_data0(branch_pc_mux_wire),
	.mux_data1(exmem_aluresult_wire),
	
	.mux_output(alu_pc_mux_wire)

);

multiplexer2to1
#(
	.nbits(32)
)
a_mux
(
	.selector(idex_a_alusrc_wire),
	.mux_data0(idex_readdata1_wire),
	.mux_data1(32'h00000000),
	
	.mux_output(a_mux_wire)

);

multiplexer4to1
#(
	.nbits(32)
)
b_mux
(
	.selector(idex_b_alusrc_wire),
	.mux_data0(idex_readdata2_wire),
	.mux_data1(idex_immediateextend_wire),
	.mux_data2(adder_pcimm_wire),
	.mux_data3(),

	.mux_output(b_mux_wire)

);

multiplexer4to1
#(
	.nbits(32)
)
aluout_mux
(
	.selector(memewb_memtoreg_wire),
	.mux_data0(memwb_aluresult_wire),
	.mux_data1(memwb_received_data),
	.mux_data2(memwb_adder_pc_wire),
	.mux_data3(),
	
	.mux_output(aluout_mux_wire)

);

multiplexer2to1
#(
	.nbits(32)
)
address_mux
(
	.selector(exmem_address_sel_wire),
	.mux_data0(32'h00000000),
	.mux_data1(exmem_aluresult_wire),
	
	.mux_output(address_mux_wire)

);

multiplexer4to1
#(
	.nbits(32)
)
forwarda_mux
(
	.selector(out_forwarda_sel_wire),
	.mux_data0(a_mux_wire),
	.mux_data1(aluout_mux_wire),
	.mux_data2(exmem_aluresult_wire),
	.mux_data3(),
	
	.mux_output(forwarda_mux_wire)

);

multiplexer4to1
#(
	.nbits(32)
)
forwardb_mux
(
	.selector(out_forwardb_sel_wire),
	.mux_data0(b_mux_wire),
	.mux_data1(aluout_mux_wire),
	.mux_data2(exmem_aluresult_wire),
	.mux_data3(),
	
	.mux_output(forwardb_mux_wire)

);

multiplexer4to1
#(
	.nbits(32)
)
forwardwd_mux
(
	.selector(out_forwardwd_sel_wire),
	.mux_data0(idex_readdata2_wire),
	.mux_data1(aluout_mux_wire),
	.mux_data2(exmem_aluresult_wire),
	.mux_data3(),
	
	.mux_output(forwardwd_mux_wire)

);

multiplexer2to1
#(
	.nbits(19)
)
control_mux
(
	.selector(hazard_controlsel_wire),
	.mux_data0({
		address_sel_wire,
		jal_wire,
		alu_pc_sel_wire,
		brancheq_wire,
		branchne_wire,
		branchlt_wire,
		branchge_wire,
		a_alusrc_wire,
		b_alusrc_wire,
		memtoreg_wire,
		regwrite_wire,
		memread_wire,
		memwrite_wire,
		aluop_wire
	}),
	.mux_data1(19'h00000),
	
	.mux_output(control_mux_wire)

);

//******************************************************************/
//******registers****************************************************/
pc_register
#(
	.n(32)
)
pc
(
	.clk(clk_wire),
	.reset(reset),
	.enable(hazard_pcwrite_wire),
	.newpc(alu_pc_mux_wire),
	
	
	.pcvalue(pc_wire)
);

registerfile
register_file
(
	.clk(clk_wire),
	.reset(reset),
	.regwrite(memewb_regwrite_wire),
	.writeregister(memwb_intruction_wire),
	.readregister1(ifid_intruction_wire[19:15]),
	.readregister2(ifid_intruction_wire[24:20]),
	.writedata(aluout_mux_wire),
	
	.readdata1(readdata1_wire),
	.readdata2(readdata2_wire)

);
//******************************************************************/
//******pipeline*******************************************************/

registerpipeline
#(
	.n(64+32)
)
pipeline_ifid
(
	.clk(clk_wire),
	.reset(reset),
	.enable(hazard_ifidwrite_wire),
    .clear(ifid_clear_wire),
	.datainput({adder_pc_wire, pc_wire, intruction}),
	
	.dataoutput({ifid_adder_pc_wire, ifid_pc_wire, ifid_intruction_wire})
);

registerpipeline
#(
	.n(179+32+32)
)
pipeline_idex
(
	.clk(clk_wire),
	.reset(reset),
	.enable(1'b1),
    .clear(idex_clear_wire),
	.datainput({
		ifid_adder_pc_wire,
		control_mux_wire,
		ifid_pc_wire,
		readdata1_wire, 
		readdata2_wire, 
		immediateextend_wire,
		ifid_intruction_wire,
		forwardwd_mux_wire
	}),
	
	.dataoutput({
		idex_adder_pc_wire,
		idex_address_sel_wire,
		idex_jal_wire,
		idex_alu_pc_sel_wire,
		idex_brancheq_wire,
		idex_branchne_wire,
		idex_branchlt_wire,
		idex_branchge_wire,
		idex_a_alusrc_wire,
		idex_b_alusrc_wire,
		idex_memtoreg_wire,
		idex_regwrite_wire,
		idex_memread_wire,
		idex_memwrite_wire,
		idex_aluop_wire,
		idex_pc_wire,
		idex_readdata1_wire, 
		idex_readdata2_wire, 
		idex_immediateextend_wire,
		idex_intruction_wire,
		idex_forwardwd_mux_wire
	})
);

registerpipeline
#(
	.n(115)
)
pipeline_exmem
(
	.clk(clk_wire),
	.reset(reset),
	.enable(1'b1),
    .clear(exmem_clear_wire),
	.datainput({
		idex_adder_pc_wire,
		idex_memread_wire,
		idex_memwrite_wire,
		idex_address_sel_wire,
		idex_memtoreg_wire,
		idex_alu_pc_sel_wire,
		idex_regwrite_wire,
		idex_jal_wire,
		idex_brancheq_wire,
		idex_branchne_wire,
		idex_branchlt_wire,
		idex_branchge_wire,
		adder_pcimm_wire, 
		zero_wire, 
		alessb_wire, 
		aluresult_wire,
		//idex_readdata2_wire,
		idex_intruction_wire[11:7]
	}),
	
	.dataoutput({
		exmem_adder_pc_wire,
		exmem_memread_wire,
		exmem_memwrite_wire,
		exmem_address_sel_wire,
		exmem_memtoreg_wire,
		exmem_alu_pc_sel_wire,
		exmem_regwrite_wire,
		exmem_jal_wire,
		exmem_brancheq_wire,
		exmem_branchne_wire,
		exmem_branchlt_wire,
		exmem_branchge_wire,
		exmem_adder_pcimm_wire, 
		exmem_zero_wire, 
		exmem_alessb_wire, 
		exmem_aluresult_wire,
		//exmem_readdata2_wire, 
		exmem_intruction_wire
	})
);

registerpipeline
#(
	.n(72+32)
)
pipeline_memwb
(
	.clk(clk_wire),
	.reset(reset),
	.enable(1'b1),
    .clear(1'b0),
	.datainput({
		exmem_adder_pc_wire,
		exmem_memtoreg_wire, 
		exmem_regwrite_wire, 
		received_data, 
		exmem_aluresult_wire, 
		exmem_intruction_wire
	}),
	
	.dataoutput({
		memwb_adder_pc_wire,
		memewb_memtoreg_wire, 
		memewb_regwrite_wire ,
		memwb_received_data, 
		memwb_aluresult_wire, 
		memwb_intruction_wire})
);

//******************************************************************/
//******hazard******************************************************/

hazardinit
hazard
(
    .in_idex_memread(idex_memread_wire),
	.in_branch_jal(
		((exmem_zero_wire & (exmem_brancheq_wire | exmem_branchge_wire)) |
		(~exmem_zero_wire & exmem_branchne_wire) |
		(exmem_alessb_wire & exmem_branchlt_wire) |
		(~exmem_alessb_wire & exmem_branchge_wire)) |
		exmem_jal_wire
	),
    .in_ifid_rs1(ifid_intruction_wire[19:15]),
    .in_ifid_rs2(ifid_intruction_wire[24:20]),
    .in_idex_rd(ifid_intruction_wire[11:7]),

    .pcwrite(hazard_pcwrite_wire),
    .ifidwrite(hazard_ifidwrite_wire),
    .controlsel(hazard_controlsel_wire),
	.ifid_clear(ifid_clear_wire),
    .idex_clear(idex_clear_wire),
    .exmem_clear(exmem_clear_wire)
);

//******************************************************************/
//******forwarding**************************************************/

forwardingunit
forwarding
(
    .in_exmem_regwrite(exmem_regwrite_wire),
    .in_memwb_regwrite(memewb_regwrite_wire),
	.in_memeread(idex_memread_wire),
	.in_memwrite(idex_memwrite_wire),
	.in_idex_upcode(idex_intruction_wire[6:0]),
    .in_idex_rs1(idex_intruction_wire[19:15]),
    .in_idex_rs2(idex_intruction_wire[24:20]),
    .in_exmem_rd(exmem_intruction_wire),
    .in_memwb_rd(memwb_intruction_wire),

    .out_forwarda_sel(out_forwarda_sel_wire),
    .out_forwardb_sel(out_forwardb_sel_wire),
	.out_forwardwd_sel(out_forwardwd_sel_wire)
);

//******************************************************************/
//******extend******************************************************/
signextend
signextendforconstants
(   
	.datainput(ifid_intruction_wire),
	.signextendoutput(immediateextend_wire)
);


//******************************************************************/
//******alu*********************************************************/

adder32bits
#(
	.nbits(32)
)
adder_pc
(
	.data0(pc_wire),
	.data1(32'h4),
	
	.result(adder_pc_wire)
);

adder32bits
#(
	.nbits(32)
)
adder_pcimm
(
	.data0(idex_pc_wire),
	.data1(idex_immediateextend_wire),
	
	.result(adder_pcimm_wire)
);

alu
arithmeticlogicunit 
(
	.aluoperation(alu_control_wire),
	.a(forwarda_mux_wire),
	.b(forwardb_mux_wire),
	
	.zero(zero_wire),
	.alessb(alessb_wire),
	.aluresult(aluresult_wire)
);

//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//*assign section***************************************************/

assign memread = exmem_memread_wire;
assign memwrite = exmem_memwrite_wire;
assign writedata = idex_forwardwd_mux_wire;
assign pc_address = pc_wire;
assign data_address = address_mux_wire;

endmodule
