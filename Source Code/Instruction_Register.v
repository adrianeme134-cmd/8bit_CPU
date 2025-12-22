`timescale 1ns / 1ps


module Instruction_Register(
    input wire clk,
    input wire IR_Write, // control signal coming in from FSM
    input  wire [7:0] pc_add, // Address that comes from Program Counter, will point to the address of the instruction we are currently on
    output reg  [15:0] Fetch // 16-bit Instruction to be sent to decoder
    
    );
   
    // Our data path is 8 bits wide, so we have to assemble our 16 bit instruction
    // We will use byte addressable memory, where every line corresponds to 1 byte (8 bits)

    reg [7:0] Program_byte [0:255]; // 256 Bytes, 256 entries

    initial begin
        $readmemb("Program.mem", Program_byte);
        $display("Byte0 = %b | Byte1 = %b", Program_byte[0], Program_byte[1]);
    end
    // Fetch will equal the lower 8 bits, + upper 8 bits = 16 bits
    // {higher bits, lower bits}
    always @(posedge clk) begin
       if(IR_Write) begin
       Fetch <= {Program_byte[pc_add+1],Program_byte[pc_add]}; // This used to not be a register, I had it as a combinational assignment
                                                   // That is not good because when we assert PC control, it would change the instruction fetch is looking at
                                                   // Fetch needs to be stable in order to execute an instruction successfully      
       end
    end
    
    
    
    
endmodule
