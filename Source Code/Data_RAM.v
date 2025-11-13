`timescale 1ns / 1ps


// address line is 16 bits
module Data_RAM (
    input clk,
    input write_enable, // write_enable signal comes from FSM
    input [15:0]address, // address line comes from Decoder, because our datapath is 8 bits wide and we have only 2 registers files outputting, we will
                         // need to merge both registers to address all 64KB of memory
    input [7:0]data_in, // Data coming in from register file 
    output reg [7:0]data_out
);
// 1 byte wide by 65,536 entries 
// 64KB of byte addressable memory
reg [7:0]ram_block[0:65636];

// Example of synchronous read and write behavior
always @(posedge clk) begin
        if(write_enable) 
            ram_block[address] <= data_in;
        else
            data_out <= ram_block[address]; 
end

// This behavior prevents reading and writing at the same time, unstable behavior
// RAM looks like the Register_file module but it does not have combinational read due to the design of the actual physical hardware

endmodule