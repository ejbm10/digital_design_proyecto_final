module ROM (
	input logic clk,
	input logic rst,
	input logic [31:0] PC,
	output logic [31:0] inst
);
	
	logic [31:0] instruction_set [0:6];
	
	initial begin
		instruction_set[0] = 32'hE3A02005;	// MOV R2, #5
		instruction_set[1] = 32'hE3A03008;	// MOV R3, #8
		instruction_set[2] = 32'hE0824003;	// ADD R4, R2, R3
		instruction_set[3] = 32'hE354000D;	// CMP R4, #13
		instruction_set[4] = 32'h1A00002A;	// BNE [OFFSET RARO]
		instruction_set[5] = 32'hE354000D;	// CMP R4, #13
		instruction_set[6] = 32'h0A00002A;	// BEQ [OFFSET RARO]
	end
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			inst <= 32'h0;
		else if (PC >> 2 < 7)
			inst <= instruction_set[PC >> 2];
	end
	
endmodule
