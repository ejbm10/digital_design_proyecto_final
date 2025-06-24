`timescale 1 ps / 1 ps
module CPU_tb();

	logic clk, rst;
	
	CPU dut (
		.clk(clk),
		.rst(rst)
	);
	
	always #5 clk = ~clk;
	
	initial begin
		rst = 1;
		#10;
		rst = 0;
		clk = 0;
		
		#1000;
		
		$stop;
	end
endmodule
