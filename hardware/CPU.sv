module CPU (
	input logic clk,
	input logic rst,
	input logic [31:0] inst
);
	
	logic MemToReg, MemWrite, branch,ALUSrc, RegDst, RegWrite;
	logic [31:0] WriteReg, R1, R2, R3, A, ReadData, ALUResult; 
	logic [31:0] mem_mux, alu_mux, imm_mux, imm_out;
	logic [2:0] ALUControl;
	
	
	ControlUnit c1 (
		.opcode(inst[31:20]),
		.MemToReg(MemToReg),
		.MemWrite(MemWrite),
		.branch(branch),
		.ALUControl(ALUControl),
		.ALUSrc(ALUSrc),
		.RegDst(RegDst),
		.RegWrite(RegWrite)
	);
	
	RegisterFile c2 (
		.clk(clk),
		.rst(rst),
		.A1(inst[19:16]),
		.A2(inst[3:0]),
		.A3(inst[15:12]),
		.WD3(mem_mux),
		.RegWrite(RegWrite),
		.R1(R1),
		.R2(R2),
		.R3(R3)
	);
	
	RAM c3 (
		.clk(clk),
		.rst(rst),
		.MemWrite(MemWrite),
		.A(A),
		.WriteData(R3),
		.ReadData(ReadData)
	);
	
	ALU c4 (
		.A(R1),
		.B(R2),
		.ALUControl(ALUControl),
		.ALUResult(ALUResult),
		.N(),
		.Z(),
		.C(),
		.V()
	);
	
	ImmExtend c5 (
		.imm_in(inst[11:0]),
		.imm_out(imm_out)
	);
	
	assign imm_mux = RegDst ? imm_out : R2;
	assign alu_mux = ALUSrc ? ALUResult : imm_mux;
	assign mem_mux = MemToReg ? ReadData : alu_mux;
	
endmodule
