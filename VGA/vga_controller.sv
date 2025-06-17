module vga_controller #(
    parameter HACTIVE = 640,
    parameter HFP = 16,
    parameter HSYN = 96,
    parameter HBP = 48,
    parameter HMAX = HACTIVE + HFP + HSYN + HBP,    // 800
    parameter VACTIVE = 480,
    parameter VFP = 11,
    parameter VSYN = 2,
    parameter VBP = 32,
    parameter VMAX = VACTIVE + VFP + VSYN + VBP     // 525
)(
    input  logic vgaclk,   
    input  logic reset,
    output logic hsync,
    output logic vsync,
    output logic sync_b,
    output logic blank_b,
    output logic [9:0] x,
    output logic [9:0] y
);

    logic [9:0] x_reg = 0;
    logic [9:0] y_reg = 0;

    always_ff @(posedge vgaclk or posedge reset) begin
        if (reset) begin
            x_reg <= 0;
            y_reg <= 0;
        end else begin
            if (x_reg == HMAX - 1) begin
                x_reg <= 0;
                if (y_reg == VMAX - 1)
                    y_reg <= 0;
                else
                    y_reg <= y_reg + 1;
            end else begin
                x_reg <= x_reg + 1;
            end
        end
    end

    assign x = x_reg;
    assign y = y_reg;
    assign hsync   = ~(x_reg >= HACTIVE + HFP && x_reg < HACTIVE + HFP + HSYN);
    assign vsync   = ~(y_reg >= VACTIVE + VFP && y_reg < VACTIVE + VFP + VSYN);
    assign sync_b  = hsync & vsync;
    assign blank_b = (x_reg < HACTIVE) && (y_reg < VACTIVE);

endmodule