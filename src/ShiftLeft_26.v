module ShiftLeft_26(w_SignExtend1632, w_ShiftLeft2);

input [25:0] w_SignExtend1632;
output reg[27:0] w_ShiftLeft2;


always @(*)
begin
    w_ShiftLeft2[27:0] <= {w_SignExtend1632[25:0], 2'b00};
end

endmodule