module ALU (
    input  logic [31:0] A, B,
    input  logic [2:0] ALUControl,
    output logic [31:0] ALUResult,
    output logic N, Z, C, V
);

logic [31:0] addResult, subResult, mulResult, andResult, orResult, shiftResult;
logic sum_cout, sub_cout;

assign andResult = A & B;
assign orResult  = A | B;

Adder adder (
    .A(A),
    .B(B),
    .S(addResult),
    .cout(sum_cout)
);

Subtractor subtractor (
    .A(A),
    .B(B),
    .S(subResult),
    .bout(sub_bout),
	 .N(N)
);

Multiplier multiplier (
	.A(A),
	.B(B),
	.result(mulResult)
);

ShiftLeft shift (
	.A(A),
	.B(B),
	.result(shiftResult)
);

always_comb begin
    case (ALUControl)
        3'b000: ALUResult = andResult;              // AND
        3'b001: ALUResult = orResult;               // OR
        3'b010: ALUResult = addResult;   				 // ADD
        3'b110: ALUResult = subResult;   				 // SUB
		  3'b101: ALUResult = mulResult;					 // MUL
		  3'b100: ALUResult = shiftResult;
        default: ALUResult = 0;
    endcase
end

// Flags
assign Z = (ALUResult == 0);
assign C = (ALUControl == 3'b010) ? sum_cout :
           (ALUControl == 3'b110) ? sub_cout : 1'b0;
assign V = ((ALUControl == 3'b010) && (A[31] == B[31]) && (ALUResult[31] != A[31])) ||
           ((ALUControl == 3'b110) && (A[31] != B[31]) && (ALUResult[31] != A[31]));

endmodule
