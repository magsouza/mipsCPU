module LoadSize (LS, w_MemDataReg, w_LS);

  input [1:0] LS;
  input [31:0] w_MemDataReg;
  output [31:0] w_LS;

  always @(*)

  begin
      case (LS)
          // word: não faz nada
          2'b00 : begin
            w_LS[31:0] = w_MemDataReg[31:0];
          end
          // half: concatena com 16
          2'b01 : begin
            w_LS[31:0] = {16'b0, w_MemDataReg[15:0]};
          end
          // byte: concatena com 24
          2'b10 : begin
            w_LS[31:0] = {24'b0, w_MemDataReg[7:0]};
          end
      endcase
  end

endmodule
