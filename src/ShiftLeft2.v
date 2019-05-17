module ShiftLeft2(w_SignExtend1632, w_ShiftLeft2);

input [31:0] w_SignExtend1632;
output reg[31:0] w_ShiftLeft2;


always @(*)
begin
    w_ShiftLeft2[31:0] <= w_SignExtend1632[31:0] << 2'b00;
end

endmodule