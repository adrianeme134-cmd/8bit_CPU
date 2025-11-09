`timescale 1ns / 1ps


module FSM(
    input wire clk,
    input wire [3:0] Opcode, //Input from decoder
    output reg  [3:0] ALUOp,  // Operation code to output to ALU
    output reg  MemWrite,
    output reg  RegWrite,
    output reg  MemRead,
    output reg  PCWrite,
    output reg  IRWrite

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
    
    
    
    parameter FETCH = 4'b0001;
    parameter EXECUTE = 4'b0010;
    parameter WRITEBACK = 4'b0011;
    parameter STOREMEMORY = 4'b0100;
    parameter HALT = 4'b0101;

// This block will fetch the next state when posedge comes and update it
reg [3:0] state, next_state;

    // TODO: Fix FSM logic and map to each instruction
    always @(posedge clk) begin
        state <= next_state;
    end
    
    
always @(*) begin //combinational case statement that will update when posedge comes
        // default outputs
        ALUOp = 4'b0000;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        PCWrite = 0;
        IRWrite = 0;
        next_state = FETCH;  //next_state will always equal fetch
        
        
        // Implement later if case statements to make certain instructions skip states like  if (Opcode != ST && Opcode != BEQ)
        case (state)
            FETCH: begin
                MemRead = 1;
                IRWrite = 1;
                next_state = EXECUTE;
            end
            
            EXECUTE: begin
                case (Opcode)
                    ADD:  ALUOp = 4'b0001;
                    SUB:  ALUOp = 4'b0010;
                    LD:   MemRead = 1;
                    ST:   MemWrite = 1;
                endcase
                next_state = WRITEBACK;
            end
    
            WRITEBACK: begin
                RegWrite = 1;
                PCWrite = 1;
                next_state = FETCH;
            end
        endcase
    end

endmodule

