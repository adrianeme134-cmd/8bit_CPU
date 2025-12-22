`timescale 1ns / 1ps

module CPU_Core_TB;
     reg clk;
     reg rst;
     wire [7:0] ALU_Data;
     wire [5:0] Current_state;
     wire [7:0] PC;
     wire [7:0] REG1;
     wire [7:0] REG2;
     wire [15:0] Current_fetch;
     wire IRWrite_Top;
     wire MemWrite_Top;
     wire MemRead_Top;
     wire PC_en_Top;
     wire RegWrite_Top;
     
     CPU_Core DUT(.clk(clk),
     .rst(rst),
     .ALU_Data(ALU_Data),
     .Current_state(Current_state),
     .PC(PC),
     .REG1(REG1),
     .REG2(REG2),
     .Current_fetch(Current_fetch),
     .IRWrite_Top(IRWrite_Top),
     .MemWrite_Top(MemWrite_Top),
     .MemRead_Top(MemRead_Top),
     .PC_en_Top(PC_en_Top),
     .RegWrite_Top(RegWrite_Top)
     );
     
     always #5 clk = ~clk;
     
 
     
     initial begin
     
     //$display("R0 = %0d", DUT.Reg_module.Register[0]);
     //$display("R1 = %0d", DUT.Reg_module.Register[1]);

     
     clk = 0;
     rst = 1;
     
     @(posedge clk);
     @(posedge clk);
      
     rst = 0;
     
     $write("\n");
     
     $display("rst done");
     
     $write("\n");
     

     @(posedge clk);
     @(posedge clk);
     @(posedge clk);
    
    $display("ADDI Instruction");
    
    $write("\n");

     @(posedge clk);
     @(posedge clk);
     @(posedge clk);
     
     $display("ADD Instruction");
     
     $write("\n");
     
     @(posedge clk);
     @(posedge clk);
     @(posedge clk);
     
     $display("SUBI Instruction");
     
     $write("\n");
     
     @(posedge clk);
     @(posedge clk);
     @(posedge clk);
     
     $display("SLTI Instruction");
     
     $write("\n");
     
     @(posedge clk);
     @(posedge clk);
     @(posedge clk);
     
     @(posedge clk);

     
     $write("\n");
     
     $stop;
     
     
     end
     
    
endmodule
