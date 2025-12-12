`timescale 1ns / 1ps


module PC (
    input wire clk,
    input wire rst,
    input wire PC_en,
    input wire jump_en,
    input wire [2:0] next_pc_value, // For branching/jumping
    output reg [2:0] pc
);

    always @(posedge clk) begin
        if (rst) begin
            pc <= 2'b0; 
        end else if (PC_en) begin // Increase Program counter asserted by FSM
            if (jump_en) begin
                pc <= next_pc_value; // Load new PC value (e.g., for branch/jump)
            end else begin
                pc <= pc + 2; // Increment by 2 bytes because the next instruction is 2 bytes away in memory, 
                
            end
        end
    end

endmodule


