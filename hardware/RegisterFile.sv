module RegisterFile (
	input logic clk,
	input logic rst,
	input logic [3:0] A1,
	input logic [3:0] A2,
	input logic [3:0] WriteReg,
	input logic [31:0] ALUResult,
	input logic RegWrite,
	output logic [31:0] R1,
	output logic [31:0] R2
);
	
	logic en0, en1, en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12;
	logic [31:0] q [0:12];
	
	assign en0 = (WriteReg == 4'b0000) & RegWrite;
	assign en1 = (WriteReg == 4'b0001) & RegWrite;
	assign en2 = (WriteReg == 4'b0010) & RegWrite;
	assign en3 = (WriteReg == 4'b0011) & RegWrite;
	assign en4 = (WriteReg == 4'b0100) & RegWrite;
	assign en5 = (WriteReg == 4'b0101) & RegWrite;
	assign en6 = (WriteReg == 4'b0110) & RegWrite;
	assign en7 = (WriteReg == 4'b0111) & RegWrite;
	assign en8 = (WriteReg == 4'b1000) & RegWrite;
	assign en9 = (WriteReg == 4'b1001) & RegWrite;
	assign en10 = (WriteReg == 4'b1010) & RegWrite;
	assign en11 = (WriteReg == 4'b1011) & RegWrite;
	assign en12 = (WriteReg == 4'b1100) & RegWrite;
	
	assign R1 = q[A1];
	assign R2 = q[A2];
	
	
	GPR r0 (
		.clk(clk),
		.rst(rst),
		.en(en0),
		.D(ALUResult),
		.Q(q[0])
	);
	
	GPR r1 (
		.clk(clk),
		.rst(rst),
		.en(en1),
		.D(ALUResult),
		.Q(q[1])
	);
	
	GPR r2 (
		.clk(clk),
		.rst(rst),
		.en(en2),
		.D(ALUResult),
		.Q(q[2])
	);
	
	GPR r3 (
		.clk(clk),
		.rst(rst),
		.en(en3),
		.D(ALUResult),
		.Q(q[3])
	);
	
	GPR r4 (
		.clk(clk),
		.rst(rst),
		.en(en4),
		.D(ALUResult),
		.Q(q[4])
	);
	
	GPR r5 (
		.clk(clk),
		.rst(rst),
		.en(en5),
		.D(ALUResult),
		.Q(q[5])
	);
	
	GPR r6 (
		.clk(clk),
		.rst(rst),
		.en(en6),
		.D(ALUResult),
		.Q(q[6])
	);
	
	GPR r7 (
		.clk(clk),
		.rst(rst),
		.en(en7),
		.D(ALUResult),
		.Q(q[7])
	);
	
	GPR r8 (
		.clk(clk),
		.rst(rst),
		.en(en8),
		.D(ALUResult),
		.Q(q[8])
	);
	
	GPR r9 (
		.clk(clk),
		.rst(rst),
		.en(en9),
		.D(ALUResult),
		.Q(q[9])
	);
	
	GPR r10 (
		.clk(clk),
		.rst(rst),
		.en(en10),
		.D(ALUResult),
		.Q(q[10])
	);
	
	GPR r11 (
		.clk(clk),
		.rst(rst),
		.en(en11),
		.D(ALUResult),
		.Q(q[11])
	);
	
	GPR r12 (
		.clk(clk),
		.rst(rst),
		.en(en12),
		.D(ALUResult),
		.Q(q[12])
	);
	
endmodule
