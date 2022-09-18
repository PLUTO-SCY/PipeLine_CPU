`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/28
// Design Name: PipelineCPU
// Module Name: MEM_WB_Reg
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4 
// Description:  PipeLine regs between the MEM and WB stages
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module MEM_WB_Reg (clk,reset,MEM_MemtoReg,MEM_RegWr,MEM_WriteAddr,MEM_ReadData,
                MEM_ALU_result,MEM_PC_next);

    input clk;
    input reset;
    input [1:0] MEM_MemtoReg;
    input MEM_RegWr;
    input [4:0] MEM_WriteAddr;
    input [31:0] MEM_ReadData;
    input [31:0] MEM_ALU_result;
    input [31:0] MEM_PC_next;

    reg RegWr;
    reg [1:0] MemtoReg;
    reg [4:0] WriteAddr;
    reg [31:0] ReadData;
    reg [31:0] ALU_result;
    reg [31:0] PC_next;

    always @(posedge clk or posedge reset) begin
        if (reset) 
        begin
            RegWr<= 0;
            MemtoReg<= 0;
            WriteAddr<= 0;
            ReadData<= 0;
            ALU_result<= 0;
            PC_next<= 0;
        end
        else 
        begin
            RegWr <= MEM_RegWr;
            MemtoReg <= MEM_MemtoReg;
            WriteAddr <= MEM_WriteAddr;
            ReadData <= MEM_ReadData;
            ALU_result <= MEM_ALU_result;
            PC_next <= MEM_PC_next;
        end
    end

endmodule
