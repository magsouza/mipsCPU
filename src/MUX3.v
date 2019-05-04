module MUX1 (WriteData, w_ALUResult, w_SS, w_MUX3);

	input [2:0] WriteData;
	input [31:0] w_ALUResult, w_SS;
	output reg[31:0] w_MUX3;

always @(*)

begin
	case (WriteData)
		3'b000: begin
			w_MUX3[31:0] <= w_ALUResult[31:0];
		end
		3'b001: begin
			w_MUX3[31:0] <= w_SS[31:0];
		end
	endcase
end

endmodule
