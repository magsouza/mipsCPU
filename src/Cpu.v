
module Cpu (
	input wire clock, input wire reset, output wire[31:0] w_PC , output wire[6:0] Estado , output wire [31:0]w_ULAout_out
);

//wire [31:0]w_PC;
wire [31:0]w_Result;
//wire [31:0]w_ULAout_out;
wire [31:0]w_SS;
wire [31:0]w_LS;
wire [31:0]w_ShiftReg_out;
wire [31:0]w_regA_out;
wire [31:0]w_regB_out;
wire [31:0]w_MemData_out;
wire [31:0]w_MemDataReg;
wire [31:0]w_Shiftleft2_out;
wire [31:0]w_ShiftLeft2Concat_out;
wire [31:0]w_Shiftleft16_out;
wire [31:0]w_SignExtend1to32_out;
wire [31:0]w_SignExtend16to32_out;
wire [31:0]w_SignExtend26to32_out;
wire [31:0]w_EPC_out;

wire [31:0]w_MUX1;
wire [31:0]w_MUX2;
wire [31:0]w_MUX3;
wire [4:0]w_MUX4; //saida do mux sao apenas 5 bits
wire [31:0]w_MUX5;
wire [31:0]w_MUX6;
wire [31:0]w_MUX7;
wire [31:0]w_MUX10;
wire [31:0]w_MUX11;

wire [15:0]w_instr15_0;
wire [5:0]w_opcode;
wire [4:0]w_rt;
wire [4:0]w_rs;
assign rd = w_instr15_0[15-11];
assign funct = w_instr15_0[5-0]; // IIIIIIGU ISSO AQ É FUNCT

wire [2:0]MemtoReg;
wire [2:0]w_ALUSrcB;
wire [2:0]w_ULAcontrol;

wire [1:0]IorD;
wire [1:0]ExcpCtrl;
wire [1:0]RegDist;
wire [1:0]w_ALUSrcA;
wire [1:0]w_PCSrc;

wire LoadA;
wire LoadB;
wire ALUOutCtrl;
wire EPCControl;
wire WriteData;
wire PCWrite;
wire MemRead;
wire IRwrite;
wire RegWrite;
wire w_overflow;
wire w_negativo;
wire w_ZERO;
wire w_EG;
wire w_GT;
wire w_LT;

//comeÃ§o dos mux

MUXIR mux1(//ok
	.muxFlag(IorD),
	.w_muxIn0(w_PC),
	.w_muxIn1(w_ALUResult),
	.w_muxIn2(w_ULAout_out),
	.w_muxIn3(w_MUX2),
	.w_muxOut(w_MUX1)
);

