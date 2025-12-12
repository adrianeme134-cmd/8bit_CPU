`timescale 1ns / 1ps


module ALU_TB;
reg [7:0] A;
reg [7:0] B;
reg [3:0] ALU_OP;
wire [7:0] ALU_Out;
wire overflow;
wire less_than_flag;
wire is_equal;
wire zero_flag;
wire [7:0] HI;
wire [7:0] LO;

ALU DUT(
.A(A),
.B(B),
.ALU_OP(ALU_OP),
.ALU_Out(ALU_Out),
.overflow(overflow),
.less_than_flag(less_than_flag),
.is_equal(is_equal),
.zero_flag(zero_flag),
.HI(HI),
.LO(LO)
);

initial begin

A = 8'b00000001; B = 8'b11111111; ALU_OP = 4'b0000; // 1 + (-1) = 0 Addition OPCODE

#50;

A = 8'b00000001; B = 8'b11111111; ALU_OP = 4'b0001; // 1 - (-1) = 2 Subtraction OPCODE

#50;

A = 8'b00000001; B = 8'b11111111; ALU_OP = 4'b1110; // 1 < -1 = FALSE Comparison checker (A < B) OPCODE

#50;

A = 8'b11111111; B = 8'b00000001; ALU_OP = 4'b1110; // -1 < 1 = TRUE Comparison checker (A < B) OPCODE

#50;

A = 8'b11111111; B = 8'b00000001; ALU_OP = 4'b1111; // -1 = 1 = FLASE Equality checker (A == B) OPCODE

#50;

A = 8'b11111111; B = 8'b11111111; ALU_OP = 4'b1111; // -1 = -1 = TRUE Equality checker (A == B) OPCODE

#50;

A = 8'b00000000; B = 8'b00000000; ALU_OP = 4'b1100; // ~(A & B) = 8'b11111111 NAND OPCODE

#50;

A = 8'b11111111; B = 8'b11111111; ALU_OP = 4'b0010; // 255 * 255 = 1 Multiplication OPCODE *UNSIGNED FOR NOW* 

#50;

A = 8'b00000001; B = 8'd7; ALU_OP = 4'b0100; // A << 7 = 256 A is value, B is shamt UNSIGNED SLL OPCODE

#50;

A = 8'b10000000; B = 8'd7; ALU_OP = 4'b0101; // A >>> 7 = -1 A is value, B is shamt SIGNED SRA OPCODE

$finish;

end

endmodule
