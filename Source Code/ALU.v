`timescale 1ns / 1ps

// Current ALU operations supported, more to come soon
//4'b0000: ALU_Out = A + B;                 // Addition   
//4'b0001: ALU_Out = A - B;                 // Subtraction 
//4'b0010: HI & LO = A * B;                 // Multiplication Wallace Tree Multiplier 
//4'b0100: ALU_Out = A << 1;                // Logical shift left 
//4'b0101: ALU_Out = A >> 1;                // Logical shift right 
//4'b1100: ALU_Out = ~(A & B);              // Logical NAND 
//4'b1110: less_than_flag = (A < B) ? 8'd1 : 8'd0; // Less than comparison subtraction 
//4'b1111: is_equal = (A == B) ? 8'd1 : 8'd0;// Equality comparison 
// zero_flag just ORs all sum bits and negates them ~|Adder_out

module ALU(
    input  wire clk,
    input  wire rst,
    input  wire [7:0] A, B, // ALU 8-bit inputs
    input  wire [3:0] ALU_OP, // ALU_OP Signal coming in from FSM
    input  wire ALU_Enable,
    output reg [7:0] ALU_Out_Combinational, // ALU 8-bit output
    output reg [7:0] ALU_Out_Sequential,
    output wire overflow, // Carry out flag
    output reg less_than_flag, //comparison checker condition
    output reg is_equal, //Equality checker
    output wire zero_flag, // Zero checker
    output reg [7:0] HI, // High bits of multiplication
    output reg [7:0] LO // low bits of multiplication
);
    wire [15:0] wallace_out;
    reg [7:0] b;
    reg [7:0] a;
    wire [7:0] Adder_out; //Carry Select Adder output
    reg Cin; // Carry select adder Carry_in
    // if A > B then A - B will be positve if A < B then A - B will be negative. we can tell by looking at the MSB of number if it is negative or positive

    // Do not infer latches assign all outputs
    always @(*) begin
    // Defaults
    HI = 8'b00000000;
    LO = 8'b00000000;
    b = B;
    a = A;
    Cin = 1'b0;
    less_than_flag = 1'b0;
    is_equal = 1'b0;
    ALU_Out_Combinational = 8'b00000000;
    
    if(ALU_Enable) begin   
    case(ALU_OP) 
        4'b0000: begin // addition
        Cin = 0;  
        ALU_Out_Combinational = Adder_out;  
        end
        4'b0001: begin // Subtraction opcode
        Cin = 1;
        b = ~B;
        ALU_Out_Combinational = Adder_out;    
        end
        4'b1110: begin // comparison checker if A < B this will subtract A from B. if A > B then the A - B will be positive, if A < B then result will be negative
        // Perform A - B
        Cin = 1;
        b = ~B;
        
        // signed less than detection
        less_than_flag = overflow^SUM_MSB; // overflow will tell us if we should trust the sign, if 1, MSB is wrong, if 0, MSB is correct, if Overflow is 1, we need to flip the sign of MSB to get correct sign bit. we can flip the sign because we do not care about the actual value of the result, only the sign. less_than really represents true sign.
        if(less_than_flag)// This could be condensed down to just the ALU outputting 1, unnecesarry use of an if statement. for now lets just keep our flag
           ALU_Out_Combinational = 8'd1;
           
        end
        4'b1111: begin // Equality checker
        is_equal = ~|(a^b); // Equivalence checker that will detect if 8 bits of input A and B vary, then OR them into a single 1 bit value and negate it   
          
        end
        4'b1100: begin // NAND
        ALU_Out_Combinational = ~(a & b); 
        end
        4'b0010: begin // Multiplication, currently supports unsigned integers, will look into Booths Encoding
        HI = {wallace_out[15],wallace_out[14],wallace_out[13],wallace_out[12],wallace_out[11],wallace_out[10],wallace_out[9],wallace_out[8]};
        LO = {wallace_out[7],wallace_out[6],wallace_out[5],wallace_out[4],wallace_out[3],wallace_out[2],wallace_out[1],wallace_out[0]};
        end
        4'b0100: begin //shift bits left, using b as the shamt value, max shamt of 8. this will drop the MSB and keep LSBs
        case(b) 
        8'd1: ALU_Out_Combinational = {a[6:0],1'b0};
        8'd2: ALU_Out_Combinational = {a[5:0],2'b0};
        8'd3: ALU_Out_Combinational = {a[4:0],3'b0};
        8'd4: ALU_Out_Combinational = {a[3:0],4'b0};
        8'd5: ALU_Out_Combinational = {a[2:0],5'b0};
        8'd6: ALU_Out_Combinational = {a[1:0],6'b0};
        8'd7: ALU_Out_Combinational = {a[0],7'b0};
        8'd8: ALU_Out_Combinational = 8'b00000000;
        default: ALU_Out_Combinational = 8'b00000000; 
        endcase
        end
        4'b0101: begin //sra, using b as shamt, will keep MSB(sign) and drop LSBs, this is signed division by 2^n
        case(b) 
        8'd1: ALU_Out_Combinational = {a[7],a[7:1]};
        8'd2: ALU_Out_Combinational = {{2{a[7]}},a[7:2]};
        8'd3: ALU_Out_Combinational = {{3{a[7]}},a[7:3]};
        8'd4: ALU_Out_Combinational = {{4{a[7]}},a[7:4]};
        8'd5: ALU_Out_Combinational = {{5{a[7]}},a[7:5]};
        8'd6: ALU_Out_Combinational = {{6{a[7]}},a[7:6]};
        8'd7: ALU_Out_Combinational = {{7{a[7]}},a[7]};
        8'd8: ALU_Out_Combinational = {{8{a[7]}}};
        default: ALU_Out_Combinational = {{8{a[7]}}}; 
        endcase
        end

        endcase
    end
end

    assign SUM_MSB = Adder_out[7]; // MSB will be the sign bit
    
    assign zero_flag = ~|Adder_out; // will tell us if the result of an ALU operation is 0
      
    Signed_Carry_Select_Adder ALU_ADDER(.A(a),.B(b),.Cin(Cin),.sum_out(Adder_out),.overflow(overflow)); // signed carry select adder
    
    Wallace_Tree_Multiplier ALU_MUL(.A(a),.B(b),.sum(wallace_out)); //we need to wire the product into 2 special registers in the datapath
    
    
    always @(posedge clk) begin
        if(rst)
            ALU_Out_Sequential <= 8'd0;
        else begin
        if(ALU_Enable)
            ALU_Out_Sequential <= ALU_Out_Combinational;
        
        end 
    
    end
    

endmodule
