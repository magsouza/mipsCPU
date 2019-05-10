module Control(OPCode, Funct, Clock, Estado, w_PCWrite, w_IorD, w_MemRead, w_WriteData,w_MemToReg, w_RegDist, w_AluSrcA, w_AluSrcB, w_RegWrite, w_ALUControl, w_ALUOutCtrl, w_EPCControl, w_PCSrc, w_IRWrite, Reset);


    output reg[6:0]      Estado;
    input Clock;
    input[5:0] OPCode, Funct;
    output reg      w_RegWrite, w_MemRead, w_PCWrite, w_WriteData, w_ALUOutCtrl, w_EPCControl, w_IRWrite, Reset;
    output reg[1:0] w_IorD, w_RegDist, w_AluSrcA, w_PCSrc;
    output reg[2:0] w_AluSrcB, w_ALUControl, w_MemToReg;
	initial Estado <= 7'b0000000;
	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  dando nomezinhos pros estados do inferno   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	parameter Resetar = 7'b0000000; 
	parameter ADD = 7'b0000100, SUB = 7'b0000101, AND = 7'b0000110;
	parameter posAddSubAnd = 7'b0000111;
	parameter ADDi = 7'b0001000; // KKKKK DPS ARRUMO
	parameter posADDiEADDiu = 7'b0001001; 


	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  aqui começa a desgraça valendo   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
    always @(posedge Clock) begin

    case (Estado)
		Resetar : // Reset
		begin
			Reset <= 1; 
			w_ALUControl <= 000;
			w_ALUOutCtrl <= 0;
			w_AluSrcA <= 00;
			w_AluSrcB <= 000;
			w_EPCControl <= 00;
			w_IorD <= 0;
			w_IRWrite <= 0;
			w_MemRead <= 0;
			w_MemToReg <= 110;
			w_PCSrc <= 00; 
			w_PCWrite <= 0; 
			w_RegDist <= 10; 
			w_RegWrite <= 1;
			w_WriteData <= 0;
			Estado <= 7'b0000001;
		end
        7'b0000001 : // Fetch
            begin
                Reset <= 0; //
				w_ALUControl <= 001; //
				w_ALUOutCtrl <= 0;
				w_AluSrcA <= 00; //
				w_AluSrcB <= 001; //
				w_EPCControl <= 00;
				w_IorD <= 0; //
				w_IRWrite <= 0;
				w_MemRead <= 1; //
				w_MemToReg <= 110;
				w_PCSrc <= 00; // 
				w_PCWrite <= 1; //  
				w_RegDist <= 10; 
				w_RegWrite <= 1;
				w_WriteData <= 0;
				Estado <= 7'b0000010;
            end

        7'b0000010 : // IR
            begin
				Reset <= 0;
				w_ALUControl <= 001; 
				w_ALUOutCtrl <= 1;
				w_AluSrcA <= 00; 
				w_AluSrcB <= 001; 
				w_EPCControl <= 00;
				w_IorD <= 0;
				w_IRWrite <= 1; //
				w_MemRead <= 1; 
				w_MemToReg <= 110;
				w_PCSrc <= 00; 
				w_PCWrite <= 1;   
				w_RegDist <= 10; 
				w_RegWrite <= 1;
				w_WriteData <= 0;
				Estado <= 7'b0000011;
            end
        7'b0000011 : // DECODE
           begin
                Reset <= 0;
				w_ALUControl <= 001; // 
				w_ALUOutCtrl <= 1; // 
				w_AluSrcA <= 01; // 
				w_AluSrcB <= 011; // 
				w_EPCControl <= 00;
				w_IorD <= 0;
				w_IRWrite <= 1; 
				w_MemRead <= 1; 
				w_MemToReg <= 110;
				w_PCSrc <= 00; 
				w_PCWrite <= 1;   
				w_RegDist <= 10; 
				w_RegWrite <= 1;
				w_WriteData <= 0;
				
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  vai escolher a instrucao e tal  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				case(OPCode) 
					6'b000000: //tipo R
					begin
						case(Funct)
							6'b100000: Estado <= ADD;
							6'b100010: Estado <= SUB;
							// mete o and dps
							
							
						endcase
					end
					
					
					//tipos I e J
					//exemplos do futuro
					//6'b010000: //inc
					6'b001000: Estado <= ADDi; 
					default : Estado <= 7'b1111111;
				endcase
           end
           
     // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  aqui temos as benditas instruções  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           
           ADD: 
           begin
				Reset <= 0;
				w_ALUControl <= 001; //
				w_ALUOutCtrl <= 1; // 
				w_AluSrcA <= 01; // 
				w_AluSrcB <= 000; // 
				w_EPCControl <= 00;
				w_IorD <= 0;
				w_IRWrite <= 1; 
				w_MemRead <= 1; 
				w_MemToReg <= 110;
				w_PCSrc <= 00; 
				w_PCWrite <= 1;   
				w_RegDist <= 10; 
				w_RegWrite <= 1;
				w_WriteData <= 0;
				Estado <= posAddSubAnd;
			end
			
			SUB: 
           begin
				Reset <= 0;
				w_ALUControl <= 010; // 
				w_ALUOutCtrl <= 1; // 
				w_AluSrcA <= 01; // 
				w_AluSrcB <= 000; // 
				w_EPCControl <= 00;
				w_IorD <= 0;
				w_IRWrite <= 1; 
				w_MemRead <= 1; 
				w_MemToReg <= 110;
				w_PCSrc <= 00; 
				w_PCWrite <= 1;   
				w_RegDist <= 10; 
				w_RegWrite <= 1;
				w_WriteData <= 0;
				Estado <= posAddSubAnd;
			end
			
			AND: 
           begin
				Reset <= 0;
				w_ALUControl <= 011; // 
				w_ALUOutCtrl <= 1;  
				w_AluSrcA <= 01; // 
				w_AluSrcB <= 000; // 
				w_EPCControl <= 00;
				w_IorD <= 0;
				w_IRWrite <= 1; 
				w_MemRead <= 1; 
				w_MemToReg <= 110;
				w_PCSrc <= 00; 
				w_PCWrite <= 1;   
				w_RegDist <= 10; 
				w_RegWrite <= 1;
				w_WriteData <= 0;
				Estado <= posAddSubAnd;
			end
			
		   posAddSubAnd:
           begin
				Reset <= 0;
				w_ALUControl <= 001; 
				w_ALUOutCtrl <= 1;  
				w_AluSrcA <= 01; 
				w_AluSrcB <= 000;
				w_EPCControl <= 00;
				w_IorD <= 0;
				w_IRWrite <= 1; 
				w_MemRead <= 1; 
				w_MemToReg <= 000; //
				w_PCSrc <= 00; 
				w_PCWrite <= 1;   
				w_RegDist <= 01; //
				w_RegWrite <= 1; //
				w_WriteData <= 0;
				Estado <= 7'b0000001;
			end
			
			ADDi: 
			begin
				Reset <= 0;
				w_ALUControl <= 001; // 
				w_ALUOutCtrl <= 1; // 
				w_AluSrcA <= 01; //  
				w_AluSrcB <= 010; // 
				w_EPCControl <= 00;
				w_IorD <= 0;
				w_IRWrite <= 1; 
				w_MemRead <= 1; 
				w_MemToReg <= 110;
				w_PCSrc <= 00; 
				w_PCWrite <= 1;   
				w_RegDist <= 10; 
				w_RegWrite <= 1;
				w_WriteData <= 0;
				Estado <= posADDiEADDiu;
			end
			
			posADDiEADDiu:
			begin
				Reset <= 0;
				w_ALUControl <= 001; 
				w_ALUOutCtrl <= 1; 
				w_AluSrcA <= 01; 
				w_AluSrcB <= 010;  
				w_EPCControl <= 00;
				w_IorD <= 0;
				w_IRWrite <= 1; 
				w_MemRead <= 1; 
				w_MemToReg <= 000; //
				w_PCSrc <= 00; 
				w_PCWrite <= 1;   
				w_RegDist <= 00; // 
				w_RegWrite <= 1; //
				w_WriteData <= 0;
				Estado <= 7'b0000001; // volta pro FETCH
			end
		
			
    endcase
end
endmodule
    
