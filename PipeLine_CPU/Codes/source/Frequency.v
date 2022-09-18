`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/07/01
// Design Name: PipelineCPU
// Module Name: Frequency
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4 
// Description: store datas
// 
// Dependencies: As the Maximum normal operating frequency is 80MHz, 
//                  so it is necessary to divide the frequency.
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Frequency (system_clk,clk); 

    input system_clk;
    output reg clk; 

    initial 
    begin
        clk <= 0;
    end

    always @(posedge system_clk)   //100MHz->50kHz
    begin
            clk <= ~clk;   
    end

endmodule

