module CPU_tb();

	logic clk, rst;
	logic [31:0] inst;
	
	CPU dut (
		.clk(clk),
		.rst(rst),
		.inst(inst)
	);
	
	always #5 clk = ~clk;
	
	initial begin
		clk = 0;
		rst = 1;
		inst = 32'hE3A02007;
		#10;
		rst = 0;
		
		#500;
		
		inst = 32'hE1A03002;
		
		#500;
		
		$stop;
	end
endmodule
