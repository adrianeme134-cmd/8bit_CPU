`timescale 1ns / 1ps

module Ten_Bit_Wallace_Tree_Multiplier(
    input [7:0] A,
    input [7:0] B,
    output [9:0] sum
);

wire row1b0,row1b1,row1b2,row1b3,row1b4,row1b5,row1b6,row1b7;

assign row1b0 = A[0] & B[0]; 
assign row1b1 = A[0] & B[1]; 
assign row1b2 = A[0] & B[2]; 
assign row1b3 = A[0] & B[3]; 
assign row1b4 = A[0] & B[4]; 
assign row1b5 = A[0] & B[5];
assign row1b6 = A[0] & B[6]; 
assign row1b7 = A[0] & B[7]; 

wire row2b0,row2b1,row2b2,row2b3,row2b4,row2b5,row2b6,row2b7;

assign row2b0 = A[1] & B[0]; 
assign row2b1 = A[1] & B[1]; 
assign row2b2 = A[1] & B[2]; 
assign row2b3 = A[1] & B[3]; 
assign row2b4 = A[1] & B[4]; 
assign row2b5 = A[1] & B[5]; 
assign row2b6 = A[1] & B[6]; 
assign row2b7 = A[1] & B[7]; 

wire row3b0,row3b1,row3b2,row3b3,row3b4,row3b5,row3b6,row3b7;

assign row3b0 = A[2] & B[0]; 
assign row3b1 = A[2] & B[1]; 
assign row3b2 = A[2] & B[2]; 
assign row3b3 = A[2] & B[3]; 
assign row3b4 = A[2] & B[4]; 
assign row3b5 = A[2] & B[5]; 
assign row3b6 = A[2] & B[6]; 
assign row3b7 = A[2] & B[7]; 

wire row4b0,row4b1,row4b2,row4b3,row4b4,row4b5,row4b6;

assign row4b0 = A[3] & B[0]; 
assign row4b1 = A[3] & B[1]; 
assign row4b2 = A[3] & B[2]; 
assign row4b3 = A[3] & B[3]; 
assign row4b4 = A[3] & B[4]; 
assign row4b5 = A[3] & B[5]; 
assign row4b6 = A[3] & B[6]; 
//assign row4b7 = A[3] & B[7];

wire row5b0,row5b1,row5b2,row5b3,row5b4,row5b5;

assign row5b0 = A[4] & B[0]; 
assign row5b1 = A[4] & B[1]; 
assign row5b2 = A[4] & B[2]; 
assign row5b3 = A[4] & B[3];
assign row5b4 = A[4] & B[4]; 
assign row5b5 = A[4] & B[5]; 
//assign row5b6 = A[4] & B[6];
//assign row5b7 = A[4] & B[7];

wire row6b0,row6b1,row6b2,row6b3,row6b4;

assign row6b0 = A[5] & B[0]; 
assign row6b1 = A[5] & B[1]; 
assign row6b2 = A[5] & B[2]; 
assign row6b3 = A[5] & B[3]; 
assign row6b4 = A[5] & B[4]; 
//assign row6b5 = A[5] & B[5];
//assign row6b6 = A[5] & B[6];
//assign row6b7 = A[5] & B[7];

wire row7b0,row7b1,row7b2,row7b3;

assign row7b0 = A[6] & B[0]; 
assign row7b1 = A[6] & B[1]; 
assign row7b2 = A[6] & B[2]; 
assign row7b3 = A[6] & B[3]; 
//assign row7b4 = A[6] & B[4];
//assign row7b5 = A[6] & B[5];
//assign row7b6 = A[6] & B[6];
//assign row7b7 = A[6] & B[7];

wire row8b0,row8b1,row8b2;

assign row8b0 = A[7] & B[0]; 
assign row8b1 = A[7] & B[1]; 
assign row8b2 = A[7] & B[2]; 
//assign row8b3 = A[7] & B[3];
//assign row8b4 = A[7] & B[4];
//assign row8b5 = A[7] & B[5];
//assign row8b6 = A[7] & B[6];
//assign row8b7 = A[7] & B[7];

wire col_2_carryout1;
wire col_2_sum1;

HA col_2(.A(row1b1),.B(row2b0),.Cout(col_2_carryout1),.Sum(col_2_sum1));

// bit 0 of the sum is just the first bit in row 1

//adding row1b1,row2b0

 wire  col_3_sum1;
 wire  col_3_sum2;
 wire  col_3_carryout1;
 wire col_3_carryout2;
 
 
 FA co1_3(.A(row1b2),.B(row2b1),.Cin(row3b0),.Cout(col_3_carryout1),.Sum(col_3_sum1));          
     
 HA col_3col_2carryin(.A(col_2_carryout1),.B(col_3_sum1),.Cout(col_3_carryout2),.Sum(col_3_sum2));

//Adding row1b4,row2b2,row3b1,row4b0 + 2 carryins from col 3   
 
 wire col_4_carryout1;
 wire col_4_carryout2;
 wire col_4_carryout3;
 wire col_4_sum1;
 wire col_4_sum2;
 wire col_4_sum3;

 
 FA col_4_1(.A(row1b3),.B(row2b2),.Cin(row3b1),.Cout(col_4_carryout1),.Sum(col_4_sum1)); 
 
 FA col_4_2(.A(col_3_carryout1),.B(col_3_carryout2),.Cin(col_4_sum1),.Cout(col_4_carryout2),.Sum(col_4_sum2));
 
 HA col_4(.A(col_4_sum2),.B(row4b0),.Cout(col_4_carryout3),.Sum(col_4_sum3));
 
      
 //Adding row1b4,row2b3,row3b2,row4b1,row5b0, + 3 carryins from col 4     
      
 wire col_5_carryout1;
 wire col_5_carryout2;
 wire col_5_carryout3;
 wire col_5_carryout4;
 wire col_5_sum1;
 wire col_5_sum2;
 wire col_5_sum3;    
 wire col_5_sum4;  

 
 FA col_5_1(.A(row1b4),.B(row2b3),.Cin(row3b2),.Cout(col_5_carryout1),.Sum(col_5_sum1)); 
 
 FA col_5_2(.A(row4b1),.B(row5b0),.Cin(col_5_sum1),.Cout(col_5_carryout2),.Sum(col_5_sum2));
 
 FA col_5_3(.A(col_4_carryout1),.B(col_4_carryout2),.Cin(col_4_carryout3),.Cout(col_5_carryout3),.Sum(col_5_sum3));
 
 HA col_5_4(.A(col_5_sum2),.B(col_5_sum3),.Cout(col_5_carryout4),.Sum(col_5_sum4));


//Adding row1b5,row2b4,row3b3,row4b2,row5b1,row6b0, + 4 carryins from col 5
wire col_6_carryout1;
wire col_6_carryout2;
wire col_6_carryout3;
wire col_6_carryout4;
wire col_6_carryout5;
wire col_6_sum1;
wire col_6_sum2;
wire col_6_sum3;    
wire col_6_sum4;
wire col_6_sum5;  


FA col_6_1(.A(row1b5),.B(row2b4),.Cin(row3b3),.Cout(col_6_carryout1),.Sum(col_6_sum1));

FA col_6_2(.A(row4b2),.B(row5b1),.Cin(row6b0),.Cout(col_6_carryout2),.Sum(col_6_sum2));

FA col_6_3(.A(col_5_carryout1),.B(col_5_carryout2),.Cin(col_5_carryout3),.Cout(col_6_carryout3),.Sum(col_6_sum3));

FA col_6_4(.A(col_5_carryout4),.B(col_6_sum1),.Cin(col_6_sum2),.Cout(col_6_carryout4),.Sum(col_6_sum4));

HA col_6_5(.A(col_6_sum4),.B(col_6_sum3),.Cout(col_6_carryout5),.Sum(col_6_sum5));


//Adding row1b6,row2b5,row3b4,row4b3,row5b2,row6b1,row7b0 + 5 carryins from col 6
wire col_7_carryout1;
wire col_7_carryout2;
wire col_7_carryout3;
wire col_7_carryout4;
wire col_7_carryout5;
wire col_7_carryout6;
wire col_7_sum1;
wire col_7_sum2;
wire col_7_sum3;    
wire col_7_sum4;
wire col_7_sum5;
wire col_7_sum6;  
  
 
 
FA col_7_1(.A(row1b6),.B(row2b5),.Cin(row3b4),.Cout(col_7_carryout1),.Sum(col_7_sum1)); 

FA col_7_2(.A(row4b3),.B(row5b2),.Cin(row6b1),.Cout(col_7_carryout2),.Sum(col_7_sum2));

FA col_7_3(.A(row7b0),.B(col_6_carryout1),.Cin(col_6_carryout2),.Cout(col_7_carryout3),.Sum(col_7_sum3));

FA col_7_4(.A(col_6_carryout3),.B(col_6_carryout4),.Cin(col_6_carryout5),.Cout(col_7_carryout4),.Sum(col_7_sum4));

FA col_7_5(.A(col_7_sum1),.B(col_7_sum2),.Cin(col_7_sum3),.Cout(col_7_carryout5),.Sum(col_7_sum5));
 
HA col_7_6(.A(col_7_sum4),.B(col_7_sum5),.Cout(col_7_carryout6),.Sum(col_7_sum6));
 

//Adding row1b7,row2b6,row3b5,row4b4,row5b3,row6b2,row7b1,row8b0 + 6 carryins from col 7

wire col_8_carryout1;
wire col_8_carryout2;
wire col_8_carryout3;
wire col_8_carryout4;
wire col_8_carryout5;
wire col_8_carryout6;
wire col_8_carryout7;
wire col_8_sum1;
wire col_8_sum2;
wire col_8_sum3;    
wire col_8_sum4;
wire col_8_sum5;
wire col_8_sum6;
wire col_8_sum7;  
 
FA col_8_1(.A(row1b7),.B(row2b6),.Cin(row3b5),.Cout(col_8_carryout1),.Sum(col_8_sum1));

FA col_8_2(.A(row4b4),.B(row5b3),.Cin(row6b2),.Cout(col_8_carryout2),.Sum(col_8_sum2));

FA col_8_3(.A(row7b1),.B(row8b0),.Cin(col_7_carryout1),.Cout(col_8_carryout3),.Sum(col_8_sum3));

FA col_8_4(.A(col_7_carryout2),.B(col_7_carryout3),.Cin(col_7_carryout4),.Cout(col_8_carryout4),.Sum(col_8_sum4)); 

FA col_8_5(.A(col_7_carryout5),.B(col_7_carryout6),.Cin(col_8_sum1),.Cout(col_8_carryout5),.Sum(col_8_sum5));      
 
FA col_8_6(.A(col_8_sum2),.B(col_8_sum3),.Cin(col_8_sum4),.Cout(col_8_carryout6),.Sum(col_8_sum6));

HA col_8_7(.A(col_8_sum6),.B(col_8_sum5),.Cout(col_8_carryout7),.Sum(col_8_sum7));   

//Adding row2b7,row3b6,row4b5,row5b4,row6b3,row7b2,row8b1 + 7 carryins from col 8
wire col_9_carryout1;
wire col_9_carryout2;
wire col_9_carryout3;
wire col_9_carryout4;
wire col_9_carryout5;
wire col_9_carryout6;
wire col_9_carryout7;
wire col_9_sum1;
wire col_9_sum2;
wire col_9_sum3;    
wire col_9_sum4;
wire col_9_sum5;
wire col_9_sum6;
wire col_9_sum7;  
 

FA col_9_1(.A(row2b7),.B(row3b6),.Cin(row4b5),.Cout(col_9_carryout1),.Sum(col_9_sum1));

FA col_9_2(.A(row5b4),.B(row6b3),.Cin(row7b2),.Cout(col_9_carryout2),.Sum(col_9_sum2));

FA col_9_3(.A(row8b1),.B(col_8_carryout1),.Cin(col_8_carryout2),.Cout(col_9_carryout3),.Sum(col_9_sum3));

FA col_9_4(.A(col_8_carryout3),.B(col_8_carryout4),.Cin(col_8_carryout5),.Cout(col_9_carryout4),.Sum(col_9_sum4));

FA col_9_5(.A(col_8_carryout6),.B(col_8_carryout7),.Cin(col_9_sum1),.Cout(col_9_carryout5),.Sum(col_9_sum5));

FA col_9_6(.A(col_9_sum2),.B(col_9_sum3),.Cin(col_9_sum4),.Cout(col_9_carryout6),.Sum(col_9_sum6));

HA col_9_7(.A(col_9_sum5),.B(col_9_sum6),.Cout(col_9_carryout7),.Sum(col_9_sum7)); 
 

//Adding row3b7,row4b6,row5b5,row6b4,row7b3,row8b2 + 7 carryins from col 9
wire col_10_carryout1;
wire col_10_carryout2;
wire col_10_carryout3;
wire col_10_carryout4;
wire col_10_carryout5;
wire col_10_carryout6;
wire col_10_sum1;
wire col_10_sum2;
wire col_10_sum3;    
wire col_10_sum4;
wire col_10_sum5;
wire col_10_sum6;
 

FA col_10_1(.A(row3b7),.B(row4b6),.Cin(row5b5),.Cout(col_10_carryout1),.Sum(col_10_sum1));

FA col_10_2(.A(row6b4),.B(row7b3),.Cin(row8b2),.Cout(col_10_carryout2),.Sum(col_10_sum2));

FA col_10_3(.A(col_9_carryout1),.B(col_9_carryout2),.Cin(col_9_carryout3),.Cout(col_10_carryout3),.Sum(col_10_sum3));

FA col_10_4(.A(col_9_carryout4),.B(col_9_carryout5),.Cin(col_9_carryout6),.Cout(col_10_carryout4),.Sum(col_10_sum4));

FA col_10_5(.A(col_9_carryout7),.B(col_10_sum1),.Cin(col_10_sum2),.Cout(col_10_carryout5),.Sum(col_10_sum5));
 
FA col_10_6(.A(col_10_sum3),.B(col_10_sum4),.Cin(col_10_sum5),.Cout(col_10_carryout6),.Sum(col_10_sum6));


assign sum = {col_10_sum6,col_9_sum7,col_8_sum7,col_7_sum6,col_6_sum5,col_5_sum4,col_4_sum3,col_3_sum2,col_2_sum1,row1b0};

endmodule