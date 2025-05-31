module RAM (
	input logic clk,
	input logic rst,
	input logic r,
	input logic w,
	input logic [31:0] address,
	input logic [31:0] mem_in,
	output logic [31:0] mem_out
);

	logic [31:0] board_space [99:0];
	logic [6:0] addr_index;
	
	always_comb begin
		if (address >= 32'h1000 && address < 32'h1190)
			addr_index = (address - 32'h1000) >> 2;
		else
			addr_index = 0;
	end
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst) begin
			mem_out <= 32'h0;
			for (int i = 0; i < 100; i++) begin
				board_space[i] <= 32'h0;
			end
		end
		else if (w && address >= 32'h1000 && address < 32'h1190) begin
			board_space[addr_index] <= mem_in;
		end
		else if (r && address >= 32'h1000 && address < 32'h1190) begin
			mem_out <= board_space[addr_index];
		end
	end
	
endmodule
