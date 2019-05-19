
module Control(OPCode, Funct, Clock, Estado, w_PCWrite, w_IorD, w_ReadWrite, w_WriteData, w_MemToReg, w_RegDist, w_AluSrcA, w_AluSrcB, w_RegWrite, w_ALUControl, w_ALUOutCtrl, w_EPCControl, w_PCSrc, w_IRWrite, w_ShiftSrc, w_ShiftAmt, w_ShiftCrtl, MultStart, MultS, DivMult, RegHigh, RegLow, w_MDRs, EQ, GT, LT, w_SSControl, w_LSControl, Reset, DivStart, DivStop, MultStop, DivZero);

    output reg[6:0] Estado;
    input 			Clock, GT, EQ, LT, DivStop, MultStop, DivZero;
    input[5:0] 		OPCode, Funct;
    output reg      w_RegWrite, w_ReadWrite, w_PCWrite, w_WriteData, w_ALUOutCtrl, w_EPCControl, w_IRWrite, w_ShiftSrc, w_ShiftAmt, RegHigh, RegLow, w_MDRs, DivStart, MultStart, MultS, DivMult, Reset;
    output reg[1:0] w_IorD, w_RegDist, w_AluSrcA, w_PCSrc, w_SSControl, w_LSControl;
    output reg[2:0] w_AluSrcB, w_ALUControl, w_MemToReg, w_ShiftCrtl;
	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  setando estado inicial   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	initial Estado <= 7'b0000000; 
	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  dando nomes para os estados  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
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
	
	parameter Lui = 7'b0011101;
	parameter preSSS1 = 7'b0011110, preSSS2 = 7'b0011111, preSSS3 = 7'b0100000, preSSS4 = 7'b0110100;
	parameter SH = 7'b0100001, SW = 7'b0100010, SB = 7'b0100011;
	parameter SLTI = 7'b0100100;
	parameter preLLL1 = 7'b0100101, preLLL2 = 7'b0100110, preLLL3 = 7'b0100111, preLLL4 = 7'b0110011;
	parameter LH = 7'b0101000, LW = 7'b0101001, LB = 7'b0101010;
	parameter Addi = 7'b0101011, Addiu = 7'b0101100;
	parameter posAddiAddiu = 7'b0101101, overflowAddiiu = 7'b0101110;
	parameter beq = 7'b0101111;
	parameter bne = 7'b0110000;
	parameter ble = 7'b0110001;
	parameter bgt = 7'b0110010;
	
		// FUNCOES DO TIPO J
		
	parameter jump = 7'b0110101;
	parameter preInc = 7'b0110110, preDec = 7'b0110111, preIncDec = 7'b0111000;
	parameter inc = 7'b0111001, dec = 7'b0111010;
	parameter posIncDec = 7'b0111011;  
	parameter jal = 7'b0111100, posJal = 7'b0111101;
		
		// EXCECOES

	parameter Over_Load = 7'b1000000, Over_Wait = 7'b1000001, Over_Wait2 =  7'b1000010;
	parameter Div_Zero = 7'b1000011, Div_Stall = 7'b1000100, Div_Stall2 = 7'b1000101; 
	parameter OV_PC =  7'b1000110; 
	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  start  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
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
				w_IorD <= 00;
				w_IRWrite <= 0;
				w_LSControl <= 00; 
				w_MDRs <= 0; 
				w_MemToReg <= 110;
				w_PCSrc <= 00; 
				w_PCWrite <= 0;
				w_ReadWrite <= 0;
				w_RegDist <= 10; 
				w_RegWrite <= 1;
				w_ShiftAmt <= 0;
				w_ShiftCrtl <= 000;
				w_ShiftSrc <= 0;
				w_SSControl <= 00;
				w_WriteData <= 0;
				
				RegHigh <= 0; 
				RegLow <= 0;
				MultS <= 0;
				DivMult <= 0;
				DivStart <= 0;
				MultStart <= 0;
				
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
				w_IorD <= 00; //
				w_IRWrite <= 1;
				w_LSControl <= 00; 
				w_MDRs <= 0; 
				w_MemToReg <= 110;
				w_PCSrc <= 00; // 
				w_PCWrite <= 1; // 
				w_ReadWrite <= 0; //
				w_RegDist <= 10; 
				w_RegWrite <= 0;
				w_ShiftAmt <= 0;
				w_ShiftCrtl <= 000;
				w_ShiftSrc <= 0;
				w_SSControl <= 00;
				w_WriteData <= 0;
				
				RegHigh <= 0; 
				RegLow <= 0;
				MultS <= 0;
				DivMult <= 0;
				DivStart <= 0;
				MultStart <= 0;
				
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
				w_IorD <= 00;
				w_IRWrite <= 1; //
				w_LSControl <= 00; 
				w_MDRs <= 0; 
				w_MemToReg <= 110;
				w_PCSrc <= 00; 
				w_PCWrite <= 0; 
				w_ReadWrite <= 0;  
				w_RegDist <= 10; 
				w_RegWrite <= 0;
				w_ShiftAmt <= 0;
				w_ShiftCrtl <= 000;
				w_ShiftSrc <= 0;
				w_SSControl <= 00;
				w_WriteData <= 0;
				
				RegHigh <= 0; 
				RegLow <= 0;
				MultS <= 0;
				DivMult <= 0;
				DivStart <= 0;
				MultStart <= 0;
				
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
				w_IorD <= 00;
				w_IRWrite <= 0;
				w_LSControl <= 00; 
				w_MDRs <= 0;   
				w_MemToReg <= 110;
				w_PCSrc <= 00; 
				w_PCWrite <= 0; 
				w_ReadWrite <= 0;  
				w_RegDist <= 10; 
				w_RegWrite <= 0;
				w_ShiftAmt <= 0;
				w_ShiftCrtl <= 000;
				w_ShiftSrc <= 0;
				w_SSControl <= 00;
				w_WriteData <= 0;
				
				RegHigh <= 0; 
				RegLow <= 0;
				MultS <= 0;
				DivMult <= 0;
				DivStart <= 0;
				MultStart <= 0;
				
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  vai escolher a instrucao e tal  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				case(OPCode) 
			
					// ~~~~~~~~~~~~~~~~~~~~~~  TIPO R  ~~~~~~~~~~~~~~~~~~~~~
					6'b000000:
					begin
						// ~~~~~~~~~~~~~  escolhe pelo Funct ~~~~~~~~~~~~~
						case(Funct)
							
							6'b000100: Estado <= ShiftReg; // 0x4
							6'b000111: Estado <= ShiftReg; // 0x7
							
							6'b000000: Estado <= Shamts; // 0x0
							6'b000010: Estado <= Shamts; // 0x2
							6'b000011: Estado <= Shamts; // 0x3
							
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
					
					6'b001111: Estado <= Lui; // 0xf
					
					6'b101001: Estado <= SH; // 0x29
					6'b101011: Estado <= SW; // 0x2b
					6'b101000: Estado <= SB; // 0x28
					
					6'b001010: Estado <= SLTI; // 0xa
					
					6'b100000: Estado <= LB; // 0x20
					6'b100001: Estado <= LH; // 0x21
					6'b100011: Estado <= LW; // 0x23
					
					6'b001000: Estado <= Addi;
					6'b001001: Estado <= Addiu;
					
					6'b000100: Estado <= beq; // 0x4
					6'b000101: Estado <= bne; // 0x5
					6'b000110: Estado <= ble; // 0x6
					6'b000111: Estado <= bgt; // 0x7
							
					// ~~~~~~~~~~~~~~~~~~~~~~  TIPO J  ~~~~~~~~~~~~~~~~~~~~~
					
					6'b000010: Estado <= jump; // 0x2
					6'b010000: Estado <= preInc; // 0x10
					6'b010001: Estado <= preDec; // 0x11
					6'b000011: Estado <= jal; // 0x3
								
				
					default : Estado <= 7'b1111111;
				endcase
           end
           
     // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  aqui temos as instruções com seus estados  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           
          // ~~~~~~~~~~~~~~~~~~~~~~  TIPO R  ~~~~~~~~~~~~~~~~~~~~~
          
          ShiftReg:
				begin
					Reset <= 0;
					w_ALUControl <= 001;  
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01;  
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;
					w_ReadWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0; //
					w_ShiftCrtl <= 001; //
					w_ShiftSrc <= 0; //
					w_SSControl <= 00;
					w_WriteData <= 0;
					case (Funct)
						6'b000100: Estado <= sllv; // 0x4
						6'b000111: Estado <= srav; // 0x7
					endcase
				end
              
          sllv: 
				begin
					Reset <= 0;
					w_ALUControl <= 001;  
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01;  
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
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
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0; //
					w_ShiftCrtl <= 100; //
					w_ShiftSrc <= 0; //
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= SaveInReg;
				end
			
		   
		   Shamts: 
				begin
					Reset <= 0;
					w_ALUControl <= 001;  
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01;  
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;
					w_ReadWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 1; //
					w_ShiftCrtl <= 001; //
					w_ShiftSrc <= 1; //
					w_SSControl <= 00;
					w_WriteData <= 0;
					case (Funct)
						6'b000000: Estado <= sll; //0x0
						6'b000010: Estado <= srl; // 0x2
						6'b000011: Estado <= sra; // 0x3
					endcase
				end	
		   
		   
		   sll: 
				begin
					Reset <= 0;
					w_ALUControl <= 001;  
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 01;  
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
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
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
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
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
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
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 010; //
					w_PCSrc <= 00; 
					w_PCWrite <= 0;
					w_ReadWrite <= 0;   
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
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
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
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
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
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0; 
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
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
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0; 
					w_MemToReg <= 000; //
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_ReadWrite <= 0;
					w_RegDist <= 01; //
					w_RegWrite <= 1; //
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 0;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
					//case (Overflow)
					//	0: Estado <= FETCH;
					//	1: Estado <= Over_Load;
					//endcase
				end
			
			mfhi: 
				begin
					MultS <= 0; //
					w_MemToReg <= 011; //
					w_RegDist <= 01; // 
					w_RegWrite <= 1; //
					Estado <= FETCH;
				end
				
			mflo: 
				begin
					MultS <= 1; //
					w_MemToReg <= 011;
					w_RegDist <= 01; // 
					w_RegWrite <= 1;
					Estado <= FETCH;
				end
			
			Div:
				begin
					DivStart <= 1;
					Estado <= Div2;
				end
				
			Div2:
				begin
					case (DivStop)
						0: Estado <= Div2;
						1: Estado <= Div3;
					endcase
				end
			
			Div3:
				begin 
					DivMult <= 0;
					RegHigh <= 1;
					RegLow <= 1;
					Estado <= FETCH;
					//case (DIVZero)
					//	0: Estado <= FETCH;
					//	1: Estado <= Div_Zero;
					//endcase
				end
				
			Mult:
				begin
					MultStart <= 1;
					Estado <= Mult2;
				end
				
			Mult2:
				begin
					case (MultStop)
						0: Estado <= Mult2;
						1: Estado <= Mult3;
					endcase
				end
			
			Mult3:
				begin 
					DivMult <= 1;
					RegHigh <= 1;
					RegLow <= 1;
					Estado <= FETCH;
				end
			
			RTE: 
				begin
					Reset <= 0;
					w_ALUControl <= 001; // 
					w_ALUOutCtrl <= 1; // 
					w_AluSrcA <= 01; // 
					w_AluSrcB <= 011; // 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;  
					w_ReadWrite <= 0; 
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
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 00; //
					w_PCWrite <= 1; //  
					w_ReadWrite <= 0;  
					w_RegDist <= 10; 
					w_RegWrite <= 0;
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
					w_ALUControl <= 010; //
					w_ALUOutCtrl <= 1;  
					w_AluSrcA <= 00; // 
					w_AluSrcB <= 001; // 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0; 
					w_MemToReg <= 110;
					MultS <= 0;
					w_PCSrc <= 00; //
					w_PCWrite <= 1; // 
					w_ReadWrite <= 0;  
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
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;
					w_MemToReg <= 101; //
					MultS <= 0;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;  
					w_ReadWrite <= 0; 
					w_RegDist <= 01; // 
					w_RegWrite <= 1; // 
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 0;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end	
			
			// ~~~~~~~~~~~~~~~~~~~~~~  TIPO I  ~~~~~~~~~~~~~~~~~~~~~
			
			Lui : 
				begin
					Reset <= 0;
					w_ALUControl <= 001; 
					w_ALUOutCtrl <= 1; 
					w_AluSrcA <= 01; 
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0; 
					w_MemToReg <= 100; //
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_ReadWrite <= 0;
					w_RegDist <= 00; // 
					w_RegWrite <= 1; //
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end
				
			LB:
				begin 
					w_ALUControl <= 001;
					w_AluSrcA <= 11;
					w_AluSrcB <= 10;		
					w_LSControl <= 10;
					w_MDRs <= 1;
					Estado <= preLLL1;
				end
			
			LH:
				begin 
					w_ALUControl <= 001;
					w_AluSrcA <= 11;
					w_AluSrcB <= 10;		
					w_LSControl <= 01;
					w_MDRs <= 1;
					Estado <= preLLL1;
				end
			
			LW:
				begin 
					w_ALUControl <= 001;
					w_AluSrcA <= 11;
					w_AluSrcB <= 10;		
					w_LSControl <= 00;
					w_MDRs <= 1;
					Estado <= preLLL1;
				end
			
			preLLL1:
				begin 
					w_ReadWrite <= 0;
					w_IorD <= 01;
					Estado <= preLLL2;
				end
			
			preLLL2:
				begin 
					w_ReadWrite <= 0;
					w_IorD <= 01;
					Estado <= preLLL3;
				end
				
			preLLL3:
				begin 
					w_ReadWrite <= 0;
					w_IorD <= 01;
					Estado <= preLLL4;
				end
				
			preLLL4:
				begin 
					w_RegDist <= 00; 
					w_MemToReg <= 001;
					w_RegWrite <= 1;
					Estado <= FETCH;	
				end
			
			SB:
				begin 
					w_ALUControl <= 001;
					w_AluSrcA <= 11;
					w_AluSrcB <= 10;		
					w_SSControl <= 10;
					w_MDRs <= 1;
					Estado <= preSSS1;
				end
			
			SH:
				begin 
					w_ALUControl <= 001;
					w_AluSrcA <= 11;
					w_AluSrcB <= 10;		
					w_SSControl <= 01;
					w_MDRs <= 1;
					Estado <= preSSS1;
				end
			
			SW:
				begin 
					w_ALUControl <= 001;
					w_AluSrcA <= 11;
					w_AluSrcB <= 10;		
					w_SSControl <= 00;
					w_MDRs <= 1;
					Estado <= preSSS1;
				end
			
			preSSS1:
				begin 
					w_ReadWrite <= 0;
					w_IorD <= 01;
					Estado <= preSSS2;
				end
			
			preSSS2:
				begin 
					w_ReadWrite <= 1;
					w_IorD <= 01;
					Estado <= preSSS3;
				end
								
			preSSS3:
				begin 
					w_ReadWrite <= 1;
					w_IorD <= 01;
					w_WriteData <= 1;
					Estado <= preSSS4;
				end 
				
			preSSS4:
				begin 
					w_ReadWrite <= 0;
					w_IorD <= 01;
					w_WriteData <= 1;
					Estado <= FETCH;
				end 
							
			
			Addi: 
				begin
					Reset <= 0;
					w_ALUControl <= 001; // 
					w_ALUOutCtrl <= 1; //
					w_AluSrcA <= 01; //
					w_AluSrcB <= 010; // 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;  
					w_ReadWrite <= 0; 
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= posAddiAddiu;
				end
				
			Addiu: 
				begin
					Reset <= 0;
					w_ALUControl <= 001; //
					w_ALUOutCtrl <= 1; //
					w_AluSrcA <= 01; //
					w_AluSrcB <= 010; // 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_ReadWrite <= 0;
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
					w_IorD <= 0;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 000; //
					w_PCSrc <= 00; 
					w_PCWrite <= 0;   
					w_ReadWrite <= 0;
					w_RegDist <= 00; // 
					w_RegWrite <= 1; //
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end
				
			beq: 
				begin
					Reset <= 0;
					w_ALUControl <= 010; // 
					w_ALUOutCtrl <= 1; //
					w_AluSrcA <= 01; // 
					w_AluSrcB <= 000; // 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 01; // 
					w_PCWrite <= 1; //  
					w_ReadWrite <= 0; 
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end
			    
			bne: 
				begin
					Reset <= 0;
					w_ALUControl <= 010; // 
					w_ALUOutCtrl <= 1; // 
					w_AluSrcA <= 01; // 
					w_AluSrcB <= 000; // 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 01; //
					w_PCWrite <= 1; // 
					w_ReadWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end
				
			ble: 
				begin
					Reset <= 0;
					w_ALUControl <= 111; // 
					w_ALUOutCtrl <= 1; //
					w_AluSrcA <= 01; // 
					w_AluSrcB <= 000; // 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 01; // 
					w_PCWrite <= 1; //
					w_ReadWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end
				
			bgt: 
				begin
					Reset <= 0;
					w_ALUControl <= 111; // 
					w_ALUOutCtrl <= 1; //
					w_AluSrcA <= 01; // 
					w_AluSrcB <= 000; // 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;  
					w_MemToReg <= 110;
					w_PCSrc <= 01; // 
					w_PCWrite <= 1; //
					w_ReadWrite <= 0;   
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end
				
			// ~~~~~~~~~~~~~~~~~~~~~~  TIPO J  ~~~~~~~~~~~~~~~~~~~~~
			
			jump: 
				begin
					Reset <= 0;
					w_ALUControl <= 001;  
					w_ALUOutCtrl <= 1; 
					w_AluSrcA <= 01; 
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;   
					w_MemToReg <= 110;
					w_PCSrc <= 10; // 
					w_PCWrite <= 1; // 
					w_ReadWrite <= 0;  
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= FETCH;
				end
			
			preInc: 
				begin
					Reset <= 0;
					w_ALUControl <= 000; //  
					w_ALUOutCtrl <= 1; 
					w_AluSrcA <= 10; // 
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;   
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0; //
					Estado <= preIncDec;
				end
				
			preDec: 
				begin
					Reset <= 0;
					w_ALUControl <= 000; //  
					w_ALUOutCtrl <= 1; 
					w_AluSrcA <= 10; // 
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;   
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0; //
					Estado <= preIncDec;
				end
				
			preIncDec: 
				begin
					Reset <= 0;
					w_ALUControl <= 000;  
					w_ALUOutCtrl <= 1; 
					w_AluSrcA <= 10; 
					w_AluSrcB <= 011; 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 1; //   
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					case (OPCode)
						6'b010000: Estado <= inc; //0x10
						6'b010001: Estado <= dec; // 0x11
					endcase
				end
				
			inc: 
				begin
					Reset <= 0;
					w_ALUControl <= 001; //  
					w_ALUOutCtrl <= 1; 
					w_AluSrcA <= 11; // 
					w_AluSrcB <= 100; // 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 1;  
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= posIncDec;
				end
				
					
			dec: 
				begin
					Reset <= 0;
					w_ALUControl <= 010; //  
					w_ALUOutCtrl <= 1; 
					w_AluSrcA <= 11; // 
					w_AluSrcB <= 100; // 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 1;   
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
					w_RegDist <= 10; 
					w_RegWrite <= 0;
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= posIncDec;
				end		
				
			jal: 
				begin
					Reset <= 0;
					w_ALUControl <= 000; //  
					w_ALUOutCtrl <= 0; // 
					w_AluSrcA <= 00; // 
					w_AluSrcB <= 000; 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;   
					w_MemToReg <= 110;
					w_PCSrc <= 00; 
					w_PCWrite <= 0; 
					w_ReadWrite <= 0;  
					w_RegDist <= 10; 
					w_RegWrite <= 0; 
					w_ShiftAmt <= 0;
					w_ShiftCrtl <= 000;
					w_ShiftSrc <= 0;
					w_SSControl <= 00;
					w_WriteData <= 0;
					Estado <= posJal ;
				end
				
			posJal: 
				begin
					Reset <= 0;
					w_ALUControl <= 000;   
					w_ALUOutCtrl <= 0; 
					w_AluSrcA <= 00;
					w_AluSrcB <= 001;// 
					w_EPCControl <= 00;
					w_IorD <= 00;
					w_IRWrite <= 0;
					w_LSControl <= 00; 
					w_MDRs <= 0;   
					w_MemToReg <= 000; //
					w_PCSrc <= 10; // 
					w_PCWrite <= 1; // 
					w_ReadWrite <= 0;  
					w_RegDist <= 10; // 31
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
    
