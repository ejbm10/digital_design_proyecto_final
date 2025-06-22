module ControlUnit (
	input logic [11:0] opcode,
	input logic [7:0] isLSL,
	output logic MemToReg,
	output logic MemWrite,
	output logic branch,
	output logic beq,
	output logic bne,
	output logic bgt,
	output logic blt,
	output logic bge,
	output logic ble,
	output logic link,
	output logic ret,
	output logic StackSrc,
	output logic [2:0] ALUControl,
	output logic ALUSrc,
	output logic RegDst,
	output logic RegWrite
);
	
	always_comb begin
		case (opcode)
			12'he1a: begin // MOV (Dos registros) o LSL
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 0;
				ALUControl = (isLSL == 8'h0) ? 3'b000 : 3'b100;
				ALUSrc = (isLSL == 8'h0) ? 0 : 1;
				RegDst = (isLSL == 8'h0) ? 0 : ((isLSL[3:0] == 4'h1) ? 0 : 1);
				RegWrite = 1;
			end
			12'he3a: begin // MOV (Inmediato)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 0;
				ALUControl = 3'b000;
				ALUSrc = 0;
				RegDst = 1;
				RegWrite = 1;
			end
			12'he08: begin // ADD (Con registros)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 0;
				ALUControl = 3'b010;
				ALUSrc = 1;
				RegDst = 0;
				RegWrite = 1;
			end
			12'he28: begin // ADD (con inmediato)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 0;
				ALUControl = 3'b010;
				ALUSrc = 1;
				RegDst = 1;
				RegWrite = 1;
			end
			12'he04: begin // SUB (con registros)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 0;
				ALUControl = 3'b110;
				ALUSrc = 1;
				RegDst = 0;
				RegWrite = 1;
			end
			12'he24: begin // SUB (con inmediato)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 0;
				ALUControl = 3'b110;
				ALUSrc = 1;
				RegDst = 1;
				RegWrite = 1;
			end
			12'he00: begin // MUL (con registros)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 0;
				ALUControl = 3'b101;
				ALUSrc = 1;
				RegDst = 0;
				RegWrite = 1;
			end
			12'he20: begin // AND (con inmediato)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 0;
				ALUControl = 3'b000;
				ALUSrc = 1;
				RegDst = 1;
				RegWrite = 1;
			end
			12'he15: begin // CMP (con registros)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 0;
				ALUControl = 3'b110;
				ALUSrc = 1;
				RegDst = 0;
				RegWrite = 0;
			end
			12'he35: begin // CMP (con inmediato)
				MemToReg = 0;
				MemWrite = 0;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 0;
				ALUControl = 3'b110;
				ALUSrc = 1;
				RegDst = 1;
				RegWrite = 0;
			end
			12'he59: begin // Load imm
				MemToReg = 1;
				MemWrite = 0;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 0;
				ALUControl = 3'b010;
				ALUSrc = 1;
				RegDst = 1;
				RegWrite = 1;
			end
			12'he79: begin // Load reg
				MemToReg = 1;
				MemWrite = 0;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 0;
				ALUControl = 3'b010;
				ALUSrc = 1;
				RegDst = 0;
				RegWrite = 1;
			end
			12'he58: begin // Store imm
				MemToReg = 0;
				MemWrite = 1;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 0;
				ALUControl = 3'b010;
				ALUSrc = 1;
				RegDst = 1;
				RegWrite = 0;
			end
			12'he52: begin // Single push
				MemToReg = 0;
				MemWrite = 1;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 1;
				ALUControl = 3'b110;
				ALUSrc = 1;
				RegDst = 1;
				RegWrite = 0;
			end
			12'he49: begin // Single pop
				MemToReg = 1;
				MemWrite = 0;
				branch = 0;
				beq = 0;
				bne = 0;
				bgt = 0;
				blt = 0;
				bge = 0;
				ble = 0;
				link = 0;
				ret = 0;
				StackSrc = 1;
				ALUControl = 3'b010;
				ALUSrc = 1;
				RegDst = 1;
				RegWrite = 1;
			end
			default: begin
				case (opcode[11:4]) // Branch functions
					8'hea: begin
						MemToReg = 0;
						MemWrite = 0;
						branch = 1;
						beq = 0;
						bne = 0;
						bgt = 0;
						blt = 0;
						bge = 0;
						ble = 0;
						link = 0;
						ret = 0;
						StackSrc = 0;
						ALUControl = opcode[3] ? 3'b110 : 3'b010;
						ALUSrc = 1;
						RegDst = 0;
						RegWrite = 0;
					end
					8'h0a: begin
						MemToReg = 0;
						MemWrite = 0;
						branch = 0;
						beq = 1;
						bne = 0;
						bgt = 0;
						blt = 0;
						bge = 0;
						ble = 0;
						link = 0;
						ret = 0;
						StackSrc = 0;
						ALUControl = opcode[3] ? 3'b110 : 3'b010;
						ALUSrc = 1;
						RegDst = 0;
						RegWrite = 0;
					end
					8'h1a: begin
						MemToReg = 0;
						MemWrite = 0;
						branch = 0;
						beq = 0;
						bne = 1;
						bgt = 0;
						blt = 0;
						bge = 0;
						ble = 0;
						link = 0;
						ret = 0;
						StackSrc = 0;
						ALUControl = opcode[3] ? 3'b110 : 3'b010;
						ALUSrc = 1;
						RegDst = 0;
						RegWrite = 0;
					end
					8'hca: begin
						MemToReg = 0;
						MemWrite = 0;
						branch = 0;
						beq = 0;
						bne = 0;
						bgt = 1;
						blt = 0;
						bge = 0;
						ble = 0;
						link = 0;
						ret = 0;
						StackSrc = 0;
						ALUControl = opcode[3] ? 3'b110 : 3'b010;
						ALUSrc = 1;
						RegDst = 0;
						RegWrite = 0;
					end
					8'hba: begin
						MemToReg = 0;
						MemWrite = 0;
						branch = 0;
						beq = 0;
						bne = 0;
						bgt = 0;
						blt = 1;
						bge = 0;
						ble = 0;
						link = 0;
						ret = 0;
						StackSrc = 0;
						ALUControl = opcode[3] ? 3'b110 : 3'b010;
						ALUSrc = 1;
						RegDst = 0;
						RegWrite = 0;
					end
					8'haa: begin
						MemToReg = 0;
						MemWrite = 0;
						branch = 0;
						beq = 0;
						bne = 0;
						bgt = 0;
						blt = 0;
						bge = 1;
						ble = 0;
						link = 0;
						ret = 0;
						StackSrc = 0;
						ALUControl = opcode[3] ? 3'b110 : 3'b010;
						ALUSrc = 1;
						RegDst = 0;
						RegWrite = 0;
					end
					8'hda: begin
						MemToReg = 0;
						MemWrite = 0;
						branch = 0;
						beq = 0;
						bne = 0;
						bgt = 0;
						blt = 0;
						bge = 0;
						ble = 1;
						link = 0;
						ret = 0;
						StackSrc = 0;
						ALUControl = opcode[3] ? 3'b110 : 3'b010;
						ALUSrc = 1;
						RegDst = 0;
						RegWrite = 0;
					end
					8'heb: begin
						MemToReg = 0;
						MemWrite = 0;
						branch = 1;
						beq = 0;
						bne = 0;
						bgt = 0;
						blt = 0;
						bge = 0;
						ble = 0;
						link = 1;
						ret = 0;
						StackSrc = 0;
						ALUControl = opcode[3] ? 3'b110 : 3'b010;
						ALUSrc = 1;
						RegDst = 0;
						RegWrite = 0;
					end
					8'he1: begin
						MemToReg = 0;
						MemWrite = 0;
						branch = 1;
						beq = 0;
						bne = 0;
						bgt = 0;
						blt = 0;
						bge = 0;
						ble = 0;
						link = 0;
						ret = 1;
						StackSrc = 0;
						ALUControl = opcode[3] ? 3'b110 : 3'b010;
						ALUSrc = 1;
						RegDst = 0;
						RegWrite = 0;
					end
					default: begin
						MemToReg = 0;
						MemWrite = 0;
						branch = 0;
						beq = 0;
						bne = 0;
						bgt = 0;
						blt = 0;
						bge = 0;
						ble = 0;
						link = 0;
						ret = 0;
						StackSrc = 0;
						ALUControl = 3'b000;
						ALUSrc = 0;
						RegDst = 0;
						RegWrite = 0;
					end
				endcase
			end
		endcase
	end
endmodule
