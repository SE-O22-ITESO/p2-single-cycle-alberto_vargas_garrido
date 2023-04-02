module memory_x_control
#(
    parameter memmory_depth = 32
)
(
    input in_write_en,
    input [memmory_depth-1:0] address,

    output reg[2:0] out_write_en,
    output reg[1:0] address_sel,
    output reg[1:0] data_sel
);

always@(address, in_write_en) begin
    if((address >= 'h00400000) && (address < 'h10000000)) begin
        data_sel = 2'h0;
        address_sel = 2'h0;
        out_write_en = 3'b000;
	end
    else if((address <= 'h7fffeffc) && (address > 'h10011000)) begin
        data_sel = 2'h1;
        address_sel = 2'h1;
        if(in_write_en)
            out_write_en = 3'b001;
        else
            out_write_en = 3'b000;
    end
    else if(address == 'h10010024) begin
        data_sel = 2'h0;
        address_sel = 2'h0;
        out_write_en = 3'b010;
    end
    else if(address == 'h10010028) begin
        data_sel = 2'h2;
        address_sel = 2'h0;
        out_write_en = 3'b000;
    end
    else if(address == 'h1001002C) begin // rx uart
        data_sel = 2'h3;
        address_sel = 2'h0;
        out_write_en = 3'b000;
    end
    else if(address == 'h10010030) begin // tx uart
        data_sel = 2'h0;
        address_sel = 2'h0;
        out_write_en = 3'b100;
    end
    else begin
        data_sel = 2'h0;
        address_sel = 2'h0;
        out_write_en = 3'b000;
    end
end

endmodule
