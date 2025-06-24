`timescale 1 ps / 1 ps
module RegisterFile_tb();
	
	logic clk, rst, RegWrite;
	logic [3:0] A1, A2, WriteReg;
	logic [31:0] ALUResult, R1, R2;
	
	RegisterFile dut (
		.clk(clk),
		.rst(rst),
		.A1(A1),
		.A2(A2),
		.WriteReg(WriteReg),
		.ALUResult(ALUResult),
		.RegWrite(RegWrite),
		.R1(R1),
		.R2(R2)
	);
	
	always #5 clk = ~clk;
	
	initial begin
		clk = 0;
		rst = 1;
		RegWrite = 0;
		WriteReg = 4'b0010;
		A1 = 4'b0010;
		A2 = 4'b0111;
		ALUResult = 32'hF;
		#10;
		rst = 0;
		
		#1000;
		
		RegWrite = 1;
		
		#1000;
	end
endmodule
