module RAM (
	input logic clk,
	input logic rst,
	input logic MemWrite,
	input logic [31:0] A,
	input logic [31:0] WriteData,
	input logic [31:0] uart_data



	output logic [31:0] ReadData
);

	logic [31:0] MemorySpace [0:99];
	logic [31:0] Stack [0:9];
	
	always_comb begin

		if (A >= 32'h1000 && A < 32'h1190)
			ReadData = MemorySpace[(A - 32'h1000) >> 2];
		else if (A <= 32'hFFFFFFFC)
			ReadData = Stack[(32'hFFFFFFFC - A) >> 2];
		else if (A == 32'h1200) begin
			ReadData = uart_data;
		end else begin
			ReadData = 32'hFFFFFFFF;
		end
	end
	
	always_ff @(negedge clk or posedge rst) begin
		if (rst) begin
			for (int i = 0; i < 100; i++) begin
				MemorySpace[i] <= 32'h0;
			end
			for (int i = 0; i < 10; i++) begin
				Stack[i] <= 32'h0;
			end
		end
		else if (MemWrite && A >= 32'h1000 && A < 32'h1190)
			MemorySpace[(A - 32'h1000) >> 2] <= WriteData;
		else if (MemWrite && A <= 32'hFFFFFFFC)
			Stack[(32'hFFFFFFFC - A) >> 2] <= WriteData;
	end
	
	
	
endmodule
