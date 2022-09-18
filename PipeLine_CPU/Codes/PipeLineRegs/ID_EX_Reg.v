`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/28
// Design Name: PipelineCPU
// Module Name: ID_EX_Reg
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4 
// Description:  PipeLine regs between the ID and EX stages
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ID_EX_Reg (clk,reset,flush,ID_RegWr,ID_Branch,ID_BranchControl,ID_MemRead,
            ID_MemWrite,ID_MemtoReg,ID_ALUSrcA,ID_ALUSrcB,ID_ALUOp,ID_RegDst,
            ID_ReadData1,ID_ReadData2,ID_imm_ext,ID_PC_Plus_4,ID_Shamt,ID_rt,ID_rd,
            ID_LwLb);

    input clk, reset, flush;

    input ID_RegWr, ID_Branch, ID_BranchControl, ID_MemRead, ID_MemWrite;
    input [1:0] ID_MemtoReg;
    input ID_ALUSrcA, ID_ALUSrcB;
    input [3:0] ID_ALUOp;
    input [1:0] ID_RegDst;

    input [31:0] ID_ReadData1, ID_ReadData2, ID_imm_ext, ID_PC_Plus_4;
    input [4:0] ID_Shamt, ID_rt, ID_rd;
    input ID_LwLb;

    reg RegWr, Branch, BranchControl, MemRead, MemWrite, LwLb;
    reg [1:0] MemtoReg;
    reg ALUSrcA, ALUSrcB;
    reg [3:0] ALUOp;
    reg [1:0] RegDst;

    reg [31:0] ReadData1, ReadData2,imm_ext;
 
    reg [31:0] PC_Plus_4;
    reg [4:0] rd, rt, Shamt;

    always @(posedge clk or posedge reset) begin
        if (reset || flush) 
        begin
            RegWr <= 0;
            Branch <= 0;            BranchControl <= 0;
            MemRead <= 0;           MemWrite <= 0;          MemtoReg <= 0;            
            ALUSrcA <= 0;           ALUSrcB <= 0;           ALUOp <= 0;
            RegDst <= 0;
            LwLb <= 0;
            ReadData1 <= 0;         ReadData2 <= 0;
            imm_ext <= 0;
            PC_Plus_4 <= 0;
            Shamt <= 0;
            rt <= 0;                rd <= 0;
        end
        else 
        begin
            RegWr <= ID_RegWr;
            Branch <= ID_Branch;
            BranchControl <= ID_BranchControl;
            MemRead <= ID_MemRead;
            MemWrite <= ID_MemWrite;
            MemtoReg <= ID_MemtoReg;
            ALUSrcA <= ID_ALUSrcA;
            ALUSrcB <= ID_ALUSrcB;
            ALUOp <= ID_ALUOp;
            RegDst <= ID_RegDst;
            LwLb <= ID_LwLb;
            ReadData1 <= ID_ReadData1;
            ReadData2 <= ID_ReadData2;
            imm_ext <= ID_imm_ext;
            PC_Plus_4 <= ID_PC_Plus_4;
            rt <= ID_rt;
            rd <= ID_rd;
            Shamt <= ID_Shamt;
        end
    end

    endmodule
