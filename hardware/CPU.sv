module CPU (
	input logic clk,
	input logic rst,
	input logic [31:0] inst,
	output logic [31:0] PC
);
	
	logic MemToReg, MemWrite, ALUSrc, RegDst, RegWrite, PCSrc; 
	
	logic branch, beq, bne, bgt, blt, bge, ble;
	
	logic n_flag, z_flag;
	
	logic n_temp, z_temp;
	
	logic [31:0] WriteReg, R1, R2, R3, A, ReadData, ALUResult; 
	
	logic [31:0] mem_mux, alu_mux, imm_mux, imm_out, offset_out;
	
	logic [2:0] ALUControl;
	
	ControlUnit c1 (
		.opcode(inst[31:20]),
		.MemToReg(MemToReg),
		.MemWrite(MemWrite),
		.branch(branch),
		.beq(beq),
		.bne(bne),
		.bgt(bgt),
		.blt(blt),
		.bge(bge),
		.ble(ble),
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
		.A(ALUResult),
		.WriteData(R3),
		.ReadData(ReadData)
	);
	
	ALU c4 (
		.A(R1),
		.B(imm_mux),
		.ALUControl(ALUControl),
		.ALUResult(ALUResult),
		.N(n_temp),
		.Z(z_temp),
		.C(),
		.V()
	);
	
	ImmExtend c5 (
		.imm_in(inst[11:0]),
		.imm_out(imm_out)
	);
	
	SignExtend c6 (
		.offset(inst[23:0]),
		.offset_out(offset_out)
	);
	
	assign imm_mux = RegDst ? imm_out : R2;
	assign alu_mux = ALUSrc ? ALUResult : imm_mux;
	assign mem_mux = MemToReg ? ReadData : alu_mux;
	
	assign PCSrc = branch | 
						(beq & z_flag) | 
						(bne & ~z_flag) | 
						(bgt & ~n_flag) | 
						(blt & n_flag) | 
						(bge & (~n_flag | z_flag)) |
						(ble & (n_flag | z_flag));
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst) begin
			z_flag <= 0;
			n_flag <= 0;
		end
		else begin
			z_flag <= z_temp;
			n_flag <= n_temp;
		end
	end
	
	always_ff @(negedge clk or posedge rst) begin
		if (rst)
			PC <= 0;
		else if (PCSrc & (ALUControl == 3'b010))
			PC <= PC + 8 + offset_out;
		else if (PCSrc & (ALUControl == 3'b110))		
			PC <= PC + 8 - offset_out;
		else
			PC <= PC + 4;
	end
	
endmodule
