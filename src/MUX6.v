module MUX6(w_PC, w_A, w_SignExtend2632, w_MemDataReg,w_ALUSrcA, w_MUX6);

input [1:0] w_ALUSrcA;
input [31:0] w_PC, w_MemDataReg, w_A, w_SignExtend2632;
output reg [31:0] w_MUX6;

always@(*)

begin
    case (w_ALUSrcA)
        2'b00: begin
            w_MUX6 <=  w_PC[31:0];
        end
        2'b01: begin
            w_MUX6 <=  w_A[31:0];
        end
        2'b10: begin
            w_MUX6 <=  w_SignExtend2632[31:0];
        end
        2'b11: begin
            w_MUX6 <=  w_MemDataReg[31:0];
        end
    endcase
end
endmodule