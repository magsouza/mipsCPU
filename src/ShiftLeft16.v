module ShiftLeft16(w_rd, w_ShiftLeft16);

input [15:0] w_rd;
output reg[31:0] w_ShiftLeft16;


always @(*)
begin
    w_ShiftLeft16[31:0] <= w_rd[15:0] << 16'b0000000000000000;
end

endmodule