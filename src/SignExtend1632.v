module w_SignExtend1632(w_rd, w_SignExtend1632);

    input [15:0] w_rd;
    output reg[31:0] w_SignExtend1632;

always @(*)

     w_SignExtend1632[31:0] <= {16'b0, w_rd[15:0]};
 

endmodule