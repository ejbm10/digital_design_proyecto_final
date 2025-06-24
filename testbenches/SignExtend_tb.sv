`timescale 1 ps / 1 ps
module SignExtend_tb();

	logic [23:0] offset;
	logic [31:0] offset_out;
	
	SignExtend dut (
		.offset(offset),
		.offset_out(offset_out)
	);
	
	initial begin
		offset = 24'h00000A;
		
		#500;
		
		offset = 24'hFFFFEF;
		
		#500;
		
		$stop;
	end
	
endmodule
