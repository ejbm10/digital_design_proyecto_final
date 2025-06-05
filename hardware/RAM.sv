module RAM (
	input logic clk,
	input logic rst,
	input logic MemWrite,
	input logic [31:0] A,
	input logic [31:0] WriteData,
	output logic [31:0] ReadData
);

	logic [31:0] MemorySpace [0:99];
	
	always_comb begin
		if (A >= 32'h1000 && A < 32'h1190)
			ReadData = MemorySpace[(A - 32'h1000) >> 2];
		else
			ReadData = 32'hFFFF;
	end
	
	always_ff @(negedge clk or posedge rst) begin
		if (rst) begin
			for (int i = 0; i < 100; i++) begin
				MemorySpace[i] <= 32'h0;
			end
		end
		else if (MemWrite)
			MemorySpace[(A - 32'h1000) >> 2] <= WriteData;
	end
	
	
	
endmodule
