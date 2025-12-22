`timescale 1ns / 1ps

module Register_file(
    input wire clk,
    input wire rst,
    input wire [2:0] Register_Destination, // ptr to destination register
    input wire [2:0] Register_1_operand, // ptr to register 1
    input wire [2:0] Register_2_operand, // ptr to register 2
    input wire RegWrite, // RegWrite signal coming from FSM
    input wire [7:0] data_in, //data_in coming from other modules
    output reg [7:0] instr_data_out1, // Outputs register 1 ptr
    output reg [7:0] instr_data_out2 // outputs register 2 ptr

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
        instr_data_out1 = Register[Register_1_operand];
        instr_data_out2 = Register[Register_2_operand];
    end
    
        // Showing contents of all registers
    integer k;

    always @(posedge clk) begin
    
        $write("T=%0t Register file STATE:", $time);
    
        for (k = 0; k < 8; k = k + 1) 
            $write(" R%0d=%0d", k, Register[k]);
            
        $write("\n");
    end

endmodule
