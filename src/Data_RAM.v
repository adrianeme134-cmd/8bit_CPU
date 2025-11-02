`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2025 02:06:09 PM
// Design Name: 
// Module Name: ROM_Registers
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


module Data_RAM (
    input clk,
    input write_enable,
    input [9:0]address,
    input [7:0]data_in,
    output reg [7:0]data_out
);
// 1 byte wide by 1024 entries 
// 1KB of byte addressable memory
reg [7:0]ram_block[0:1023];

always @(posedge clk) begin
        if(write_enable)
            ram_block[address] <= data_in;
        else
            data_out <= ram_block[address];
end

endmodule