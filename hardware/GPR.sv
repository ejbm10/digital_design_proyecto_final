module GPR (
	input logic clk,
	input logic rst,
	input logic en,
	input logic [31:0] D,
	output logic [31:0] Q
);

	always_ff @(negedge clk or posedge rst) begin
		if (rst) Q <= 32'h0;
		else if (en) Q <= D;
	end

endmodule
