`timescale 1ns / 1ps


module FSM(
    input wire clk,
    input wire [3:0] Opcode, //Input from decoder
    output reg  [3:0] ALUOp,  // Operation code to output to ALU
    output reg  MemWrite, // Control signal to write to RAM
    output reg  RegWrite, // Control signal to write to Register_file (no control signal for Reg_read because it is combinational read)
    output reg  MemRead, // Control signal to read from RAM
    output reg  PCWrite, // Control signal to write to PC
    output reg  IRWrite // Control signal to write to Instruction Register

    );
  
     // we might need to output a jump en flag for jump instructions and datapath  
    
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
    
  
    parameter FETCH = 5'b10001;
    parameter EXECUTE = 5'b10010;
    parameter WRITEBACK = 5'b10011;
    parameter STORE_MEMORY = 5'b10100;
    parameter HALT = 5'b10101;


// This is a Sequential & Combinational block FSM that will allow states to change only at clk edge
// and allow signals to change immediately
reg [3:0] state, next_state;

    always @(posedge clk) begin
        state <= next_state;
    end
    
    
always @(*) begin 

        // Default states that will be reinitialize when the state everytime (and overriden in the case block) if an input change is detected
        ALUOp = 4'b0000;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        PCWrite = 0;
        IRWrite = 0;
        next_state = FETCH;  //Default state will always equal fetch, will be overriden by case state assignment below
        
        
        case (state)
            FETCH: begin
                MemRead = 1;
                IRWrite = 1;
                next_state = EXECUTE;
            end
            
            EXECUTE: begin
                case (Opcode)
                
                    addi: begin  
                    ALUOp = 4'b0000;                   
                    next_state = WRITEBACK;                  
                    end
                    
                    add:  begin 
                    ALUOp = 4'b0000;
                    next_state = WRITEBACK; 
                    end
                    
                    lw:  begin 
                    ALUOp = 4'b0000; 
                    MemRead = 1;   
                    next_state = WRITEBACK;                                   
                    end
                    
                    subi: begin  
                    ALUOp = 4'b0001; 
                    next_state = WRITEBACK;                     
                    end
                    
                    sub: begin  
                    ALUOp = 4'b0001; 
                    next_state = WRITEBACK; 
                    end
                    
                    beq:  begin
                    ALUOp = 4'b1111;// A == B Equivalence checker
                    next_state = FETCH;
                    end
                    
                    bne: begin
                    ALUOp = 4'b1111;// A == B Equivalence checker
                    next_state = FETCH;
                    end
                    
                    slt: begin
                    ALUOp = 4'b1110; // A > B set 1 else 0
                    next_state = WRITEBACK;
                    end
                    
                    slti: begin
                    ALUOp = 4'b1110; // A > B set 1 else 0
                    next_state = WRITEBACK;
                    end
                    
                    jump: begin
                    next_state = FETCH;
                    end
                    
                    sw:  begin
                    MemWrite = 1;
                    next_state = STORE_MEMORY;
                    end
                    
                    sra: begin  
                    ALUOp = 4'b0101; //This is shift right logical, will disregard sign bit, 
                    next_state = WRITEBACK;
                    end
                    
                    sll: begin
                    ALUOp = 4'b0100; // shift left logical
                    next_state = WRITEBACK;
                    end
                    
                    HLT: begin
                    next_state = HLT;
                    end
                    
                    bitNAND: begin
                    ALUOp = 4'b1100;
                    next_state = WRITEBACK;
                    end
                    
                    blt: begin
                    ALUOp = 4'b1110; // if A > B then don't branch
                    next_state = FETCH;
                    end
                endcase
 
            end
            WRITEBACK: begin
                RegWrite = 1;
                PCWrite = 1;
                next_state = FETCH;
            end
            STORE_MEMORY: begin
                 RegWrite = 1;
                 PCWrite = 1;
                 next_state = FETCH;
             end
             HALT: begin
                  next_state = HALT;
              end
        endcase
    end

endmodule

