Module Control(Estado, w_PCWrite, w_IorD, w_MemRead, w_WriteData, 
                w_RegDist, w_AluSrcA, w_AluSrcB, w_RegWrite, w_ALUControl, w_ALUOutCtrl, w_EPCControl, w_PCSrc);


    input[6:0]      Estado;
    
    output reg      w_RegWrite, w_MemRead, w_PCWrite, w_WriteData, w_ALUOutCtrl, w_EPCControl;
    output reg[1:0] w_IorD, w_RegDist, w_AluSrcA, w_PCSrc;
    output reg[2:0] w_AluSrcB, w_ALUControl;


    always @(posedge Clock) begin

    case (Estado)
        7'b0000001 : //Fetch
            begin
                w_PCWrite <= 1
                w_IorD <= 0
                w_MemRead <= 1
                w_AluSrcA <= 00
                w_AluSrcB <= 001
                w_ALUControl <= 001
                w_PCSrc <= 00
            end

        7'b0000010 : // Decode
            begin
                w_AluSrcA <= 01
                w_AluSrcB <= 11
                w_ALUOutCtrl <= 1
                w_ALUControl <= 001
            end
    endcase
end
endmodule
    