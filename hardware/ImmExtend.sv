module ImmExtend (
    input logic [11:0] imm_in,
    output logic [31:0] imm_out
);
    logic [7:0] imm8;
    logic [3:0] rotate_imm;
    logic [4:0] rot_amount;

    always_comb begin
        imm8 = imm_in[7:0];
        rotate_imm = imm_in[11:8];
        rot_amount = rotate_imm << 1;

        imm_out = (32'(imm8) >> rot_amount) | (32'(imm8) << (32 - rot_amount));
    end
endmodule


	
	

