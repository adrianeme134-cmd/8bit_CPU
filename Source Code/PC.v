`timescale 1ns / 1ps

// Address width is defined by how deep the ROM module is. for testing, I've made 8 entries and we need 3 bits to address to all values

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
            pc <= {1'b0}; // Reset PC to 0
        end else if (PC_en) begin
            if (jump_en) begin
                pc <= next_pc_value; // Load new PC value (e.g., for branch/jump)
            end else begin
                pc <= pc + 2; // Increment by 2 bytes because the next instruction is 2 bytes away in memory, 
                // Each instruction is byte addrresable, and our instrcutions are 16 bits long so we need 8 + 8 bits to assemble the instruction
            end
        end
    end

endmodule


