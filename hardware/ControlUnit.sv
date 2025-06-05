module ControlUnit (
	input logic [11:0] opcode,
	output logic MemToReg,
	output logic MemWrite,
	output logic branch,
	output logic [2:0] ALUControl,
	output logic ALUSrc,
	output logic RegDst,
	output logic RegWrite
);
	
	always_comb begin
		case (opcode)
			12'he1a: begin // MOV (Dos registros)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				ALUControl = 3'b000;
				ALUSrc = 0;
				RegDst = 0;
				RegWrite = 1;
			end
			12'he3a: begin // MOV (Inmediato)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				ALUControl = 3'b000;
				ALUSrc = 0;
				RegDst = 1;
				RegWrite = 1;
			end
			12'he08: begin // ADD (Con registros)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				ALUControl = 3'b010;
				ALUSrc = 1;
				RegDst = 0;
				RegWrite = 1;
			end
			12'he28: begin // ADD (con inmediato)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				ALUControl = 3'b010;
				ALUSrc = 1;
				RegDst = 1;
				RegWrite = 1;
			end
			12'he04: begin // SUB (con registros)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				ALUControl = 3'b110;
				ALUSrc = 1;
				RegDst = 0;
				RegWrite = 1;
			end
			12'he24: begin // SUB (con inmediato)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				ALUControl = 3'b110;
				ALUSrc = 1;
				RegDst = 1;
				RegWrite = 1;
			end
			12'he15: begin // CMP (con registros)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				ALUControl = 3'b110;
				ALUSrc = 1;
				RegDst = 0;
				RegWrite = 0;
			end
			12'he35: begin // CMP (con inmediato)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				ALUControl = 3'b110;
				ALUSrc = 1;
				RegDst = 1;
				RegWrite = 0;
			end
			12'he59: begin // Load
				MemToReg = 1;
				MemWrite = 0;
				branch = 0;
				ALUControl = 3'b010;
				ALUSrc = 1;
				RegDst = 1;
				RegWrite = 1;
			end
			12'he58: begin // Store
				MemToReg = 0;
				MemWrite = 1;
				branch = 0;
				ALUControl = 3'b010;
				ALUSrc = 1;
				RegDst = 1;
				RegWrite = 0;
			end
			default: begin
				if (opcode[7:4] == 4'hA) begin // Branch functions
					MemToReg = 0;
					MemWrite = 0;
					branch = 1;
					ALUControl = 3'b110;
					ALUSrc = 1;
					RegDst = 0;
					RegWrite = 0;
				end
				else begin
					MemToReg = 0;
					MemWrite = 0;
					branch = 0;
					ALUControl = 3'b000;
					ALUSrc = 0;
					RegDst = 0;
					RegWrite = 0;
				end
			end
		endcase
	end
endmodule
