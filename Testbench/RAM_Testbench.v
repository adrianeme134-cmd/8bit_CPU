`timescale 1ns / 1ps

module RAM_Testbench;

    reg clk;
    reg write_enable;
    reg [9:0] address;
    reg [7:0] data_in;
    wire [7:0] data_out;
    
    // Instantiate the RAM
    Data_RAM uut (
        .clk(clk),
        .write_enable(write_enable),
        .address(address),
        .data_in(data_in),
        .data_out(data_out)
    );
    
    // 10ns clock period (100 MHz)
    always #5 clk = ~clk; 
    
    initial begin
        clk = 0;
        write_enable = 0;
        address = 0;
        data_in = 0;

        // Wait for the first posedge to start cleanly
        @(posedge clk);

        // Write 0xFF to address 1
        address = 10'b000000000; data_in = 8'hFF; write_enable = 1;
        @(posedge clk);
        write_enable = 0;

        // Write 0xAA to address 2
        address = 2; data_in = 8'hAA; write_enable = 1;
        @(posedge clk);
        write_enable = 0;

        // Write 0xF0 to address 3
        address = 3; data_in = 8'hF0; write_enable = 1;
        @(posedge clk);
        write_enable = 0;

        // Give the RAM a cycle to process
        @(posedge clk);

        // Read back values
        address = 10'b000000000;
        @(posedge clk); // wait one clock for data to update
        $display("Address 1 = %b", data_out);

        address = 2;
        @(posedge clk);
        $display("Address 2 = %b", data_out);

        address = 3;
        @(posedge clk);
        $display("Address 3 = %b", data_out);

        $finish;
    end

endmodule
