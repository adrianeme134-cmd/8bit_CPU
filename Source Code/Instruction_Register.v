`timescale 1ns / 1ps


module Instruction_Register #(parameter ADDRESS_WIDTH = 3) (
    input  wire [ADDRESS_WIDTH-1:0] addr, // Address that comes from Program Counter, will point to the address of the instruction we are currently on
    output wire  [15:0] Fetch // 16-bit Instruction to be sent to decoder
    );
   
    // Our data path is 8 bits wide, so we have to assemble our 16 bit instruction
    // Declare a memory array (a vector of vectors)
    // The memory has 8 locations, each storing a 8-bit vector (a byte)
    // We will use byte addressable memory, where every line corresponds to 1 byte (8 bits)
    reg [7:0] rom_data [0:7]; // 8 entries

    initial begin
        // 8 Ram modules will store up to 4 instructions of byte addressed memory
        rom_data[0] = 8'b00010100; 
        rom_data[1] = 4'h5; 
        rom_data[2] = 4'hC; 
        rom_data[3] = 4'h3; 
        rom_data[4] = 4'hA; 
        rom_data[5] = 4'h5; 
        rom_data[6] = 4'hC; 
        rom_data[7] = 4'h3; 
    end
    // Combinational read logic
    // Fetch will equal the lower 8 bits, + upper 8 bits = 16 bits
    // {higher bits, lower bits}
       assign Fetch = {rom_data[addr+1],rom_data[addr]};
    
endmodule
