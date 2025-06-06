module CPU_tb();

	logic clk, rst;
	logic [31:0] inst, PC;
	
	CPU dut (
		.clk(clk),
		.rst(rst),
		.inst(inst),
		.PC(PC)
	);
	
	always #5 clk = ~clk;
	
	initial begin
		clk = 0;
		rst = 1;
		#5;
		rst = 0;
		
		inst = 32'he3550010;
		
		#10;
		
		inst = 32'hba000010;
		
		#10;
		$stop;
	end
endmodule
