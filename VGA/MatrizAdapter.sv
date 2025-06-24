module MatrizAdapter(
    input logic clk,
    input logic rst,
    input logic [31:0] adapter_data,
    output logic [10:0] adapter_addr,
    output logic [3:0] matriz [9:0][9:0]
);

    int index;
    int fila;
    int col;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            index <= 0;
        end else begin
            fila = index / 10;
            col  = index % 10;
            matriz[fila][col] <= adapter_data[3:0];

            if (index == 99)
                index <= 0;
            else
                index <= index + 1;
        end
    end

    assign adapter_addr = index;

endmodule
