module UartReceiverWithExtend (
    input logic clk,
    input logic rst_n,
    input logic rx,
    output logic [31:0] uart_data,
    output logic uart_ready
);

    wire [7:0] rx_data;
    wire rx_valid;

    // UART Receiver
    uartRX receiver (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .data(rx_data),
        .valid(rx_valid)
    );

    // Extend to 32 bits
    ByteExtend extender (
        .byte_in(rx_data),
        .byte_out(uart_data)
    );

    // Flag: nueva data válida
    logic prev_rx_valid;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            uart_ready <= 0;
            prev_rx_valid <= 0;
        end else begin
            prev_rx_valid <= rx_valid;
            uart_ready <= rx_valid && !prev_rx_valid;
        end
    end

endmodule
