`timescale 1ns / 1ps


//Job of the Decoder module is to take the machine code from instruction register and break the instruction up to send to FSM, ALU, Register file
module Decoder(
    input wire [15:0] Fetch,       // 16-bit instruction assembled from ROM
    output reg  [2:0] Register_Destination, //3 bit field where output bits will live, this goes to register file
    output reg   [2:0]Register_1_operand, //3 bit field where register 1 lives output goes to register file
    output reg   [2:0]Register_2_operand, //3 bit field where register 2 lives output goes to register file
    output reg [3:0] Opcode //4 bit opcode that tells FSM/ALU what operation to perform
);

// TODO Decoder logic needs fixing
    

    // Define instruction opcodes
    parameter addi = 4'b0000;
    parameter add = 4'b0001;
    parameter lb = 4'b0010;
    parameter subi = 4'b0011;
    parameter sub = 4'b0100;
    parameter beq  = 4'b0101;
    parameter bne  = 4'b0110;
    parameter slt = 4'b0111;
    parameter slti = 4'b1000;
    parameter jump = 4'b1001;
    parameter sb = 4'b1010;
    parameter sra = 4'b1011;
    parameter sll = 4'b1100;
    parameter jal = 4'b1101;
    parameter bitNAND = 4'b1110;
    parameter blt = 4'b1111;

    always @(*) begin
        case (Fetch[7:4])
            NOP: Opcode = NOP;
            ADD: Opcode = ADD;
            SUB: Opcode = SUB;
            LD:  Opcode = LD;
            ST:  Opcode = ST;
            HLT: Opcode = HLT;
            default:Opcode = NOP;
        endcase
    end

        // instruction format is 0000 OPCODE | 00 DESTINATION REGISTER | 0 OPERAND REGISTER 1 | 0 OPERAND REGISTER 2
    
        // Register 1 field Assignment
         always @(*) begin
         case (Fetch[0:0]) // Look at the first 1st LSB instruction, operand reg 2
             reg0:Register_1_operand = reg0;              
             reg1: Register_1_operand = reg1;  
             default: Register_1_operand = reg0; 
         endcase
     end

            // Register 2 field Assignment
     always @(*) begin
     case (Fetch[1:1]) // Look at the first 2nd LSB instruction, operand reg 1
        reg0: Register_2_operand = reg0;              
        reg1: Register_2_operand = reg1;  
        default: Register_2_operand = reg0;
     endcase
  end
         always @(*) begin
         case (Fetch[3:2]) // Look at the Destination part of the instruction
             reg0d: Register_Destination = reg0d;
             reg1d: Register_Destination = reg1d;
             reg2d: Register_Destination = reg2d;
             reg3d: Register_Destination = reg3d;          
             default: Register_Destination = reg0d;
         endcase
     end

     

endmodule


