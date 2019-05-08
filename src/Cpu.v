module CPU (
	input wire clock, input wire reset
);

wire [31:0]w_ALUOut;
wire [31:0]Aout;
wire [31:0]Bout;
wire [31:0]PCWrite;
wire [31:0]w_PC;
wire [31:0]w_ALUResult;
wire [31:0]WriteData;
wire [31:0]MemData;
wire [31:0]w_SS;
wire [31:0]w_regA;
wire [31:0]w_regB;
wire [31:0]w_aluInA;
wire [31:0]w_aluInB;
wire [31:0]w_MUX1;
wire [31:0]w_MUX2;
wire [31:0]w_MUX3;
wire [31:0]w_MUX4;
wire [31:0]w_MUX5;
wire [31:0]w_MUX6;
wire [31:0]w_MUX10;
wire [31:0]w_MUX11;
wire [31:0]w_MemDataReg;
wire [31:0]w_SignExtend2632;
wire [31:0]w_SignExtend1632;
wire [31:0]w_Shiftleft2;
wire [31:0]w_ULAout_Out;
wire [31:0]w_MemToReg;
wire [31:0]w_LS;
wire [31:0]w_ShiftReg;
wire [31:0]w_MemToReg;
wire [31:0]w_Shiftleft16;
wire [31:0]w_SignExtend132;
wire [31:0]w_ShiftLeft2Concat;
wire [31:0]w_EPC;

wire [15:0]imediato;

wire [5:0]opcode;

wire [4:0]rs;
wire [4:0]rt;

wire [2:0]w_ULAcontrol;

wire [1:0]PCWrite;
wire [1:0]w_PCSrc;
wire [1:0]Load;
wire [1:0]IorD;
wire [1:0]IRwrite;
wire [1:0]RegWrite;
wire [1:0]w_MemToReg;
wire [1:0]w_ALUSrcA;
wire [1:0]w_ALUSrcB;
wire [1:0]w_overflow;
wire [1:0]w_negativo;
wire [1:0]w_ZERO;
wire [1:0]w_EG;
wire [1:0]w_GT;
wire [1:0]w_LT;
			
MUX1 mux1(
			IorD, 
			w_PC, 
			w_ALUResult, 
			w_ALUOut, 
			w_MUX2,
			w_MUX1
);

MUX3 mux3(
			WriteData, 
			w_ALUResult, 
			w_SS, 
			w_MUX3, 
);

MUX5 mux5(
			w_MemToReg, 
			w_ULAout_Out, 
			w_LS, 
			w_ShiftReg,
			w_MUX10,
			w_Shiftleft16,
			w_SignExtend132,
			.const227(32'd227),
			w_MUX5
);

MUX6 mux6(
			w_ALUSrcA, 
			w_PC, 
			w_aluInA, 
			w_SignExtend2632,
			w_MemDataReg,
			w_MUX6
);

MUX7 mux7(
			w_ALUSrcB, 
			w_aluInB,
			.const4(32'd4), 
			w_SignExtend1632,
			w_Shiftleft2,
			.const1(32'd1)
			w_MUX7
);

MUX11 mux11(
			w_PCSrc,
			w_ALUResult,
			w_ULAout_Out,
			w_ShiftLeft2Concat,		
			w_EPC,
			w_MUX11
);

Memoria mem_(
			w_MUX1,
			clock,
			WriteData,
			w_MUX3,
			MemData
);

Instr_Reg IR_(
			clock,
			reset,
			IRwrite,
			MemData,
			opcode,
			rs,
			rt,
			imediato	
);

Banco_reg Bancoreg_(
			clock,
			reset,		
			RegWrite,	
			rs,	
			rt,	
			w_MUX4,//writedata	
			w_MUX5,//data_in 	
			w_regA,	
			w_regB	
);

Registrador A(
			clock,
			reset,
			Load,
			w_regA,
			w_aluInA	
);

Registrador B(
			clock,
			reset,
			Load,
			w_regB,
			w_aluInB	
);

Registrador ALUout_(
			clock,
			reset,
			Load,
			w_ALUResult,
			w_ULAout_Out	
);

Registrador pc(
			clock,
			reset,
			PCWrite,
			w_MUX11,
			w_PC	
);

ula32 ula(
			w_MUX6,
			w_MUX7,
			w_ULAcontrol,
			w_ALUResult,
			w_overflow,
			w_negativo,
			w_ZERO,
			w_EG,
			w_GT,
			w_LT		
);