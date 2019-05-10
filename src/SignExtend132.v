module w_SignExtend132(w_LT, w_SignExtend132);

	input w_LT;
    output reg[31:0] w_SignExtend132;

always @(*)

begin
    case (w_LT)
        1'b0 : begin
            w_SignExtend132[31:0] <= {32'b1};
        end
        1'b1 : begin
            w_SignExtend132[31:0] <= {32'b0};
        end
    endcase
end

endmodule