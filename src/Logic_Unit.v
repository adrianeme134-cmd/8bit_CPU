`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 12:08:43 PM
// Design Name: 
// Module Name: Logic_Unit
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


module Logic_Unit(
    input [7:0] Decoder,
    input clk
    );
    
    	always @ (posedge clk) begin
        if (Decoder)
            q <= 0;
        else
            q <= d;
    end
endmodule
    
endmodule
