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
		
		#5;
		
		inst = 32'hE3A02007;
		rst = 0;
		
		#10;
		
		inst = 32'hE1A03002;
		
		#10;
		
		inst = 32'hE0825003;
		
		#10;
		
		inst = 32'hE289800a;
		
		#10;
		
		inst = 32'hE2488004;
		
		#10;
		
		inst = 32'hE5813A01;
		
		#10;
		
		inst = 32'hE591AA01;
		
		#10;
		
		$stop;
	end
endmodule
