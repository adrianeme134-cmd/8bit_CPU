`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2025 04:37:14 PM
// Design Name: 
// Module Name: RAM_TEST
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


module RAM_TEST;


reg clk;
reg write_enable;
reg [3:0]address;
reg [7:0]data_in;
wire [7:0]data_out;

Data_RAM uut(clk,write_enable,address,data_in,data_out);


//I had timing issues with setting the rising edge clock initially in the test bench, aka it was showing
//nothing even though the code was fine because I was not using #10 to toggle the rising edge

always #5 clk = ~clk; // 10ns clock period aka 100Mhz



    initial begin
        clk = 0;
        data_in = 8'b11111111;
        write_enable = 1;
        address = 1;
        #10
        write_enable = 0;
        #10
        data_in = 8'b10101010;
        write_enable = 1;
        address = 2;
        write_enable = 0;
        
        data_in = 8'b11110000;
        write_enable = 1;
        address = 3;
        write_enable = 0;

        $finish;
    end

endmodule
