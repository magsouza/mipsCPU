module MUX5(w_MemToReg, w_ALUOut, w_LS, w_ShiftReg, w_MUX10, w_Shiftleft16, w_SignExtend132, w_MUX5);

input [2:0] w_MemToReg;
input [31:0] w_LS, w_ALUOut, w_Shiftleft16, w_ShiftReg, w_MUX10, w_SignExtend132;
output [31:0] w_MUX5;

always @(*)

begin
    case (w_MemToReg)
        3'b000: begin
            w_MUX5[31:0] <= w_ALUOut[31:0];
        end
        3'b001: begin
            w_MUX5[31:0] <= w_LS[31:0];
        end
        3'b010: begin
            w_MUX5[31:0] <= w_ShiftReg[31:0];
        end
        3'b011: begin
            w_MUX5[31:0] <= w_MUX10[31:0];
        end
        3'b100: begin
            w_MUX5[31:0] <= w_Shiftleft16[31:0];
        end
        3'b101: begin
            w_MUX5[31:0] <= w_SignExtend132[31:0];
        end
    endcase
end

endmodule