`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/28
// Design Name: PipelineCPU
// Module Name: PC
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: 
// Description: PC, considered PC hold caused by hazard.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module PC (clk, reset, PC_i, PC_Keep, PC_o);

input clk;
input reset;
input [31:0] PC_i;
input PC_Keep;

output reg [31:0] PC_o;

initial 
begin
    PC_o <= 32'h0;
end

always @(posedge clk or posedge reset) 
begin
    PC_o <= reset ? 32'h0 
        : !PC_Keep ? PC_i
        : PC_o;
end

endmodule
