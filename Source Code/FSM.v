`timescale 1ns / 1ps


module FSM(
    input wire clk,
    input wire rst,
    input wire  [3:0] Opcode, //Input from decoder
    output reg  MemWrite, // Control signal to write to RAM
    output reg  RegWrite, // Control signal to write to Register_file (no control signal for Reg_read because it is combinational read)
    output reg  MemRead, // Control signal to read from RAM
    output reg  PCWrite, // Control signal to write to PC
    output reg  IRWrite, // Control signal to write to Instruction Register
    output reg  ALU_Enable,
    output reg  [5:0] State
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


// This is a Sequential & Combinational block Moore FSM that will allow states to change only at clk edge
// and allow signals to change immediately

// *Another MISTAKE, This reg was declared as 4 bits, but I declared my state parameters above as 5 bits
reg [5:0] next_state;

// *MISTAKE* in this always case statement, I did not initiallize state to any value, therefore 
// when I tested it in my testbench, everything would just stay at 0 because it was not going through
// any states. This was the mistake:
// always @(posedge clk) begin
// state <= next_state;
// end

    always @(posedge clk) begin
    if(rst)
        State <= FETCH;
        else
        State <= next_state;
    end
    
    
    always @(*) begin 
        // Default outputs to not accidentally infer  latches
        RegWrite = 1'b0;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        PCWrite = 1'b0;
        IRWrite = 1'b0;
        ALU_Enable = 1'b0;
        next_state = FETCH;
        
        
        case (State)
            FETCH: begin
                MemRead = 1; // If our program was stored in RAM it would assert 1 to get the instruction
                IRWrite = 1;
                next_state = EXECUTE;
            end
            
            EXECUTE: begin
                case (Opcode)
                
                    addi: begin
                    ALU_Enable = 1'b1;                                        
                    next_state = WRITEBACK;                  
                    end
                    
                    add:  begin
                    ALU_Enable = 1'b1;        
                    next_state = WRITEBACK; 
                    end
                    
                    lw:  begin 
                    MemRead = 1;
                    ALU_Enable = 1'b1;   
                    next_state = WRITEBACK;                                   
                    end
                    
                    subi: begin
                    ALU_Enable = 1'b1;  
                    next_state = WRITEBACK;                     
                    end
                    
                    sub: begin
                    ALU_Enable = 1'b1;  
                    next_state = WRITEBACK; 
                    end
                    
                    beq:  begin
                    ALU_Enable = 1'b1;
                    PCWrite = 1;
                    next_state = FETCH;
                    end
                    
                    bne: begin
                    ALU_Enable = 1'b1;               
                    PCWrite = 1;
                    next_state = FETCH;
                    end
                    
                    slt: begin
                    ALU_Enable = 1'b1;                   
                    next_state = WRITEBACK;
                    end
                    
                    slti: begin
                    ALU_Enable = 1'b1;
                    next_state = WRITEBACK;
                    end
                    
                    jump: begin
                    ALU_Enable = 1'b1;
                    PCWrite = 1;
                    next_state = FETCH;
                    end
                    
                    sw:  begin
                    ALU_Enable = 1'b1;
                    MemWrite = 1;
                    next_state = STORE_MEMORY;
                    end
                    
                    sra: begin
                    ALU_Enable = 1'b1;  
                    next_state = WRITEBACK;
                    end
                    
                    sll: begin
                    ALU_Enable = 1'b1;
                    next_state = WRITEBACK;
                    end
                    
                    HLT: begin
                    ALU_Enable = 1'b1;
                    next_state = HALT;
                    end
                    
                    bitNAND: begin
                    ALU_Enable = 1'b1;
                    next_state = WRITEBACK;
                    end
                    
                    blt: begin
                    ALU_Enable = 1'b1;
                    PCWrite = 1;
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
                 MemWrite = 1;
                 PCWrite = 1;
                 next_state = FETCH;
             end
             HALT: begin
                  next_state = HALT;
              end
        endcase
    end

endmodule

