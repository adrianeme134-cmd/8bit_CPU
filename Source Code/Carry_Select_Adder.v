`timescale 1ns / 1ps

// Split into blocks of 4, right now we have 2 blocks of 8 ripple carrys together

// signed overflow happens when we have 2 numbers both of the same sign, which means we can flip the sign bit.
// to detect this, we need to keep track of the MSB of A and B inputs,  carryin coming into the MSB along with Carryout of that MSB. 
// overflow will never happen if we have differing numbers of signs. result will move towards 0, therefore never overflow
// to implement overflow, we look at the carryin value of the MSB, and XOR it with the carryout of the MSB. if they are different, the carryin flipped our sign bit
// pushing the sign bit into the carryout, out of range.
// Carryin represents expected sign before addition, carryout represents actual sign after addition
// MSB_Sum = A_MSB + B_MSB + MSB_carryin overflow will simply detect if the MSB_SUM carryout is equal to MSB_carryin as it means  
// that the carryin did not flip our bit

module Signed_Carry_Select_Adder(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire Cin,
    output wire [7:0] sum_out,
    output wire overflow
    );
  
    wire carryout [0:7];
    wire sum [0:7];
  
    // 4 FA chained together with carryin initial 0 bits 0-3
    FA zero(.A(A[0]),.B(B[0]),.Cin(Cin),.Cout(carryout[0]),.Sum(sum[0]));
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
    
    // 4 FA chained together with carryin initial 1 bits 4-7
    FA four_col2(.A(A[4]),.B(B[4]),.Cin(1'b1),.Cout(carryout_col2[4]),.Sum(sum_col2[4]));
    FA five_col2(.A(A[5]),.B(B[5]),.Cin(carryout_col2[4]),.Cout(carryout_col2[5]),.Sum(sum_col2[5]));
    FA six_col2(.A(A[6]),.B(B[6]),.Cin(carryout_col2[5]),.Cout(carryout_col2[6]),.Sum(sum_col2[6]));
    FA seven_col2(.A(A[7]),.B(B[7]),.Cin(carryout_col2[6]),.Cout(carryout_col2[7]),.Sum(sum_col2[7]));
    
    wire Final_carryout;
    
    assign  sum_out  = (carryout[3] == 1'b1) ? {sum_col2[7],sum_col2[6],sum_col2[5],sum_col2[4],sum[3],sum[2],sum[1],sum[0]} : {sum[7],sum[6],sum[5],sum[4],sum[3],sum[2],sum[1],sum[0]};
 
    assign Final_carryout =  (carryout[3] == 1'b1) ? carryout_col2[7] : carryout[7];
    
    wire MSB_Cin;
    
    assign MSB_Cin = (carryout[3] == 1'b1) ? carryout_col2[6] : carryout[6];
    
    // signed overflow indicator, we need to use carryin going into MSB and 
    assign overflow = Final_carryout ^ MSB_Cin;
 
endmodule
