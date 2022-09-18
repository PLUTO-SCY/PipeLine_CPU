`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/28
// Design Name: PipelineCPU
// Module Name: EX_MEM_Reg
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

module EX_MEM_Reg (clk, reset, EX_MemRead, EX_MemWrite, EX_WriteData, EX_WriteAddr,
                EX_MemtoReg, EX_RegWrite, EX_ALU_out, EX_PC_Plus_4, EX_LwLb); 

    input clk;
    input reset;

    input EX_MemRead;
    input EX_MemWrite;
    input [31:0] EX_WriteData;
    input [4:0] EX_WriteAddr;
    input [1:0] EX_MemtoReg;
    input EX_RegWrite;
    input [31:0] EX_ALU_out;
    input [31:0] EX_PC_Plus_4;
    input EX_LwLb;

    reg [31:0]WriteData ;
    reg [4:0] WriteAddr ;
    reg [1:0] MemtoReg;
    reg [31:0]ALU_out ;
    reg [31:0]PC_Plus_4 ;
    reg LwLb;
    reg MemRead ;
    reg MemWrite;
    reg RegWrite;

    always @(posedge clk or posedge reset) 
    begin
        if (reset) 
        begin
            MemRead <= 0;
            MemWrite <= 0;
            WriteData <= 0;
            WriteAddr <= 0;
            MemtoReg <= 0;
            RegWrite <= 0;
            ALU_out <= 0;
            PC_Plus_4 <= 0;
            LwLb <= 0;
        end
        else begin
            MemRead <= EX_MemRead;
            MemWrite <= EX_MemWrite;
            WriteData <= EX_WriteData;
            WriteAddr <= EX_WriteAddr;
            MemtoReg <= EX_MemtoReg;
            RegWrite <= EX_RegWrite;
            ALU_out <= EX_ALU_out;
            PC_Plus_4 <= EX_PC_Plus_4;
            LwLb <= EX_LwLb;
        end
    end

endmodule
