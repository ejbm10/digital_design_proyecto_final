module ByteExtend (
    input logic [7:0] byte_in,
    output logic [31:0] byte_out
);

    always_comb begin
        byte_out = {24'b0, byte_in};  // Cero-extensión de 8 a 32 bits
    end

endmodule
