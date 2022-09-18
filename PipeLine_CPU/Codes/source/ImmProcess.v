`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/25
// Design Name: PipelineCPU
// Module Name: ImmExtend
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4 
// Description: extend the immediate (signed or unsigned)
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ImmProcess (Imm, LuiOp, SignedOp, ImmExtOut);

input [15:0] Imm;
input LuiOp;
input SignedOp;

output [31:0] ImmExtOut;

wire [31:0] ImmExt;

assign ImmExt = {SignedOp ? {16{Imm[15]}}: 16'h0000, Imm};
assign ImmExtOut = LuiOp? {Imm, 16'h0000}: ImmExt;

endmodule
