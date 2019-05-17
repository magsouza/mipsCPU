module MUX2N (muxFlag, w_muxIn0, w_muxIn1, w_muxOut);

	input muxFlag;
	input [4:0] w_muxIn0, w_muxIn1;
	output reg[4:0] w_muxOut;

always @(*)

begin
	case (muxFlag)
		1'b0: begin
			w_muxOut[4:0] = w_muxIn0[4:0];
		end
		1'b1: begin
			w_muxOut[4:0] = w_muxIn1[4:0];
		end
	endcase
end

endmodule
