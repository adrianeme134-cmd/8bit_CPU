`timescale 1ns / 1ps

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

// Example of synchronous write behavior
always @(posedge clk) begin
        if(write_enable) // Will write to address when write_enable assrted by FSM is high, and posedge is high, 
            ram_block[address] <= data_in;
        else
            data_out <= ram_block[address]; // Will read out the data at addr when only when posedge clk and write_enable is low
end

// This behavior prevents reading and writing at the same time, unstable behavior


endmodule