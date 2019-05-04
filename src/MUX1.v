module MUX1 (IorD, w_PC, w_ALUResult, w_ALUOut, w_MUX2, w_MUX1);

	input [2:0] IorD;
	input [31:0] w_PC, w_ALUResult, w_ALUOut, w_MUX2;
	output reg[31:0] w_MUX1;

always @(*)

begin
	case (IorD)
		3'b000: begin
			w_MUX1[31:0] <= w_PC[31:0];
		end
		3'b001: begin
			w_MUX1[31:0] <= w_ALUResult[31:0];
		end
		3'b010: begin
			w_MUX1[31:0] <= w_ALUOut[31:0];
		end
		3'b011: begin
			w_MUX1[31:0] <= w_MUX2[31:0];
        	end
	endcase
end

endmodule
