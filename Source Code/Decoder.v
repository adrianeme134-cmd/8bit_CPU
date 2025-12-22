`timescale 1ns / 1ps



module Decoder(
    input wire [15:0] Fetch,       // 16-bit instruction assembled from ROM, comes from instruction reg
    output reg  [2:0] Register_Destination, //3 bit field where output bits will live, this goes to register file
    output reg   [2:0]Register_1_operand, //3 bit field where register 1 lives output goes to register file
    output reg   [2:0]Register_2_operand, //3 bit field where register 2 lives output goes to register file
    output reg [3:0] instr_Opcode, //4 bit opcode that tells FSM/ALU what operation to perform
    output reg Is_immediate, // Will output 1 or 0 out to datapath to determine if we will use immediate or register.
    output reg  [5:0] immediate, // 6 bit immediate value
    output reg signed_immediate, // will choose if immediate is sign extended or not
    output reg [11:0] jmp_addr, // 12 bit address field for jumping, this allows up to 4KB of jumping.
    output reg [3:0] ALUOp
);

    // Define instruction opcodes
    parameter addi = 4'b0000;
    parameter add = 4'b0001;
    parameter lw = 4'b0010;
    parameter subi = 4'b0011;
    parameter sub = 4'b0100;
    parameter beq  = 4'b0101;
    parameter bne  = 4'b0110;
    parameter slt = 4'b0111;
    parameter slti = 4'b1000;
    parameter jump = 4'b1001;
    parameter sw = 4'b1010;
    parameter sra = 4'b1011;
    parameter sll = 4'b1100;
    parameter HLT = 4'b1101;
    parameter bitNAND = 4'b1110;
    parameter blt = 4'b1111;

    always @(*) begin
        // Defaults
        ALUOp = 4'b0000;
        instr_Opcode = 4'b1101;
        Register_Destination = 3'b000;
        Register_1_operand = 3'b000;
        Register_2_operand = 3'b000;
        Is_immediate = 1'b0;
        immediate = 6'b000000;
        jmp_addr = 12'b0;
        signed_immediate = 1'b0;
        
        case (Fetch[15:12])
            addi: begin 
            instr_Opcode = addi;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            immediate = Fetch[5:0];
            Is_immediate = 1'b1; 
            signed_immediate = 1'b1;
            ALUOp = 4'b0000;
            end 
            
            add: begin 
            instr_Opcode = add; 
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Register_2_operand = Fetch[5:3];
            ALUOp = 4'b0000;
            end
            
            lw: begin
            instr_Opcode = lw;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1;
            ALUOp = 4'b0000;     
            end
            
            subi: begin
            instr_Opcode = subi;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            immediate = Fetch[5:0];
            Is_immediate = 1'b1;
            signed_immediate = 1'b1;
            ALUOp = 4'b0001;     
            end
            
            sub: begin 
            instr_Opcode = sub;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Register_2_operand = Fetch[5:3];
            ALUOp = 4'b0001; 
            end
            
            beq: begin 
            instr_Opcode = beq;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1;
            ALUOp = 4'b1111;// A == B Equivalence checker   
            end
            
            bne: begin 
            instr_Opcode = bne;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1;
            ALUOp = 4'b1111;// A == B Equivalence checker    
            end
            
            slt: begin    
            instr_Opcode = slt;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Register_2_operand = Fetch[5:3];
            ALUOp = 4'b1110; // A < B set 1 else 0
            end
            
            slti: begin
            instr_Opcode = slti;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            immediate = Fetch[5:0];
            Is_immediate = 1'b1;
            signed_immediate = 1'b1;
            ALUOp = 4'b1110; // A < B set 1 else 0  
            end
             
            jump: begin 
            instr_Opcode = jump;
            jmp_addr = Fetch[11:0];
            end
            
            sw: begin 
            instr_Opcode = sw;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            immediate = Fetch[5:0];
            Is_immediate = 1'b1;
            ALUOp = 4'b0000;  
            end
            
            sra: begin
            instr_Opcode = sra;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            immediate = Fetch[5:0];
            Is_immediate = 1'b1;
            ALUOp = 4'b0101; // shift right arithmitic  
            end
            
            sll: begin 
            instr_Opcode = sll;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            immediate = Fetch[5:0];
            Is_immediate = 1'b1;
            ALUOp = 4'b0100; // shift left logical            
            end
            
            HLT: begin 
            instr_Opcode = HLT;
            end
            
            bitNAND: begin
            instr_Opcode = bitNAND;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            immediate = Fetch[5:0];
            Is_immediate = 1'b1;
            ALUOp = 4'b1100; 
            end
            
            blt: begin
            instr_Opcode = blt;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            immediate = Fetch[5:0];
            Is_immediate = 1'b1;
            ALUOp = 4'b1110; // if A < B then don't branch 
            end
                       
        endcase
    end

endmodule


