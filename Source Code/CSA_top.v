`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2025 04:22:26 PM
// Design Name: 
// Module Name: CSA_top
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


module CSA_top(
    // Input registers
    input wire clk,
    output wire [7:0] sum_out,
    output wire Cout
);

    // Input registers (must NOT be constant)
    reg [7:0] A_reg = 8'h01;
    reg [7:0] B_reg = 8'h03;
    reg       Cin_reg = 1'b0;

    // Change inputs so Vivado doesn't optimize them away
    always @(posedge clk) begin
        A_reg   <= A_reg + 8'h11;
        B_reg   <= B_reg + 8'h07;
        Cin_reg <= ~Cin_reg;
    end

    // CSA output
    Carry_Select_Adder dut (
        .A(A_reg),
        .B(B_reg),
        .Cin(Cin_reg),
        .sum_out(sum_out),
        .Cout(Cout)
    );

endmodule
