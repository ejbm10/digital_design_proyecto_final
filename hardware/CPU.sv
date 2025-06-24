module CPU (
	input logic clk,
	input logic rst,
	input logic rx,
	output logic [3:0] leds,
	  output logic hsync,
    output logic vsync,
    output logic [7:0] r, g, b,
    output logic blank_b,
	output logic sync_b,
	 output logic vgaclk
);
	logic cpu_clk;
	
	logic MemToReg, MemWrite, ALUSrc, RegDst, RegWrite, PCSrc, StackSrc; 
	
	logic branch, beq, bne, bgt, blt, bge, ble, link, ret;
	
	logic n_flag, z_flag;
	
	logic n_temp, z_temp;
	
	logic [31:0] WriteReg, R1, R2, R3, A, ReadData, ALUResult; 
	
	logic [31:0] mem_mux, alu_mux, imm_mux, imm_out, offset_out, stack_mux, a_mux, str_imm_mux;
	logic [31:0] mul_lsl_mux1, mul_lsl_mux2, mul_mux3, lsl_imm;
	
	logic [2:0] ALUControl;
	
	logic [31:0] inst, SP, LR, PC;
	
	logic [31:0] uart_data_ext;	
	
	logic uart_ready;
	
	logic [9:0] x = 0;
	
	 logic [9:0] y = 0;
	 
	 logic [3:0] matriz [9:0][9:0];
	
	 wire [7:0] rx_data;
    wire rx_valid;
    wire uart_busy;

    reg prev_rx_valid;
	
	ClockDivider sleeper(
		.clk_in(clk),
		.rst(rst),
		.clk_out(cpu_clk)
	);
 
	 clkIP clkdiv(
		.refclk(clk),   //  refclk.clk
		.rst(rst),      //   reset.reset
		.outclk_0(vgaclk), // outclk0.clk
		.locked()
	 );
	
	uartRX receiver (
			  .clk(clk),
			  .rst(rst),
			  .rx(rx),
			  .data(rx_data),
			  .valid(rx_valid)
		 );

	
	ControlUnit c1 (
		.opcode(inst[31:20]),
		.isLSL(inst[11:4]),
		.MemToReg(MemToReg),
		.MemWrite(MemWrite),
		.branch(branch),
		.beq(beq),
		.bne(bne),
		.bgt(bgt),
		.blt(blt),
		.bge(bge),
		.ble(ble),
		.link(link),
		.ret(ret),
		.StackSrc(StackSrc),
		.ALUControl(ALUControl),
		.ALUSrc(ALUSrc),
		.RegDst(RegDst),
		.RegWrite(RegWrite)
	);
	
	RegisterFile c2 (
		.clk(cpu_clk),
		.rst(rst),
		.A1(mul_lsl_mux1),
		.A2(mul_lsl_mux2),
		.A3(mul_mux3),
		.WD3(mem_mux),
		.RegWrite(RegWrite),
		.R1(R1),
		.R2(R2),
		.R3(R3)
	);
	
	RAM c3 (
		.clk(cpu_clk),
		.rst(rst),
		.MemWrite(MemWrite),
		.A(a_mux),
		.adapter_addr(adapter_addr),
		.WriteData((inst[15:12] == 4'b1110) ? LR : R3),
		.ReadData(ReadData),
		.uart_data(uart_data_ext),
		.adapter_data(adapter_rd),
		.matriz(matriz)
	);
	
	ROM c4 (
		.clk(cpu_clk),
		.rst(rst),
		.PC(PC),
		.inst(inst)
	);
	
	ALU c5 (
		.A(stack_mux),
		.B(imm_mux),
		.ALUControl(ALUControl),
		.ALUResult(ALUResult),
		.N(n_temp),
		.Z(z_temp),
		.C(),
		.V()
	);
	
	vga_controller vgaCont(
        .vgaclk(vgaclk), 
        .hsync(hsync), 
        .vsync(vsync), 
        .sync_b(sync_b), 
        .blank_b(blank_b), 
        .x(x), 
        .y(y)
    );
	 
	 		 // --- Solo la cuadrícula ---
	video_gen videoInst(
		 .x(x),
		 .y(y),
		 .blank_b(blank_b),
		 .matriz(matriz),
		 .r(r),
		 .g(g),
		 .b(b)
	);
	
	ImmExtend c6 (
		.imm_in(inst[11:0]),
		.imm_out(imm_out)
	);
	
	SignExtend c7 (
		.offset(inst[23:0]),
		.offset_out(offset_out)
	);
	
	ByteExtend extender (
    .byte_in(rx_data),
    .byte_out(uart_data_ext)
);
	
	assign mul_lsl_mux1 = (ALUControl == 3'b101 | ALUControl == 3'b100) ? inst[3:0] : inst[19:16];
	assign mul_lsl_mux2 = (ALUControl == 3'b101 | ALUControl == 3'b100) ? inst[11:8] : inst[3:0];
	assign mul_mux3 = (ALUControl == 3'b101) ? inst[19:16] : inst[15:12];
	
	assign lsl_imm = (ALUControl == 3'b100 & RegDst) ? inst[11:7] : imm_out;
	assign str_imm_mux = (inst[31:20] == 12'he58) ? inst[11:0] : lsl_imm;
	assign imm_mux = RegDst ? str_imm_mux : R2;
	assign alu_mux = ALUSrc ? ALUResult : imm_mux;
	assign mem_mux = MemToReg ? ReadData : alu_mux;

	
	assign stack_mux = StackSrc ? SP : R1;
	assign a_mux = (StackSrc && (ALUControl == 3'b010)) ? SP : ALUResult;
	
	assign PCSrc = branch | 
						(beq & z_flag) | 
						(bne & ~z_flag) | 
						(bgt & ~n_flag) | 
						(blt & n_flag) | 
						(bge & (~n_flag | z_flag)) |
						(ble & (n_flag | z_flag));
	
	always_ff @(posedge cpu_clk or posedge rst) begin
		if (rst) begin
			z_flag <= 0;
			n_flag <= 0;
		end
		else begin
			z_flag <= z_temp;
			n_flag <= n_temp;
		end
	end
	
	always_ff @(negedge cpu_clk or posedge rst) begin
		if (rst)
			LR <= 0;
		else if (link)
			LR <= PC;
		else if (RegWrite & inst[15:12] == 4'b1110)
			LR <= ReadData;
	end
	
	always_ff @(negedge cpu_clk or posedge rst) begin
		if (rst)
			SP <= 0;
		else if (StackSrc)
			SP <= ALUResult;
	end
	
	always_ff @(negedge cpu_clk or posedge rst) begin
		if (rst)
			PC <= 0;
		else if (PCSrc & ret)
			PC <= LR + 4;
		else if (PCSrc & (ALUControl == 3'b010))
			PC <= PC + 8 + offset_out;
		else if (PCSrc & (ALUControl == 3'b110))		
			PC <= PC + 8 - offset_out;
		else
			PC <= PC + 4;
	end
	
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            leds <= 4'b0;
            prev_rx_valid <= 1'b0;
           
        end else begin

            // byte recibido
            prev_rx_valid <= rx_valid;
				if (rx_valid && !prev_rx_valid) begin
					 case (rx_data)
							 8'h55: leds <= 4'b0001;
                    8'h44: leds <= 4'b0010;
                    8'h4C: leds <= 4'b0100;
                    8'h52: leds <= 4'b1000;
                    default: leds <= 4'b0000;					
						  endcase

				end

        end
    end
	
endmodule
