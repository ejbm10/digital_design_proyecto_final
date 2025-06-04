module CPU (
	input logic clk,
	input logic rst,
	input logic ldr,
	input logic str,
	input logic reg_write_enable,
	input logic [31:0] immediate,
	output logic [31:0] r0_value
);
	
	logic [31:0] data_in, data_out, ram_address;
	logic [3:0] reg_sel;
	logic [15:0] reg_we;
	
	RAM mem0 (
		.clk(clk),
		.rst(rst),
		.ldr(ldr),
		.str(str),
		.address(ram_address),
		.mem_in(data_in),
		.mem_out(data_out)
	);
	
	GPR r0 (
		.clk(clk),
		.rst(rst),
		.en(reg_we[0]),
		.D(immediate),
		.Q(r0_value),
	);
	
	assign reg_we = reg_write_enable ? (16'b1 << reg_sel) : 16'b0;
	
endmodule
