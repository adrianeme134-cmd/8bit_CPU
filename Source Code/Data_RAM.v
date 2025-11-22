`timescale 1ns / 1ps


module RAM(
    input wire clk,
    input wire write_enable, // write_enable signal comes from FSM
    input wire [7:0]address, // address line comes from Decoder         
    input wire [7:0]data_in, // Data coming in from register file 
    output reg [7:0]data_out
);

//256 Bytes of byte-addressable memory
reg [7:0]ram_block[0:255];

// Example of synchronous read and write behavior
always @(posedge clk) begin
        if(write_enable) // If high write data ON clk edge
            ram_block[address] <= data_in;
        else
            data_out <= ram_block[address];  // If low read data ON clk edge
end

// This behavior prevents reading and writing at the same time, unstable behavior


endmodule