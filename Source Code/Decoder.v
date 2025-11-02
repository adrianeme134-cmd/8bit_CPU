`timescale 1ns / 1ps


//Job of the Decoder module is to take the machine code from instruction register and break the instruction up to send to FSM, ALU
module Decoder(
    input wire [15:0] Fetch,       // 16-bit instruction assembled from ROM
    output reg  [2:0] Register_Destination, //3 bit field where output bits will live, this goes to register file
    output reg   [2:0]Register_1_operand, //3 bit field where register 1 lives output goes to register file
    output reg   [2:0]Register_2_operand, //3 bit field where register 2 lives output goes to register file
    output reg [3:0] Opcode //4 bit opcode that tells FSM/ALU what operation to perform
);
//DEFINE NEW INSTRUCTION SET USING 16 BITS



    // Registers
    

    // Define instruction opcodes
    parameter NOP = 4'b0000;
    parameter ADD = 4'b0001;
    parameter SUB = 4'b0010;
    parameter ORR = 4'b0011;
    parameter XORR = 4'b0100;
    parameter LD  = 4'b0101;
    parameter ST  = 4'b0110;
    parameter JMP = 4'b0111;
    parameter BEQ = 4'b1000;
    parameter LDI = 4'b1001;
    parameter NOTI= 4'b1010;
    parameter HLT = 4'b1011;

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


