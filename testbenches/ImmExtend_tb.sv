`timescale 1 ps / 1 ps
module ImmExtend_tb();

	logic [11:0] imm_in;
	logic [31:0] imm_out;
	
	ImmExtend dut (
		.imm_in(imm_in),
		.imm_out(imm_out)
	);
	
	initial begin
		imm_in = 12'ha01;
		
		#100;
		
		imm_in = 12'h009;
		
		#100;
	end
endmodule
