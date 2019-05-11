module w_SignExtend1632(w_rd, w_SignExtend1632);

    input [15:0] w_rd;
    output reg[31:0] w_SignExtend1632;

always @(*)

case (w_rd[15])
        1'b0 : begin
            w_SignExtend1632[31:0] <= {16'b0000000000000000, w_rd[15-0]};
        end
        1'b1 : begin
            w_SignExtend1632[31:0] <= {16'b1111111111111111, w_rd[15-0]};
        end
    endcase
endmodule