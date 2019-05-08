module MUX4 (w_RegDist, w_rt, w_rd, w_MUX4);
	
	input [1:0] w_RegDist;
	input [4:0] w_rt, w_rd;
	output reg [4:0] w_MUX4;

always @(*)
begin 
	case (w_RegDist)
		2'b00: begin
			w_MUX4[4:0] <= w_rt [4:0];
		end 
		2'b01: begin
			w_MUX4[4:0] <= w_rd[4:0];
		end
		2'b10: begin 
			w_MUX4[4:0] <= 5'd31
		end
		2'b11: begin
			w_MUX4[4:0] <= 5'd29
		end
	endcase
end

endmodule
	 