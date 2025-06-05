module Multiplexor (
	input logic [31:0] A,
	input logic [31:0] B,
	input logic S,
	output logic [31:0] Y
);

	assign Y = S ? A : B;
	
endmodule
