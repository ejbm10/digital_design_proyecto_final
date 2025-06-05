module Subtractor (
    input  logic [31:0] A,
    input  logic [31:0] B,
    output logic [31:0] S,
    output logic bout,
    output logic N
);

    logic [32:0] diff;

    assign diff = {1'b0, A} - {1'b0, B}; // Extend to 33 bits to catch borrow
    assign S = diff[31:0];
    assign bout = ~diff[32];            // If diff[32] == 0, then borrow occurred
    assign N = S[31];                   // MSB of result indicates negative

endmodule
