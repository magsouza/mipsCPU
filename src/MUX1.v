module MUX1 (IorD, w_PC, w_ALUResult, w_ALUOut, w_MUX2, w_MUX1);

	input [1:0] IorD;
	input [31:0] w_PC, w_ALUResult, w_ALUOut, w_MUX2;
	output reg[31:0] w_MUX1;

always @(*)

begin
	case (IorD)
		2'b00: begin
			w_MUX1[31:0] <= w_PC[31:0];
		end
		2'b01: begin
			w_MUX1[31:0] <= w_ALUResult[31:0];
		end
		2'b10: begin
			w_MUX1[31:0] <= w_ALUOut[31:0];
		end
		2'b11: begin
			w_MUX1[31:0] <= w_MUX2[31:0];
        	end
	endcase
end

endmodule
