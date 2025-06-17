`timescale 1ns/1ps

module snake_tb();

    logic clk;
    logic reset;
    logic hsync, vsync;
    logic [7:0] r, g, b;
    logic [9:0] x, y;
    logic blank_b;

    // Generación de clock: 50 MHz (20 ns periodo)
    initial clk = 0;
    always #10 clk = ~clk;

    // Reset inicial
    initial begin
        reset = 1;
        #100;
        reset = 0;
    end

    // Instancia del top 
    snake_top uut (
        .clk(clk),
        .reset(reset),
        .hsync(hsync),
        .vsync(vsync),
        .r(r),
        .g(g),
        .b(b),
        .x(x),
        .y(y),
        .blank_b(blank_b)
    );

    // Imprime la cuadrícula en consola cada celda 1x1
    // Cada celda está centrada en la pantalla
    localparam X_OFFSET = (640 - 100) / 2; // 270
    localparam Y_OFFSET = (480 - 100) / 2; // 190

    initial begin
        integer i, j;
        // Espera a que termine el reset
        #150;

        for (j = 0; j < 100; j = j + 1) begin
            for (i = 0; i < 100; i = i + 1) begin
                // Asigna la posición de cada celda
                force uut.x = X_OFFSET + i;
                force uut.y = Y_OFFSET + j;
                force uut.blank_b = 1'b1;
                #1;
                if (r == 8'h00 && g == 8'h00 && b == 8'h00)
                    $write("#");
                else
                    $write(" ");
            end
            $write("\n");
        end
        $finish;
    end

endmodule