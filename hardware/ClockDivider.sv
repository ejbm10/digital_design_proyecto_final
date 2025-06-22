module ClockDivider (
  input logic clk_in,
  input logic rst,
  output logic clk_out
);
  parameter DIV = 2; // Para dividir 50 MHz a 2 Hz (ajustar según necesidad)
  logic [$clog2(DIV)-1:0] counter;

  always_ff @(posedge clk_in or posedge rst) begin
    if (rst) begin
      counter <= 0;
      clk_out <= 0;
    end else if (counter == DIV-1) begin
      counter <= 0;
      clk_out <= ~clk_out;
    end else begin
      counter <= counter + 1;
    end
  end
endmodule
