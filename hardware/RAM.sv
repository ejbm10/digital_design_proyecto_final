module RAM (
	input logic clk,
	input logic rst,
	input logic MemWrite,
	input logic [31:0] address,
	input logic [31:0] A,
	output logic [31:0] ReadData
);

	logic [6:0] addr_index;
	logic [31:0] board [99:0];
	
	always_comb begin
		if (address >= 32'h1000 && address < 32'h1190)
			addr_index = (address - 32'h1000) >> 2;
		else
			addr_index = 0;
	end
	
	always_comb begin
		assign ReadData = board[addr_index];
	end
	
	always_ff @(negedge clk or posedge rst) begin
		if (rst) begin
			for (int i = 0; i < 100; i++) begin
				board[i] <= 32'h0;
			end
		end
		else if (MemWrite && address >= 32'h1000 && address < 32'h1190) begin
			board[addr_index] <= A;
		end
	end
	
endmodule
