module MUX7(w_ALUSrcB, w_B, w_SignExtend1632, w_Shiftleft2, w_MUX7);

input [2:0] w_ALUSrcB;
input [31:0] w_B, w_SignExtend1632, w_Shiftleft2;
output reg [31:0] w_MUX7;

always@(*)

begin
    case (w_ALUSrcB)
        3'b000: begin
            w_MUX7 <=  w_B[31:0];
        end
        3'b001: beginc
            w_MUX7 <=  32'd4;
        end
        3'b010: begin
            w_MUX7 <=  w_SignExtend1632[31:0];
        end
        3'b011: begin
            w_MUX7 <=  w_Shiftleft2[31:0];
        end
        3'b100: begin
            w_MUX7 <=  32'd1;
        end
    endcase
end
endmodule
