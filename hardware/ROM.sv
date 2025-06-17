module ROM (
	input logic clk,
	input logic rst,
	input logic [31:0] PC,
	output logic [31:0] inst
);
	
	logic [31:0] instruction_set [0:4];
	
	initial begin
		instruction_set[0] = 32'hE3A02005;	// MOV R2, #5
		instruction_set[1] = 32'hE52D2004;	// PUSH
		instruction_set[2] = 32'hE52D2004;	// PUSH
		instruction_set[3] = 32'hE49D3004;	// POP a R3
		instruction_set[4] = 32'hE49D4004;	// POP a R4
	
	end
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			inst <= 32'h0;
		else if (PC >> 2 < 5)
			inst <= instruction_set[PC >> 2];
	end
	
endmodule
