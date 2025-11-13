`timescale 1ns / 1ps

module FSM_TB;

reg clk;
reg [3:0] Opcode;
reg rst;

wire [3:0] ALUOp;
wire MemWrite;
wire RegWrite;
wire MemRead;
wire PCWrite;
wire IRWrite;

FSM uut(
.clk(clk),
.rst(rst),
.Opcode(Opcode),
.ALUOp(ALUOp),
.MemWrite(MemWrite),
.RegWrite(RegWrite),
.MemRead(MemRead),
.PCWrite(PCWrite),
.IRWrite(IRWrite));

// Lesson, #10 are just delays. we need to use @(posedge clk) to align our testbench to the positive edge of the clock
// instructions cycle takes 30ns, meaning each instruction takes 30ns to completely execute
// I learned the importance of testing modules before implementation, had I not tested and implemented in top module,
// I would've never figured out my FSM control module had issues with it
always #5 clk = ~clk; //10ns period aka 100MHZ

initial begin

    clk = 0;
    rst= 1;

    
     @(posedge clk);
     @(posedge clk);
     rst = 0; // Waiting 2 clks to desassert reset
     
     @(posedge clk); // Buffer after reset
     Opcode = 4'b1010; // Store Word instruction
     @(posedge clk); // FETCH
     @(posedge clk); // EXECUTE
     @(posedge clk); // WRITEBACK
     
     @(posedge clk); // Next FETCH


    $stop;

end






endmodule
