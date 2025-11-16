`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2025 08:54:29 PM
// Design Name: 
// Module Name: Full_Adder_TB
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


module Full_Adder_TB;

    reg A;
    reg B;
    reg Cin;
    wire Cout;
    wire Sum;
    
    FA uut(
    .A(A),
    .B(B),
    .Cin(Cin),
    .Cout(Cout),
    .Sum(Sum)
    );
    
    
    initial begin
    
    A = 0; B = 0; Cin = 0;
    #10;
    A = 0; B = 0; Cin = 1;
    #10;
    A = 0; B = 1; Cin = 0;
    #10;
    A = 0; B = 1; Cin = 1;
    #10;
    A = 1; B = 0; Cin = 0;
    #10;
    A = 1; B = 0; Cin = 1;  
    #10;
    A = 1; B = 1; Cin = 0; 
    #10;
    A = 1; B = 1; Cin = 1;
    #10;

    $stop;

    end
    
    
    
endmodule
