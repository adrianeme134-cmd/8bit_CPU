`timescale 1ns / 1ps

module Wallace_Tree_TB;

reg [7:0] A;
reg [7:0] B;
wire [15:0] sum;


Wallace_Tree_Multiplier uut(.A(A),.B(B),.sum(sum));


initial begin

A = 8'h24; B = 8'h11;



end

endmodule
