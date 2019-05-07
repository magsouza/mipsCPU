module MUX9 (DivMult, w_DIVLO, w_MULTLO, w_MUX9);

	input DivMult;
	input [31:0] w_DIVLO, w_MULTLO;
	output reg[31:0] w_MUX9;

always @(*)

begin
	case (DivMult)
		1'b0: begin
			w_MUX9[31:0] <= w_DIVLO;
		end
		1'b1: begin
			w_MUX9[31:0] <= w_MULTLO;
		end
	endcase
end

endmodule