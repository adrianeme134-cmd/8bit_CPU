`timescale 1ns / 1ps

module RAM_TEST;


reg clk;
reg write_enable;
reg [3:0]address;
reg [7:0]data_in;
wire [7:0]data_out;

Data_RAM uut (
    .clk(clk),
    .write_enable(write_enable),
    .address(address),
    .data_in(data_in),
    .data_out(data_out)
);


//I had timing issues with setting the rising edge clock initially in the test bench, aka it was showing
//nothing even though the code was fine because I was not using #10 to toggle the rising edge

always #5 clk = ~clk; // 10ns period aka 100MHz clock


initial begin
    clk = 0;
    write_enable = 0;
    address = 0;
    data_in = 0;

    // Write 0xFF to address 1
    #10;
    address = 1;
    data_in = 8'hFF;
    write_enable = 1;
    #10;
    write_enable = 0;

    // Write 0xAA to address 2
    #10;
    address = 2;
    data_in = 8'hAA;
    write_enable = 1;
    #10;
    write_enable = 0;

    // Write 0xF0 to address 3
    #10;
    address = 3;
    data_in = 8'hF0;
    write_enable = 1;
    #10;
    write_enable = 0;

    // Read back values
    #10;
    address = 1;
    #10;
    address = 2;
    #10;
    address = 3;
    #10;

    $finish;
end

endmodule
