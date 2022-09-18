`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/28
// Design Name: PipelineCPU
// Module Name: IF_ID_Reg
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4 
// Description:  PipeLine regs between the IF and ID stages
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module IF_ID_Reg (clk,reset,flush,hold,Instruction,IF_PC_Plus_4);

    input clk;
    input reset;
    input flush;
    input hold;
    input [31:0] Instruction;
    input [31:0] IF_PC_Plus_4;

    reg [5:0] OpCode;
    reg [4:0] rs;
    reg [4:0] rt;
    reg [4:0] rd;
    reg [4:0] Shamt;
    reg [5:0] Funct;
    reg [31:0] PC_Plus_4;
    reg [31:0] Inst;

    always @(posedge clk or posedge reset) 
    begin
        if (reset || (flush && !hold))  // all->0
        begin
            OpCode <= 0;
            rs <= 0;
            rt <= 0;
            rd <= 0;
            Shamt <= 0;
            Funct <= 0;
            PC_Plus_4 <= 0;
            Inst <= 0;
        end
        else               // do as normal
        if (!hold)
        begin
            OpCode <= Instruction[31:26];
            rs <= Instruction[25:21];
            rt <= Instruction[20:16];
            rd <= Instruction[15:11];
            Shamt <= Instruction[10:6];
            Funct <= Instruction[5:0];
            PC_Plus_4 <= IF_PC_Plus_4;
            Inst <= Instruction;
        end
    end

endmodule
