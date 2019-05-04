module ShiftLeft2Concat(w_PC, w_rdrtrs, w_ShiftLeft2Concat);

input [25:0] w_rdrtrs;
input [31:0] w_PC;

output reg [31:0] w_ShiftLeft2Concat;

always @(*)
begin
    w_ShiftLeft2Concat <= {w_PC[31:28], w_rdrtrs[25:0], 2'd0};
end

endmodule