module Multiplier (
    input logic [31:0] A, B,
    output logic [31:0] result
);

	logic [63:0] acc;
	
always_comb begin
    acc = 64'h0;
    for (int i = 0; i < 32; i++) begin
        if (B[i])
            acc = acc + (A << i);
    end
	 result = acc[31:0]; 
end

endmodule
