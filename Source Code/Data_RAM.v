`timescale 1ns / 1ps


// address line is 10 bits
module Data_RAM (
    input clk,
    input write_enable, // write_enable signal comes from FSM
    input [9:0]address, // address line comes from Decoder 
    input [7:0]data_in, // Data coming in from register file 
    output reg [7:0]data_out
);
// 1 byte wide by 1024 entries 
// 1KB of byte addressable memory
reg [7:0]ram_block[0:1023];

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