`timescale 1ns / 1ps

module Reg_file_test;

    reg clk;
    reg rst;
    reg [2:0] Register_Destination;
    reg [2:0] Register_1_operand;
    reg [2:0] Register_2_operand;
    reg RegWrite;
    reg [7:0] data_in;
    wire [7:0] data_out1;
    wire [7:0] data_out2;

    Register_file uut(
    .clk(clk),
    .rst(rst),
    .Register_Destination(Register_Destination),
    .Register_1_operand(Register_1_operand),
    .Register_2_operand(Register_2_operand),
    .RegWrite(RegWrite),
    .data_in(data_in),
    .data_out1(data_out1),
    .data_out2(data_out2));

    always #5 clk = ~clk;

    initial begin
    
    clk = 0;
    rst = 1; // Resets registers to known states 8'b0
    
    @(posedge clk);
    rst = 0;
    
    @(posedge clk);  //Buffers between reset and regwrite
    @(posedge clk);
    
    RegWrite = 1; // Write enable to register 0 and register 7
    data_in = 8'b10101010;// Written to Reg 0
    Register_Destination = 3'b000;
    
    @(posedge clk); // clk to refresh data_in 
    
    data_in = 8'b11110000;
    Register_Destination = 3'b111;// Written to reg 7
    
    @(posedge clk);
    
    RegWrite = 0;
    Register_1_operand = 3'b000; // Reading outputs from reg 0
    Register_2_operand = 3'b111; // Reading outputs from reg 7
    
    @(posedge clk);
    @(posedge clk);
    
    #100;
    $stop;
    
    end
    
    
endmodule
