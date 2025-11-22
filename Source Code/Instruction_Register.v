`timescale 1ns / 1ps


module Instruction_Register #(parameter ADDRESS_WIDTH = 3) (
    input wire clk,
    input wire IR_Write, // control signal coming in from FSM
    input  wire [ADDRESS_WIDTH-1:0] addr, // Address that comes from Program Counter, will point to the address of the instruction we are currently on
    output reg  [15:0] Fetch // 16-bit Instruction to be sent to decoder
    
    );
   
    // Our data path is 8 bits wide, so we have to assemble our 16 bit instruction
    // We will use byte addressable memory, where every line corresponds to 1 byte (8 bits)
    reg [7:0] rom_data [0:7]; // 8 entries

    initial begin
        
        rom_data[0] = 8'b00010100; 
        rom_data[1] = 4'h5; 
        rom_data[2] = 4'hC; 
        rom_data[3] = 4'h3; 
        rom_data[4] = 4'hA; 
        rom_data[5] = 4'h5; 
        rom_data[6] = 4'hC; 
        rom_data[7] = 4'h3; 
    end
    // Fetch will equal the lower 8 bits, + upper 8 bits = 16 bits
    // {higher bits, lower bits}
    always @(posedge clk) begin
       if(IR_Write) begin
       Fetch <= {rom_data[addr+1],rom_data[addr]}; // This used to not be a register, I had it as a combinational assignment
                                                   // That is not good because when we assert PC control, it would change the instruction fetch is looking at
                                                   // Fetch needs to be stable in order to execute an instruction successfully      
       end
    end
endmodule
