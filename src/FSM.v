`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2025 09:02:20 PM
// Design Name: 
// Module Name: FSM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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
    
    
    parameter FETCH = 4'b0001;
    parameter EXECUTE = 4'b0010;
    parameter WRITEBACK = 4'b0011;
    parameter STOREMEMORY = 4'b0100;
    parameter HALT = 4'b0101;

// This block will fetch the next state when posedge comes and update it
reg [3:0] state, next_state;

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

