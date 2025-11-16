`timescale 1ns / 1ps

// Split into blocks of 4, right now we have 2 blocks of 8 ripple carrys together

module Carry_Select_Adder(
    input [7:0] A,
    input [7:0] B,
    input Cin,
    output [7:0]sum_out,
    output Cout
    );
  
    wire carryout [0:7];
    wire sum [0:7];
  
    // 4 FA chained together with carryin initial 0 bits 0-3
    FA zero(.A(A[0]),.B(B[0]),.Cin(1'b0),.Cout(carryout[0]),.Sum(sum[0]));
    FA one(.A(A[1]),.B(B[1]),.Cin(carryout[0]),.Cout(carryout[1]),.Sum(sum[1]));
    FA two(.A(A[2]),.B(B[2]),.Cin(carryout[1]),.Cout(carryout[2]),.Sum(sum[2]));
    FA three(.A(A[3]),.B(B[3]),.Cin(carryout[2]),.Cout(carryout[3]),.Sum(sum[3]));
    
    // 4 FA chained together with carryin initial 0 bits 4-7
    FA four(.A(A[4]),.B(B[4]),.Cin(1'b0),.Cout(carryout[4]),.Sum(sum[4]));
    FA five(.A(A[5]),.B(B[5]),.Cin(carryout[4]),.Cout(carryout[5]),.Sum(sum[5]));
    FA six(.A(A[6]),.B(B[6]),.Cin(carryout[5]),.Cout(carryout[6]),.Sum(sum[6]));
    FA seven(.A(A[7]),.B(B[7]),.Cin(carryout[6]),.Cout(carryout[7]),.Sum(sum[7]));
    
    wire carryout_col2 [0:7];
    wire sum_col2 [0:7];
     
    // 4 FA chained together with carryin initial 1 bits 0-3
    FA zero_col2(.A(A[0]),.B(B[0]),.Cin(1'b1),.Cout(carryout_col2[0]),.Sum(sum_col2[0]));
    FA one_col2(.A(A[1]),.B(B[1]),.Cin(carryout_col2[0]),.Cout(carryout_col2[1]),.Sum(sum_col2[1]));
    FA two_col2(.A(A[2]),.B(B[2]),.Cin(carryout_col2[1]),.Cout(carryout_col2[2]),.Sum(sum_col2[2]));
    FA three_col2(.A(A[3]),.B(B[3]),.Cin(carryout_col2[2]),.Cout(carryout_col2[3]),.Sum(sum_col2[3]));
    
    // 4 FA chained together with carryin initial 1 bits 4-7
    FA four_col2(.A(A[4]),.B(B[4]),.Cin(1'b1),.Cout(carryout_col2[4]),.Sum(sum_col2[4]));
    FA five_col2(.A(A[5]),.B(B[5]),.Cin(carryout_col2[4]),.Cout(carryout_col2[5]),.Sum(sum_col2[5]));
    FA six_col2(.A(A[6]),.B(B[6]),.Cin(carryout_col2[5]),.Cout(carryout_col2[6]),.Sum(sum_col2[6]));
    FA seven_col2(.A(A[7]),.B(B[7]),.Cin(carryout_col2[6]),.Cout(carryout_col2[7]),.Sum(sum_col2[7]));
 
    wire [0:3] sum_Final_blk1;
    
    assign  sum_Final_blk1  = (Cin == 1'b1) ? {sum_col2[3],sum_col2[2],sum_col2[1],sum_col2[0]} : {sum[3],sum[2],sum[1],sum[0]};
 
    wire MUX_SEL2;
    
    assign MUX_SEL2 = (carryout[3]|carryout_col2[3])&Cin;
    
    wire [0:3] sum_Final_blk2;
     
    assign sum_Final_blk2 = (MUX_SEL2 == 1'b1) ? {sum_col2[7],sum_col2[6],sum_col2[5],sum_col2[4]} : {sum[7],sum[6],sum[5],sum[4]};
     
     // Final sum output
    assign sum_out = {sum_Final_blk2,sum_Final_blk1};
    
    // Final carryout, this will be our overflow indicator
    assign Cout = (MUX_SEL2 == 1'b1) ? carryout_col2[7] : carryout[7];
 
endmodule
