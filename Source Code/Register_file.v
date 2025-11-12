`timescale 1ns / 1ps

module Register_file(
    input wire clk,
    input wire  [2:0] Register_Destination, //3 bit field where output bits will live, coming in from decoder
    input wire  [2:0] Register_1_operand, //3 bit field where register 1 lives from decoder aka adress of field 1
    input wire  [2:0] Register_2_operand, //3 bit field where register 2 lives from decoder aka address of field 2
    input wire reg_write, // Flag Coming in from FSM
    input [7:0]data_in, // data to write to a register coming from an ALU or some other place
    output reg [7:0]data_out1, // outputs data coming from reg 1
    output reg [7:0]data_out2 // outputs data coming out from reg 2
    );
    
    reg [7:0]ram_block[0:7]; // 8 Registers R0-R7 8 bit wide each
    // 4 Registers to save  
    
    // Synchronous write, 10ns write, 1 clock to write and read
    always @(posedge clk) begin
            if(reg_write) //Write to the destination register
                ram_block[Register_Destination] <= data_in;
    end
    
    // Combinational asynchronous read because instructions need instant access to registers
    always @(*) begin
    
        data_out1 = ram_block[Register_1_operand]; // Because most instructions include 2 registers, we must always read out both registers at the same time
        data_out2 = ram_block[Register_2_operand];
    
    end
    
    
endmodule
