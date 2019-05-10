module w_SignExtend2632(w_rdrtrs, w_SignExtend2632);

    input[25:0] w_rdrtrs;
    output reg[31:0] w_SignExtend2632;

always @(*)

begin
    case (w_rdrtrs[25])
        1'b0 : begin
            w_SignExtend2632[31:0] <= {5'b1, w_SignExtend2632[25:0]};
        end
        1'b1 : begin
            w_SignExtend2632[31:0] <= {5'b0, w_SignExtend2632[25:0]};
        end
    endcase
end

endmodule