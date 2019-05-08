module w_SignExtend132(w_ALULT, w_SignExtend132);


    output reg[31:0] w_SignExtend132;

always @(*)

begin
    case (w_ALULT)
        1'b0 : begin
            w_SignExtend132[31:0] <= {32'b1};
        end
        1'b' : begin
            w_SignExtend132[31:0] <= {32'b0};
        end
    endcase
end

endmodule