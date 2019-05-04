module MUX11(w_EPC, w_ShiftLeft2Concat, w_ALUResult, w_ALUOUT, w_PCsrc, w_MUX11);

input [1:0] w_PCsrc;
input [31:0] w_ALUOUT, w_EPC, w_ALUResult, w_ShiftLeft2Concat;
output reg[31:0] w_MUX11;

always @(*)

begin
    case (w_PCsrc)
        3'b00:begin
            w_MUX11[31:0] <= w_ALUResult[31:0];
        end
        3'b01:begin
            w_MUX11[31:0] <= w_ALUOUT[31:0];
        end
        3'b10:begin
            w_MUX11[31:0] <= w_ShiftLeft2Concat[31:0];
        end
        3'b11:begin
            w_MUX11[31:0] <= w_EPC[31:0];
        end
    endcase
end

endmodule
        