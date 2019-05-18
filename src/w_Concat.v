module w_Concat(w_PC, w_offset, w_concat);

    input [3:0] w_PC;
    input [27:0] w_offset;
    output reg[31:0] w_concat;

always @(*)

     w_concat[31:0] <= {w_PC[3:0], w_offset[27:0]};
 

endmodule