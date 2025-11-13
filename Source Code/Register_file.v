`timescale 1ns / 1ps

module Register_file(
    input wire clk,
    input wire rst,
    input wire [2:0] Register_Destination,
    input wire [2:0] Register_1_operand,
    input wire [2:0] Register_2_operand,
    input wire RegWrite,
    input wire [7:0] data_in,
    output reg [7:0] data_out1,
    output reg [7:0] data_out2
);

    reg [7:0] Register[0:7]; // 8 Registers available
    integer i;

    // Synchronous write + synchronous reset
    always @(posedge clk) begin
        if (rst) begin
            // reset all 8 registers
            for (i = 0; i < 8; i = i + 1)
                Register[i] <= 8'd0;
        end 
        else if (RegWrite) begin
            Register[Register_Destination] <= data_in;
        end
    end

    // combinational read
    always @(*) begin
        data_out1 = Register[Register_1_operand];
        data_out2 = Register[Register_2_operand];
    end

endmodule
