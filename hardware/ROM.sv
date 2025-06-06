module ROM (
	input logic clk,
	input logic rst,
	input logic [31:0] PC,
	output logic [31:0] inst
);
	
	logic [31:0] instruction_set [0:3];
	
	initial begin
		instruction_set[0] = 32'hE3A02005;
		instruction_set[1] = 32'hE3A03008;
		instruction_set[2] = 32'hE0834005;
		instruction_set[3] = 32'hEA00002A;
	end
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			inst <= 32'h0;
		else if (PC >> 2 < 4)
			inst <= instruction_set[PC >> 2];
	end
	
endmodule
