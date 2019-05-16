
module Control(OPCode, Funct, Clock, Estado, w_PCWrite, w_IorD, w_MemRead, w_WriteData,w_MemToReg, w_RegDist, w_AluSrcA, w_AluSrcB, w_RegWrite, w_ALUControl, w_ALUOutCtrl, w_EPCControl, w_PCSrc, w_IRWrite, w_ShiftSrc, w_ShiftAmt, w_ShiftCrtl, w_MultStart, w_MultS, w_DivMult, w_RegHighW, w_RegLowW, w_MDRs, w_EQ, w_GT, w_LT, w_SSControl, Reset);

    output reg[6:0] Estado;
    input 			Clock;
    input[5:0] 		OPCode, Funct;
    output reg      w_RegWrite, w_MemRead, w_PCWrite, w_WriteData, w_ALUOutCtrl, w_EPCControl, w_IRWrite, w_ShiftSrc, w_ShiftAmt, w_RegHighW, w_RegLowW, w_DivMult, w_MultStart, w_MultS, w_MDRs, w_GT, w_EQ, w_LT, Reset;
    output reg[1:0] w_IorD, w_RegDist, w_AluSrcA, w_PCSrc, w_SSControl;
    output reg[2:0] w_AluSrcB, w_ALUControl, w_MemToReg, w_ShiftCrtl;
	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  setando estado inicial   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	initial Estado <= 7'b0000000; 
	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  dando nomezinhos pros estados do inferno   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	parameter RESETar = 7'b0000000, FETCH = 7'b0000001, DECODE = 7'b0000011; 
	
		// FUNCOES DO TIPO R
		
	parameter ShiftReg = 7'b0000100, sllv = 7'b0000101, srav = 7'b0000110, ShiftReg2 = 7'b0000111;
	parameter Shamts = 7'b0001000, sll = 7'b0001001, sra = 7'b0001010, srl = 7'b0001011;
	parameter SaveInReg = 7'b0001100;
	parameter Add = 7'b0001101, Sub = 7'b0001110, And = 7'b0001111;
	parameter posAddSubAnd = 7'b0010000;
	parameter mfhi = 7'b0010001;
	parameter Div = 7'b0010010, Div2 = 7'b0010011, Div3 = 7'b0010100;
	parameter Mult = 7'b0010101, Mult2 = 7'b0010110, Mult3 = 7'b0010111;
	parameter RTE = 7'b0011000;
	parameter Jr = 7'b0011001;
	parameter mflo = 7'b0011010;
	parameter Break = 7'b0011011;
	parameter Slt = 7'b0011100;
		
		// FUNCOES DO TIPO I
		
	parameter Addi = 7'b0101011;
	parameter posAddiAddiu = 7'b0101101;
	
		// FUNCOES DO TIPO J
		
		// EXCECOES

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  aqui começa a desgraça valendo   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
    always @(posedge Clock) begin

    case (Estado)
    
		RESETar : // Reset
			begin
				Reset <= 1; 
				w_ALUControl <= 000;
				w_ALUOutCtrl <= 0;
				w_AluSrcA <= 00;
				w_AluSrcB <= 000;
				w_EPCControl <= 00;
				w_EQ <= 0;
				w_GT <= 0;
				w_IorD <= 0;
				w_IRWrite <= 0;
				w_LT <= 0; 
				w_MemRead <= 0;
				w_MemToReg <= 110;
				w_PCSrc <= 00; 
				w_PCWrite <= 0; 
				w_RegDist <= 10; 
				w_RegWrite <= 1;
				w_ShiftAmt <= 0;
				w_ShiftCrtl <= 000;
				w_ShiftSrc <= 0;
				w_SSControl <= 00;
				w_WriteData <= 0;
				Estado <= FETCH;
			end
		
        FETCH : 
            begin
                Reset <= 0; //
				w_ALUControl <= 001; //
				w_ALUOutCtrl <= 0;
				w_AluSrcA <= 00; //
				w_AluSrcB <= 001; //
				w_EPCControl <= 00;
				w_EQ <= 0;
				w_GT <= 0;
				w_IorD <= 0; //
				w_IRWrite <= 1;
				w_LT <= 0; 
				w_MemRead <= 1; //
				w_MemToReg <= 110;
				w_PCSrc <= 00; // 
				w_PCWrite <= 1; //  
				w_RegDist <= 10; 
				w_RegWrite <= 0;
				w_ShiftAmt <= 0;
				w_ShiftCrtl <= 000;
				w_ShiftSrc <= 0;
				w_SSControl <= 00;
				w_WriteData <= 0;
				Estado <= 7'b0000010;
            end

        7'b0000010 : // WAIT
            begin
				Reset <= 0;
				w_ALUControl <= 001; 
				w_ALUOutCtrl <= 1;
				w_AluSrcA <= 00; 
				w_AluSrcB <= 001; 
				w_EPCControl <= 00;
				w_EQ <= 0;
				w_GT <= 0;
				w_IorD <= 0;
				w_IRWrite <= 1; //
				w_LT <= 0; 
				w_MemRead <= 0; 
				w_MemToReg <= 110;
				w_PCSrc <= 00; 
				w_PCWrite <= 0;   
				w_RegDist <= 10; 
				w_RegWrite <= 0;
				w_ShiftAmt <= 0;
				w_ShiftCrtl <= 000;
				w_ShiftSrc <= 0;
				w_SSControl <= 00;
				w_WriteData <= 0;
				Estado <= DECODE;
            end
            
        DECODE : 
           begin
                Reset <= 0;
				w_ALUControl <= 001; // 
				w_ALUOutCtrl <= 1; // 
				w_AluSrcA <= 01; // 
				w_AluSrcB <= 011; // 
				w_EPCControl <= 00;
				w_EQ <= 0;
				w_GT <= 0;
				w_IorD <= 0;
				w_IRWrite <= 0;
				w_LT <= 0;  
				w_MemRead <= 0; 
				w_MemToReg <= 110;
				w_PCSrc <= 00; 
				w_PCWrite <= 0;   
				w_RegDist <= 10; 
				w_RegWrite <= 0;
				w_ShiftAmt <= 0;
				w_ShiftCrtl <= 000;
				w_ShiftSrc <= 0;
				w_SSControl <= 00;
				w_WriteData <= 0;
				
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  vai escolher a instrucao e tal  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				case(OPCode) 
			
					// ~~~~~~~~~~~~~~~~~~~~~~  TIPO R  ~~~~~~~~~~~~~~~~~~~~~
					6'b000000:
					begin
						// ~~~~~~~~~~~~~  escolhe pelo Funct ~~~~~~~~~~~~~
						case(Funct)
							
							6'b000100: Estado <= sllv; // 0x4
							6'b000111: Estado <= srav; // 0x7
							
							6'b000000: Estado <= sll; // 0x0
							6'b000010: Estado <= sra; // 0x2
							6'b000011: Estado <= srl; // 0x3
							
							6'b100000: Estado <= Add; // 0x20
							6'b100010: Estado <= Sub; // 0x22
							6'b100100: Estado <= And; // 0x24
							6'b010000: Estado <= mfhi; // 0x10 
							6'b011010: Estado <= Div; // 0x1a
							6'b011000: Estado <= Mult; // 0x18
							6'b010011: Estado <= RTE; // 0x13
							6'b001000: Estado <= Jr; // 0x8
							6'b010010: Estado <= mflo; // 0x12
							6'b001101: Estado <= Break; // 0xd
							6'b101010: Estado <= Slt; // 0x2a

						endcase
					end
					
					
					// ~~~~~~~~~~~~~~~~~~~~~~  TIPO I  ~~~~~~~~~~~~~~~~~~~~~
					
					// ~~~~~~~~~~~~~~~~~~~~~~  TIPO J  ~~~~~~~~~~~~~~~~~~~~~
					
					//exemplos do futuro
					//6'b010000: //inc
					6'b001000: Estado <= Addi; 
					default : Estado <= 7'b1111111;
				endcase
           end
           
     // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  aqui temos as benditas instruções  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           
          sllv: 
				begin
					Reset <= 0;
					w_ALUControl <= 001;  
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01;  
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0; 
					w_LT <= 0; 
					w_MemRead <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0; //
					w_ShiftCrtl <= 010; //
					w_ShiftSrc <= 0; //
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= SaveInReg;
				end
           
          srav:
				begin
					Reset <= 0;
					w_ALUControl <= 001;  
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01;  
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0; 
					w_LT <= 0; 
					w_MemRead <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0; //
					w_ShiftCrtl <= 100; //
					w_ShiftSrc <= 0; //
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= SaveInReg;
				end
			
		   sll: 
				begin
					Reset <= 0;
					w_ALUControl <= 001;  
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01;  
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0; 
					w_LT <= 0; 
					w_MemRead <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 1; //
					w_ShiftCrtl <= 010; //
					w_ShiftSrc <= 1; //
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= SaveInReg;
				end	
					
          sra: 
				begin
					Reset <= 0;
					w_ALUControl <= 001;  
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01;  
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0; 
					w_LT <= 0; 
					w_MemRead <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 1; //
					w_ShiftCrtl <= 100; //
					w_ShiftSrc <= 1; //
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= SaveInReg;
				end	
					
          srl: 
				begin
					Reset <= 0;
					w_ALUControl <= 001;  
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01;  
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0; 
					w_LT <= 0; 
					w_MemRead <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 1; //
					w_ShiftCrtl <= 011; //
					w_ShiftSrc <= 1; //
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= SaveInReg;
				end
				
			SaveInReg: 
				begin
					Reset <= 0;
					w_ALUControl <= 001;  
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01;  
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0; 
					w_LT <= 0; 
					w_MemRead <= 0; 
					w_MemToReg <= 100; //
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 01; // 
					w_RegWrite <= 1; //
					w_ShiftAmt <= 1; 
					w_ShiftCrtl <= 011; 
					w_ShiftSrc <= 1;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end		
          
			Add: 
				begin
					Reset <= 0;
					w_ALUControl <= 001; //
					w_ALUOutCtrl <= 1; // 
					w_AluSrcA <= 01; // 
					w_AluSrcB <= 000; // 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0;
					w_LT <= 0;  
					w_MemRead <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 0;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= posAddSubAnd;
				end
			
			Sub: 
				begin
					Reset <= 0;
					w_ALUControl <= 010; // 
					w_ALUOutCtrl <= 1; // 
					w_AluSrcA <= 01; // 
					w_AluSrcB <= 000; // 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0; 
					w_LT <= 0; 
					w_MemRead <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 0;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= posAddSubAnd;
				end
			
			And: 
				begin
					Reset <= 0;
					w_ALUControl <= 011; // 
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01; // 
					w_AluSrcB <= 000; // 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0; 
					w_LT <= 0; 
					w_MemRead <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 0;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
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
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0; 
					w_LT <= 0; 
					w_MemRead <= 0; 
					w_MemToReg <= 000; //
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 01; //
					w_RegWrite <= 1; //
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 0;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= 7'b0000001;
				end
			
			mfhi: 
				begin
					Reset <= 0;
					w_ALUControl <= 001;  
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01;  
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0;
					w_LT <= 0;  
					w_MemRead <= 0; 
					w_MemToReg <= 011; //
					w_MultS <= 0; //
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 01; // 
					w_RegWrite <= 1; //
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 0;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end
			
			// DIV
			// MULT
			
			RTE: 
				begin
					Reset <= 0;
					w_ALUControl <= 001; // 
					w_ALUOutCtrl <= 1; // 
					w_AluSrcA <= 01; // 
					w_AluSrcB <= 011; // 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0;
					w_LT <= 0;  
					w_MemRead <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 0;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end

			Jr: 
				begin
					Reset <= 0;
					w_ALUControl <= 000; // 
					w_ALUOutCtrl <= 1; 
					w_AluSrcA <= 01; // 
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0; 
					w_LT <= 0; 
					w_MemRead <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; //
					w_PCWrite <= 1; //    
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 0;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end
				
			mflo: 
				begin
					Reset <= 0;
					w_ALUControl <= 001; 
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01; 
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0; 
					w_LT <= 0; 
					w_MemRead <= 0; 
					w_MemToReg <= 011;
					w_MultS <= 1; //
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 01; // 
					w_RegWrite <= 1;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 0;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end
				
			Break: 
				begin
					Reset <= 0;
					w_ALUControl <= 001; 
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 00; // 
					w_AluSrcB <= 001; // 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0; 
					w_LT <= 0; 
					w_MemRead <= 0; 
					w_MemToReg <= 110;
					w_MultS <= 0;
					w_PCSrc <= 00; //
					w_PCWrite <= 1; //   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 0;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end
			
			Slt: 
				begin
					Reset <= 0;
					w_ALUControl <= 111; // 
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01; //
					w_AluSrcB <= 000; // 
					w_EPCControl <= 00;
					w_EQ <= 0;
					w_GT <= 0;
					w_IorD <= 0;
					w_IRWrite <= 0; 
					w_LT <= 0; 
					w_MemRead <= 0; 
					w_MemToReg <= 101; //
					w_MultS <= 0;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_RegDist <= 01; // 
					w_RegWrite <= 1; // 
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 0;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end	
			
			// addi e etc so pra PC+4 funcionar
			Addi: 
			begin
				Reset <= 0;
				w_ALUControl <= 001; // 
				w_ALUOutCtrl <= 1; // 
				w_AluSrcA <= 01; //  
				w_AluSrcB <= 010; // 
				w_EPCControl <= 00;
				w_EQ <= 0;
				w_GT <= 0;
				w_IorD <= 0;
				w_IRWrite <= 0;
				w_LT <= 0;  
				w_MemRead <= 0; 
				w_MemToReg <= 110;
				w_PCSrc <= 00; 
				w_PCWrite <= 0;   
				w_RegDist <= 10; 
				w_RegWrite <= 0;
				w_ShiftAmt <= 0;
				w_ShiftCrtl <= 000;
				w_ShiftSrc <= 0;
				w_SSControl <= 00;
				w_WriteData <= 0;
				Estado <= posAddiAddiu;
			end
			
			posAddiAddiu:
			begin			
				Reset <= 0;
				w_ALUControl <= 001; 
				w_ALUOutCtrl <= 1; 
				w_AluSrcA <= 01;  
				w_AluSrcB <= 010;  
				w_EPCControl <= 00;
				w_EQ <= 0;
				w_GT <= 0;
				w_IorD <= 0;
				w_IRWrite <= 0;
				w_LT <= 0;  
				w_MemRead <= 0; 
				w_MemToReg <= 000; //
				w_PCSrc <= 00; 
				w_PCWrite <= 0;   
				w_RegDist <= 00; // 
				w_RegWrite <= 1; //
				w_ShiftAmt <= 0;
				w_ShiftCrtl <= 000;
				w_ShiftSrc <= 0;
				w_SSControl <= 00;
				w_WriteData <= 0;
				Estado <= FETCH;
			end
			
    endcase
end
endmodule
    
