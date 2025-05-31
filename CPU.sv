module CPU (
	input logic clk,
	input logic rst
);

	GPR r0 (
		.clk(clk),
		.rst(rst),
		.D(),
		.Q()
	);
	
	GPR r1 (
		.clk(clk),
		.rst(rst),
		.D(),
		.Q()
	);
	
	GPR r2 (
		.clk(clk),
		.rst(rst),
		.D(),
		.Q()
	);
	
	GPR r3 (
		.clk(clk),
		.rst(rst),
		.D(),
		.Q()
	);
	
	GPR r4 (
		.clk(clk),
		.rst(rst),
		.D(),
		.Q()
	);
	
	GPR r5 (
		.clk(clk),
		.rst(rst),
		.D(),
		.Q()
	);
	
	GPR r6 (
		.clk(clk),
		.rst(rst),
		.D(),
		.Q()
	);
	
	GPR r7 (
		.clk(clk),
		.rst(rst),
		.D(),
		.Q()
	);
	
	GPR r8 (
		.clk(clk),
		.rst(rst),
		.D(),
		.Q()
	);
	
	GPR r9 (
		.clk(clk),
		.rst(rst),
		.D(),
		.Q()
	);
	
	GPR r10 (
		.clk(clk),
		.rst(rst),
		.D(),
		.Q()
	);
	
	GPR r11 (
		.clk(clk),
		.rst(rst),
		.D(),
		.Q()
	);
	
	GPR r12 (
		.clk(clk),
		.rst(rst),
		.D(),
		.Q()
	);
	
	SPR sp (
		.clk(clk),
		.rst(rst),
		.en(1),
		.D(),
		.Q()
	);
	
	SPR lr (
		.clk(clk),
		.rst(rst),
		.en(1),
		.D(),
		.Q()
	);
	
	SPR pc (
		.clk(clk),
		.rst(rst),
		.en(1),
		.D(),
		.Q()
	);
	
endmodule
