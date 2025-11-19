`timescale 1ns / 1ps

module Ten_bit_Wallace_Tree_TB;

reg [7:0] A;
reg [7:0] B;
wire [9:0] sum;


Ten_Bit_Wallace_Tree_Multiplier uut(.A(A),.B(B),.sum(sum));


initial begin

A = 8'h24; B = 8'h11;



end

endmodule
