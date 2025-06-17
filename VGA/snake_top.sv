module snake_top(
    input  logic clk,    // Clock principal de 50 MHz
    input  logic reset,
    output logic hsync,
    output logic vsync,
    output logic [7:0] r, g, b,
    output logic [9:0] x, y,      
    output logic blank_b          
);

    logic vgaclk;
    logic sync_b;

    // --- Divisor para 25MHz (VGA) ---
    clkdiv_25mhz clkdiv(
        .clk_in(clk),
        .reset(reset),
        .clk_out(vgaclk)
    );

    // --- VGA controller ---
    vga_controller vga_ctrl(
        .vgaclk(vgaclk),
        .reset(reset),
        .hsync(hsync),
        .vsync(vsync),
        .sync_b(sync_b),
        .blank_b(blank_b),
        .x(x),
        .y(y)
    );

    // --- Solo la cuadrícula ---
    video_gen vgagen(
        .x(x),
        .y(y),
        .blank_b(blank_b),
        .r(r),
        .g(g),
        .b(b)
    );
endmodule