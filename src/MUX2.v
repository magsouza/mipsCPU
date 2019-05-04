module MUX2 (ExcpCtrl, w_MUX2);

input [1:0] ExcpCtrl;
output reg[31:0] w_MUX2;

always @(*)
begin
	case(ExcpCtrl)
		2'b00: begin
			w_MUX2[31:0] <= 32'd253;
		end
		2'b01: begin
			w_MUX2[31:0] <= 32'd254;
		end
		2'b10: begin
			w_MUX2[31:0] <= 32'd255;
		end
	endcase
end

endmodule