MUX3 mux2(//ok
	.muxFlag(ExcpCtrl),
	.w_muxIn0(32'd253),
	.w_muxIn1(32'd254),
	.w_muxIn2(32'd255),
	.w_muxOut(w_MUX2)
			
);

MUX2 mux3(//ok
	.muxFlag(WriteData),
	.w_muxIn0(w_ALUResult),
	.w_muxIn1(w_SS),
	.w_muxOut(w_MUX3)
);

MUXIR mux4(//ok
	.muxFlag(RegDist),
	.w_muxIn0(rt),
	.w_muxIn1(rd),
	.w_muxIn2(5'd31),
	.w_muxIn3(5'd29),
	.w_muxOut(w_MUX4)			
);

MUX7 mux5(//ok
	.muxFlag(MemtoReg),
	.w_muxIn0(w_ULAout_out),
	.w_muxIn1(w_LS),
	.w_muxIn2(w_ShiftReg_out),
	.w_muxIn3(w_MUX10),
	.w_muxIn4(w_Shiftleft16_out),
	.w_muxIn5(w_SignExtend1to32_out),
	.w_muxIn6(32'd227),
	.w_muxOut(w_MUX5)
);

MUXIR mux6(//ok
	.muxFlag(w_ALUSrcA),
	.w_muxIn0(w_PC),
	.w_muxIn1(w_regA_out),
	.w_muxIn2(w_SignExtend26to32_out),
	.w_muxIn3(w_MemDataReg),
	.w_muxOut(w_MUX6)
);

MUX5 mux7(//ok
	.muxFlag(w_ALUSrcB),
	.w_muxIn0(w_regB_out),
	.w_muxIn1(32'd4),
	.w_muxIn2(w_SignExtend16to32_out),
	.w_muxIn3(w_Shiftleft2_out),
	.w_muxIn4(32'd1),
	.w_muxOut(w_MUX7)
);

MUXIR mux11(//ok
	.muxFlag(w_PCSrc),
	.w_muxIn0(w_ALUResult),
	.w_muxIn1(w_ULAout_Out),
	.w_muxIn2(w_ShiftLeft2Concat_out),
	.w_muxIn3(w_EPC_out),
	.w_muxOut(w_MUX11)
);


// fim dos mux

Registrador pc(//ok
	.Clk(clock),
	.Reset(reset),
	.Load(PCWrite),
	.Entrada(w_MUX11),
	.Saida(w_PC)
);

Registrador A(//ok
	.Clk(clock),
	.Reset(reset),
	.Load(LoadA),
	.Entrada(w_regA),
	.Saida(w_regA_out)
);

Registrador B(//ok
	.Clk(clock),
	.Reset(reset),
	.Load(LoadB),
	.Entrada(w_regB),
	.Saida(w_regB_out)
);

Memoria mem_(//ok
	.Address(w_MUX1),
	.Clock(clock),
	.Wr(MemRead),
	.Datain(w_MUX3),
	.Dataout(w_MemData_out)
);

Instr_Reg IR_(//ok
	.Clk(clock),
	.Reset(reset),
	.Load_ir(IRwrite),
	.Entrada(w_MemData_out),
	.Instr31_26(w_opcode),
	.Instr25_21(w_rs),
	.Instr20_16(w_rt),
	.Instr15_0(w_instr15_0)
);

Banco_reg Bancoreg_(//ok
	.Clk(clock),
	.Reset(reset),
	.RegWrite(RegWrite),
	.ReadReg1(w_rs),
	.ReadReg2(w_rt),
	.WriteReg(w_MUX4),
	.WriteData(w_MUX5),
	.ReadData1(w_regA),
	.ReadData2(w_regB)
);

ula32 ula(//ok
	.A(w_MUX6),
	.B(w_MUX7),
	.Seletor(w_ULAcontrol),
	.S(w_ALUResult),
	.Overflow(w_overflow),
	.Negativo(w_negativo),
	.z(w_ZERO),
	.Igual(w_EG),
	.Maior(w_GT),
	.Menor(w_LT)	
);

Registrador ALUout_(
	.Clk(clock),
	.Reset(reset),
	.Load(ALUOutCtrl),
	.Entrada(w_ALUResult),
	.Saida(w_ULAout_Out)
);

Control Controline(  // ~~~~~~ grande contribuição de lhine a essa incrivel cpu ~~~~~~~
	.OPCode(w_opcode),
	.Funct(funct),
	.Clock(clock),
	.w_PCWrite(PCWrite),
	.w_IorD(IorD),
	.w_MemRead(MemRead),
	.w_WriteData(WriteData),
	.w_MemToReg(MemtoReg),
	.w_RegDist(RegDist),
	.w_AluSrcA(w_ALUSrcA),
	.w_AluSrcB(w_ALUSrcB),
	.w_RegWrite(RegWrite),
	.w_ALUControl(w_ULAcontrol), // pensamento do dia : pq diabos ta como ula na declaracao? 
	.w_ALUOutCtrl(ALUOutCtrl),
	.w_EPCControl(EPCControl), // tbm nao entendo o pq de alguns terem w e outros nao. sigamos.
	.w_PCSrc(w_PCSrc),
	.w_IRWrite(IRwrite),
	.Estado(Estado)
	//.Reset(reset) erro em NET RESET : como so aq o reset é output, da merda
);

 // ~~~~~~~~~~ ate aq mermo ~~~~~~~~~~
 
Registrador EPC_(
	.Clk(clock),
	.Reset(reset),
	.Load(EPCControl),
	.Entrada(w_ALUResult),
	.Saida(w_EPC_out)
);

endmodule