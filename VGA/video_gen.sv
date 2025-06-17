module video_gen(
    input  logic [9:0] x,            
    input  logic [9:0] y,            
    input  logic blank_b,            
    output logic [7:0] r, g, b        
);

    // Parámetros de cuadrícula
    localparam CELL_SIZE = 1;                   // Tamaño de celda 1x1 píxel
    localparam GRID_CELLS = 100;                // 
    localparam GRID_PIXELS = GRID_CELLS * CELL_SIZE;   // Total de píxeles de la cuadrícula
    localparam X_OFFSET = (640 - GRID_PIXELS) / 2;     // Central horixontal
    localparam Y_OFFSET = (480 - GRID_PIXELS) / 2;     // Centrar cuadricula verticalmente

    // Definición de colores
    localparam [7:0] BG_GRAY = 8'hCC; // Color gris claro para el fondo
    localparam [7:0] LINE_BLACK = 8'h00; // Color negro para las líneas de la cuadrícula

    always_comb begin
        r = 8'h00; g = 8'h00; b = 8'h00;         // Inicializa los colores a negro
        if (blank_b) begin                       // Si la señal de blanking está activa
            if (x >= X_OFFSET && x < X_OFFSET + GRID_PIXELS &&
                y >= Y_OFFSET && y < Y_OFFSET + GRID_PIXELS) begin // Si el pixel está dentro de la cuadrícula

                // Si está sobre una línea de celda 
                if (((x - X_OFFSET) % CELL_SIZE == 0) || ((y - Y_OFFSET) % CELL_SIZE == 0)) begin
                    r = LINE_BLACK;              // Pone el color negro en R
                    g = LINE_BLACK;              // Pone el color negro en G
                    b = LINE_BLACK;              // Pone el color negro en B
                end else begin
                    r = BG_GRAY;                 // Si no, color gris claro en R,G,B
                    g = BG_GRAY;                 
                    b = BG_GRAY;                 
                end
            end
        end
    end
endmodule