module RAM (
	input logic clk,
	input logic rst,
	input logic mem_write,
	input logic [31:0] address,
	input logic [31:0] mem_in,
	output logic [31:0] mem_out
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
		
	end
	
	always_ff @(negedge clk or posedge rst) begin
		if (rst) begin
			mem_out <= 32'h0;
			for (int i = 0; i < 100; i++) begin
				board[i] <= 32'h0;
			end
		end
		else if (mem_write && address >= 32'h1000 && address < 32'h1190) begin
			board[addr_index] <= mem_in;
		end
		else if (mem_read && address >= 32'h1000 && address < 32'h1190) begin
			mem_out <= board[addr_index];
		end
	end
	
endmodule
