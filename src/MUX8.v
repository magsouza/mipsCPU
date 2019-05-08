module MUX8 (DivMult, w_DIVHI, w_MULTHI, w_MUX8);

	input DivMult;
	input [31:0] w_DIVHI, w_MULTHI;
	output reg[31:0] w_MUX9;

always @(*)

begin
	case (DivMult)
		1'b0: begin
			w_MUX8[31:0] <= w_DIVHI;
		end
		1'b1: begin
			w_MUX8[31:0] <= w_MULTHI;
		end
	endcase
end

endmodule