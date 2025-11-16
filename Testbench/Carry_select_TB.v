`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2025 07:33:27 PM
// Design Name: 
// Module Name: Carry_select_TB
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


module Carry_select_TB;

    reg [7:0] A;
    reg  [7:0] B;
    reg Cin;
    wire  [7:0] sum_out;
    wire Cout;

Carry_Select_Adder uut( 
.A(A), 
.B(B),
.Cin(Cin),
.sum_out(sum_out),
.Cout(Cout)
);

initial begin


    A = 8'haa; B = 8'h43; Cin = 0;
    #100;
    A = 8'haa; B = 8'h43; Cin = 1;
    #100;
    A = 8'hFF; B = 8'hFF; Cin = 0;
    #100;
    A = 8'h01; B = 8'h01; Cin = 0;
    #100;
    A = 8'h01; B = 8'h01; Cin = 1;
    #100;
    //A = 1; B = 0; Cin = 1;  
    //#10;
    //A = 1; B = 1; Cin = 0; 
   // #10;
    //A = 1; B = 1; Cin = 1;
    //#10;


end

endmodule
