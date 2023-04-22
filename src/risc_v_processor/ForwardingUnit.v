module forwardingunit
(
    input in_exmem_regwrite,
    input in_memwb_regwrite,
    input in_memeread,
    input in_memwrite,
    input [6:0] in_idex_upcode,
    input [4:0] in_idex_rs1,
    input [4:0] in_idex_rs2,
    input [4:0] in_exmem_rd,
    input [4:0] in_memwb_rd,

    output reg[1:0] out_forwarda_sel,
    output reg[1:0] out_forwardb_sel
);

always @(*) begin
    if(
        in_exmem_regwrite
        && (in_exmem_rd != 0)
        && (in_exmem_rd == in_idex_rs1)
    ) begin
        out_forwarda_sel = 2'b10;
    end
    else if(
        in_memwb_regwrite
        && (in_memwb_rd != 0)
        && !(in_exmem_regwrite && (in_exmem_rd != 0)
        && (in_exmem_rd == in_idex_rs1))
        && (in_memwb_rd == in_idex_rs1)
    ) begin
        out_forwarda_sel = 2'b01;
    end
    else begin
        out_forwarda_sel = 2'b00;
    end

    if(
        (in_idex_upcode != 7'b0010011)
        && (!in_memwrite)
        && in_exmem_regwrite
        && (in_exmem_rd != 0)
        && (in_exmem_rd == in_idex_rs2)
    ) begin
        out_forwardb_sel = 2'b10;
    end
    else if(
        (in_idex_upcode != 7'b0010011) 
        && in_memwb_regwrite
        && (!in_memeread)
        && (in_memwb_rd != 0)
        && !(in_exmem_regwrite && (in_exmem_rd != 0)
        && (in_exmem_rd == in_idex_rs2))
        && (in_memwb_rd == in_idex_rs2)
    ) begin
        out_forwardb_sel = 2'b01;
    end
    else begin
        out_forwardb_sel = 2'b00;
    end

end

endmodule