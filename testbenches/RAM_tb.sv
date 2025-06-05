module RAM_tb();
	
	logic clk, rst, MemWrite;
	logic [31:0] A, WriteData, ReadData;
	
	RAM dut (
		.clk(clk),
		.rst(rst),
		.MemWrite(MemWrite),
		.A(A),
		.WriteData(WriteData),
		.ReadData(ReadData)
	);
	
	always #5 clk = ~clk;
	
	initial begin
		clk = 0;
		MemWrite = 0;
		A = 32'h1000;
		WriteData = 32'h0;
		rst = 1;
		#10;
		rst = 0;
		
		#500;
		
		MemWrite = 1;
		WriteData = 32'h13FF;
		
		#10; 
		MemWrite = 0;
		#10;
		
		
		A = 32'h1004;
		MemWrite = 1;
		WriteData = 32'h100;
		
		#10;
		MemWrite = 0;
		#10;
		
		
		A = 32'h1000;
		
		#500;
		
		A = 32'h1004;
		
		#500;
	end

endmodule

		