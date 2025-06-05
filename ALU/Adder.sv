module Adder (
    input logic [31:0] A,
    input logic [31:0] B,
    output logic [31:0] S,
    output logic cout
);

	logic [32:0] sum;
	
	assign sum = A + B;
	assign S = sum[31:0];
	assign cout = sum[32];

endmodule
