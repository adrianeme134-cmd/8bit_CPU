`timescale 1ns / 1ps



module Decoder(
    input wire [15:0] Fetch,       // 16-bit instruction assembled from ROM
    output reg  [2:0] Register_Destination, //3 bit field where output bits will live, this goes to register file
    output reg   [2:0]Register_1_operand, //3 bit field where register 1 lives output goes to register file
    output reg   [2:0]Register_2_operand, //3 bit field where register 2 lives output goes to register file
    output reg [3:0] Opcode, //4 bit opcode that tells FSM/ALU what operation to perform
    output reg Is_immediate// Will output 1 or 0 out to datapath to determine if we will use immediate or register.
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

// IMMEDIATE INSTRUCTIONS NEED SIGN EXTENSIONS 

    always @(*) begin
        // Defaults
        Opcode = 4'b1101;
        Register_Destination = 3'b000;
        Register_1_operand = 3'b000;
        Register_2_operand = 3'b000;
        Is_immediate = 1'b0;
        
        case (Fetch[15:12])
            addi: begin 
            Opcode = addi;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1; // For rest of immediate bits, get them directly from instruction counter in datapath
            end 
            
            add: begin 
            Opcode = add; 
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Register_2_operand = Fetch[5:3];
            end
            
            lw: begin
            Opcode = lw;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1;     
            end
            
            subi: begin
            Opcode = subi;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1;     
            end
            
            sub: begin Opcode = sub;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Register_2_operand = Fetch[5:3];
            end
            
            beq: begin 
            Opcode = beq;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1;   
            end
            
            bne: begin 
            Opcode = bne;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1;    
            end
            
            slt: begin    
            Opcode = slt;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Register_2_operand = Fetch[5:3];
            end
            
            slti: begin
            Opcode = slti;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1;  
            end
             
            jump: begin 
            Opcode = jump;
            // Fields [11:0] are all for target address, get it from directly from datapath
            end
            
            sw: begin 
            Opcode = sw;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1;  
            end
            
            sra: begin
            Opcode = sra;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1;  
            end
            
            sll: begin 
            Opcode = sll;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1;            
            end
            
            HLT: begin 
            Opcode = HLT;
            end
            
            bitNAND: begin
            Opcode = bitNAND;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1; 
            end
            
            blt: begin
            Opcode = blt;
            Register_Destination = Fetch[11:9];
            Register_1_operand = Fetch[8:6];
            Is_immediate = 1'b1; 
            end
                       
        endcase
    end




endmodule


