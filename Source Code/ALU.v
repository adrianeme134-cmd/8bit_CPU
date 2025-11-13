`timescale 1ns / 1ps

// TODO: Implement Carrys select Adder and shift-add multiplier in the future
// For testing purposes +*/<< operators work for now this would need a future rewrite
module ALU(
    input  [7:0] A, B,        // ALU 8-bit inputs
    input  [3:0] ALU_Sel,     // ALU operation select
    output [7:0] ALU_Out,     // ALU 8-bit output
    output       CarryOut     // Carry out flag
);

    reg  [7:0] ALU_Result;
    wire [8:0] tmp;

    assign tmp      = {1'b0, A} + {1'b0, B};
    assign CarryOut = tmp[8];           // Carry-out flag
    assign ALU_Out  = ALU_Result;       // Output result

    always @(*) begin
        case (ALU_Sel)
            4'b0000: ALU_Result = A + B;                 // Addition
            4'b0001: ALU_Result = A - B;                 // Subtraction
            4'b0010: ALU_Result = A * B;                 // Multiplication
            4'b0011: ALU_Result = A / B;                 // Division
            4'b0100: ALU_Result = A << 1;                // Logical shift left
            4'b0101: ALU_Result = A >> 1;                // Logical shift right
            4'b0110: ALU_Result = {A[6:0], A[7]};        // Rotate left
            4'b0111: ALU_Result = {A[0], A[7:1]};        // Rotate right
            4'b1000: ALU_Result = A & B;                 // Logical AND
            4'b1001: ALU_Result = A | B;                 // Logical OR
            4'b1010: ALU_Result = A ^ B;                 // Logical XOR
            4'b1011: ALU_Result = ~(A | B);              // Logical NOR
            4'b1100: ALU_Result = ~(A & B);              // Logical NAND
            4'b1101: ALU_Result = ~(A ^ B);              // Logical XNOR
            4'b1110: ALU_Result = (A > B) ? 8'd1 : 8'd0; // Greater comparison
            4'b1111: ALU_Result = (A == B) ? 8'd1 : 8'd0;// Equality comparison
            default: ALU_Result = 8'b00000000;           // Default output
        endcase
    end

endmodule
