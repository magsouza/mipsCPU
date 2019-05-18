module w_Concat2(w_rs, w_rt, w_rd, w_concat);

    input [4:0] w_rs, w_rt;
    input [15:0] w_rd;
    output reg[25:0] w_concat;

always @(*)

     w_concat[25:0] <= {w_rs[4:0], w_rt[4:0], w_rd[15:0]};
 

endmodule