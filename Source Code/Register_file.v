`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2025 05:39:20 PM
// Design Name: 
// Module Name: Register_file
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


module Register_file(
    input clk,
    input wire  [1:0] Register_Destination, //2 bit field where output bits will live, coming in from decoder
    input wire  Register_1_operand, //1 bit field where register 1 lives from decoder aka adress of field 1
    input wire  Register_2_operand, //1 bit field where register 2 lives from decoder aka address of field 2
    input write_enable, // Flag Coming in from FSM
    input [7:0]data_in, // data to write to a register coming from an ALU or some other place
    output reg [7:0]data_out1, // outputs data coming out
    output reg [7:0]data_out2
    );
    
    reg [7:0]ram_block[0:7]; // 8 Registers R0-R7 8 bit wide each
    // 4 Registers to save  
    
    // Synchronous write
    always @(posedge clk) begin
            if(write_enable) //Write to the destination register
                ram_block[Register_Destination] <= data_in;
    end
    
    // Combinational read
    always @(*) begin
    
        data_out1 = ram_block[Register_1_operand]; // Always update the value of the register to be the data coming out
        data_out2 = ram_block[Register_2_operand];
    
    end
    
    
endmodule
