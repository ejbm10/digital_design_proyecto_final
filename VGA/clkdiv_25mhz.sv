module clkdiv_25mhz(
    input  logic clk_in,  // 50 MHz
    input  logic reset,
    output logic clk_out  // 25 MHz
);

    logic toggle;

    always_ff @(posedge clk_in or posedge reset) begin
        if (reset)
            toggle <= 0;
        else
            toggle <= ~toggle;
    end

    assign clk_out = toggle;
endmodule