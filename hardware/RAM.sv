module RAM (
    input logic clk,
    input logic rst,
    input logic MemWrite,
    input logic [31:0] A,
    input logic [31:0] WriteData,
    input logic [31:0] uart_data,
    
    input logic [10:0] adapter_addr,
    output logic [31:0] adapter_data,
    
    output logic [31:0] ReadData,
    output logic [3:0] matriz [9:0][9:0]
);

    logic [10:0] addr_a;
    logic [31:0] q_a;
    
    assign addr_a = (A >= 32'h1000 && A < 32'h3000) ? ((A - 32'h1000) >> 2) : 11'd0;
    
    RAM2 memory (
        .address_a(addr_a),
        .address_b(adapter_addr),
        .clock(clk),
        .data_a(WriteData),
        .data_b(32'd0),
        .wren_a(MemWrite && (A >= 32'h1000 && A < 32'h3000)),
        .wren_b(1'b0),
        .q_a(q_a),
        .q_b(adapter_data)
    );
    
    logic [31:0] Stack [0:9];
	
    always_ff @(negedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < 10; i++)
                Stack[i] <= 32'h0;

            // limpiar matriz
            for (int fila = 0; fila < 10; fila++)
                for (int col = 0; col < 10; col++)
                    matriz[fila][col] <= 4'd0;

        end else begin
            if (MemWrite && A <= 32'hFFFFFFFC)
                Stack[(32'hFFFFFFFC - A) >> 2] <= WriteData;

            // actualiza matriz directamente si corresponde
            if (MemWrite && A >= 32'h1000 && A < 32'h118C) begin
                logic [10:0] addr_index;
                int fila, col;

                addr_index = (A - 32'h1000) >> 2;
                fila = addr_index / 10;
                col  = addr_index % 10;

                matriz[fila][col] <= WriteData[3:0];
            end
        end
    end

    always_comb begin
        if (A >= 32'h1000 && A < 32'h3000) begin
            ReadData = q_a;
			end
        else if (A <= 32'hFFFFFFFC)
            ReadData = Stack[(32'hFFFFFFFC - A) >> 2];
        else if (A == 32'h4000)
            ReadData = uart_data;
        else
            ReadData = 32'hFFFFFFFF;
    end

endmodule
