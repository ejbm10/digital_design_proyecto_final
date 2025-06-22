module MatrizAdapter(
    input  logic clk,
    input  logic rst,
    input  logic [31:0] MemorySpace [0:2047],
    output logic [3:0] matriz [9:0][9:0]
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < 10; i++)
                for (int j = 0; j < 10; j++)
                    matriz[i][j] <= 4'd0;
        end else begin
            for (int fila = 0; fila < 10; fila++) begin
                for (int col = 0; col < 10; col++) begin
                    matriz[fila][col] <= MemorySpace[(fila * 10 + col)][3:0];  // Solo 4 bits LSB
                end
            end
        end
    end

endmodule
