module RAM_tb();
	
	logic clk, rst, r, w;
	logic [31:0] address, mem_in, mem_out;
	
	RAM dut (
		.clk(clk),
		.rst(rst),
		.r(r),
		.w(w),
		.address(address),
		.mem_in(mem_in),
		.mem_out(mem_out)
	);
	
	always #5 clk = ~clk;
	
	initial begin
		clk = 0;
		rst = 0;
		r = 0;
		w = 0;
		
		address = 32'h1000;
		mem_in = 32'h0;
		
		#100;
		
		w = 1;
		mem_in = 32'h13FF;
		
		#100;
		
		address = 32'h1004;
		mem_in = 32'h100;
		
		#100;
		
		address = 32'h1000;
		r = 1;
		w = 0;
		
		#100;
		
		address = 32'h1004;
		
		#100;
		
		r = 0;
		
		#100;
	end

endmodule

		