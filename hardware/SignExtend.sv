module SignExtend (
		input logic [23:0] offset,
		output logic [31:0] offset_out
);

	logic [23:0] abs_offset;
	
	always_comb begin
		if (offset[23])
			abs_offset = ~offset + 1;
		else
			abs_offset = offset;
			
		offset_out = {8'h00, abs_offset} << 2;
	end

endmodule
