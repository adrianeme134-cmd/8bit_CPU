`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2025 10:29:48 AM
// Design Name: 
// Module Name: Reg_file_test
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


module Reg_file_test();

    
     wire  [1:0] Register_Destination; //2 bit field where output bits will live, coming in from decoder
     wire  Register_1_operand; //1 bit field where register 1 lives from decoder aka adress of field 1
     wire  Register_2_operand; //1 bit field where register 2 lives from decoder aka address of field 2
     wire write_enable; // Flag Coming in from FSM
     wire [7:0]data_in; // data to write to a register coming from an ALU or some other place
     reg [7:0]data_out1; // outputs data coming out
     reg [7:0]data_out2;
     reg clk;

    Register_file uut(clk,Register_Destination,Register_1_operand,Register_2_operand,write_enable,data_in,data_out1,data_out2);

    always #5 clk = ~clk;

    initial begin
    clk = 0;

    
    
    end
    
    
endmodule
