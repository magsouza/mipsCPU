module MUX1 (muxFlag, w_muxIn0, w_muxIn1, w_muxIn2, w_muxIn3, w_muxOut);

	input [1:0] muxFlag;
	input [4:0] w_muxIn0, w_muxIn1, w_muxIn2, w_muxIn3;
	output reg[4:0] w_muxOut;

always @(*)

begin
	case (muxFlag)
		2'b00: begin
			w_muxOut[4:0] <= w_muxIn0[4:0];
		end
		2'b01: begin
			w_muxOut[4:0] <= w_muxIn1[4:0];
		end
		2'b10: begin
			w_muxOut[4:0] <= w_muxIn2[4:0];
		end
		2'b11: begin
			w_muxOut[4:0] <= w_muxIn3[4:0];
        	end
	endcase
end

endmodule
