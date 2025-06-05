module ControlUnit_tb();

	logic [11:0] opcode;
	logic MemToReg, MemWrite, branch, ALUSrc, RegDst, RegWrite;
	logic [2:0] ALUControl;
	
	ControlUnit dut (
		.opcode(opcode),
		.MemToReg(MemToReg),
		.MemWrite(MemWrite),
		.branch(branch),
		.ALUControl(ALUControl),
		.ALUSrc(ALUSrc),
		.RegDst(RegDst),
		.RegWrite(RegWrite)
	);
	
	initial begin
		opcode = 12'hE1A;
		#500;
		opcode = 12'hE3A;
		#500;
		opcode = 12'hE08;
		#500;
		opcode = 12'hE28;
		#500;
		opcode = 12'hE04;
		#500;
		opcode = 12'hE24;
		#500;
		opcode = 12'he15;
		#500;
		opcode = 12'he35;
		#500;
		opcode = 12'he58;
		#500;
		opcode = 12'he59;
		#500;
		opcode = 12'heaf;
		#500;
		opcode = 12'h1af;
		#500;
		opcode = 12'h0af;
		#500;
		opcode = 12'haaf;
		#500;
		opcode = 12'hbaf;
		#500;
		opcode = 12'hcaf;
		#500;
		opcode = 12'hdaf;
		#500;
	end
endmodule
