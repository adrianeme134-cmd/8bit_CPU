`timescale 1ns / 1ps


module CPU_Core(
input wire clk,
input wire rst,
output reg [7:0] core_output
    );

    reg [7:0] instruction_byte [0:7]; // 8 entries of byte addressable memory
    parameter ADDRESS_WIDTH = 3; // 3 bits to address up to 8 bytes
    reg [15:0] Fetch; // Instruction Register 
    
    // Eventually this needs to move out of the datapath, its ok for now for simulation and testing
    initial begin
        // 8 ROM modules will store up to 4 instructions of byte addressed memory
        instruction_byte[0] = 8'b00010100; 
        instruction_byte[1] = 8'b00010100; 
        instruction_byte[2] = 8'b00010100; 
        instruction_byte[3] = 8'b00010100; 
        instruction_byte[4] = 8'b00010100;
        instruction_byte[5] = 8'b00010100;
        instruction_byte[6] = 8'b00010100; 
        instruction_byte[7] = 8'b00010100; 
    end

    // Program counter interface
    wire PC_en; // Signal coming in from FSM to enable PC
    wire jump_en; // Signal for FSM CHECK THIS FLAG AS FSM DOES NOT HAVE IT
    wire [2:0] next_pc_value; //Branching and jumping target PC (target Address)
    wire [2:0] pc; // register that comes out of program counter module
    
    // Program counter will start at byte 0 and increment each clk when FSM asserts signal
    PC program_counter_module(
    .clk(clk),
    .rst(rst),
    .PC_en(PC_en),
    .jump_en(jump_en),
    .next_pc_value(next_pc_value),
    .pc(pc)
    );

    // PC wired to Instruction register here, (PC and Instruction Register wired successfully)
    // assign Fetch = {instruction_byte[pc+1],instruction_byte[pc]}; this is a mistake and we cannot do this because program counter signals are not stable and will flick through states
    // Fetch must be a reg implying it must be clocked for signal stability
    always@(posedge clk) begin
    Fetch <= {instruction_byte[pc+1],instruction_byte[pc]};
    end
    
    // Decoder Interface
    wire [2:0] Register_Destination;// wire that connects to Register file
    wire [2:0] Register_1_operand; // wire that connects to Register file
    wire [2:0] Register_2_operand; // wire that connects to Register file
    wire [3:0]Opcode; // wire that connects to FSM
    wire ALUsrc; //Flag, 1 for immediate instructions 0 for Reg to reg instructions
    
    Decoder Decoder_module(
    .Fetch(Fetch),
    .Register_Destination(Register_Destination),
    .Register_1_operand(Register_1_operand),
    .Register_2_operand(Register_2_operand),
    .Opcode(Opcode),
    .ALUsrc(ALUsrc)
    );
   
   // Register file Interface
    wire reg_write; // Flag to write to reg coming from FSM
    wire [7:0] data_out1; // Outputting Reg 1 data from Register file at all times (combinational read)
    wire [7:0] data_out2; // Outputting Reg 2 data from Register file at all times (combinational read)
    wire [7:0] data_in; // Wire from data driven by ALU
    
    Register_file Reg_module(
    .clk(clk),
    .Register_Destination(Register_Destination),
    .Register_1_operand(Register_1_operand),
    .Register_2_operand(Register_2_operand),
    .reg_write(reg_write),
    .data_in(data_in),
    .data_out1(data_out1),
    .data_out2(data_out2)
    );
    
    // FSM Interface 
    wire [3:0] ALUOp; // 4 bit ALU wire Operation code coming out to ALU
    wire MemWrite; // Control flag to write to RAM
    wire MemRead; // Flag to read from RAM
    wire IRWrite; //Flag to write to Instruction Register
    
    
    FSM Control_logic_module(
    .clk(clk),
    .Opcode(Opcode),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .RegWrite(reg_write),
    .MemRead(MemRead),
    .PCWrite(PC_en)
    ,.IRWrite(IRWrite)
    );
    
    
endmodule
