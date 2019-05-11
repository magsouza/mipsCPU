module StoreSize(SS, w_MemDataReg, w_regB_out, w_SS);

	input [1:0] SS;
	input [31:0] w_regB_out, w_MemDataReg;
	output [31:0] w_SS;

	always @(*)

  begin
      case (SS)
          2'b00 : begin
            w_SS[31:0] = w_regB_out[31:0];
          end
          2'b01 : begin
            w_SS[31:0] = {w_MemDataReg[31:16], w_regB_out[15:0]};
          end
          2'b10 : begin
            w_SS[31:0] = {w_MemDataReg[31:8], w_regB_out[7:0]};
          end
      endcase
  end

endmodule
