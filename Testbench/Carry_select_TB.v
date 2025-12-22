`timescale 1ns / 1ps

module Signed_Carry_select_TB;

    reg [7:0] A;
    reg  [7:0] B;
    reg Cin;
    wire  [7:0] sum_out;
    wire overflow;

Signed_Carry_Select_Adder uut( 
.A(A), 
.B(B),
.Cin(Cin),
.sum_out(sum_out),
.overflow(overflow)
);

initial begin


    A = 8'b11111111; B = 8'b00000000; Cin = 1; // should be 0 This is -1 - (-1) = 0
    #10;
    A = 8'b10000000; B = 8'b10000000; Cin = 0; // Overflow, -127 + (-127) = -254, not 0
    #10;
    A = 8'b11111110; B = 8'b11111110; Cin = 0; // should be -4, -2 + (-2) = -4
    #10;


    $stop;

end

endmodule
