`timescale 1ns / 1ps


// FA will add 2 1 bit numbers with carry in 

module FA(
    input A,
    input B,
    input Cin,
    output Cout,
    output Sum
    );
  
   wire Temp; 
   
   assign Temp = A ^ B;
    
   assign Sum = Temp ^ Cin; 
   
   assign Cout = ((Cin & Temp) | (A & B));
    
    
endmodule
