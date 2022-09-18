`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: Shao Chenyang
// 
// Create Date: 2022/07/01
// Design Name: PipelineCPU
// Module Name: TestBench
// Project Name: PipelineCPU
// Target Devices: 
// Tool Versions: 2017.4
// Description: used for test 
// 
// Dependencies: None
// 
// Revision: None
// Revision 0.01 - File Created
// Additional Comments: None
// 
//////////////////////////////////////////////////////////////////////////////////

module TestCPU();

    reg clk;
    reg reset;
    wire [3:0] an;
    wire [7:0] bcd;
    wire [7:0] leds;
    wire [7:0] bug;

    PipelineCPU PipelineCPU(clk, reset, leds, an, bcd, bug);

    initial 
    begin
        clk <= 0;
        reset <= 0;
        #15 reset <= 1;
        #20 reset <= 0;
        #5000 reset <= 1;
        #5100 reset <= 0;
    end
    
    always #5 clk <= ~clk;
    
endmodule
