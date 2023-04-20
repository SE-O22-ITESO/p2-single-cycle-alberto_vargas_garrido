module hazardinit
(
    input in_idex_memread,
    input [4:0] in_ifid_rs1,
    input [4:0] in_ifid_rs2,
    input [4:0] in_idex_rd,

    output reg pcwrite,
    output reg ifidwrite,
    output reg controlsel
);

always @(*) begin
    if(
        in_idex_memread
        && ((in_idex_rd == in_ifid_rs1 
        || in_idex_rd == in_ifid_rs2))
    )begin
        pcwrite = 1'b0;
        ifidwrite = 1'b0;
        controlsel = 1'b1;
    end 
    else begin
        pcwrite = 1'b1;
        ifidwrite = 1'b1;
        controlsel = 1'b0;
    end
end

endmodule