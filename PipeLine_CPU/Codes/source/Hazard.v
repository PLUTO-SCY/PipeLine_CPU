`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/29
// Design Name: PipelineCPU
// Module Name: Hazard
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4 
// Description: used for solving the hazard, controlling the flash and keep signal. 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
/////////////////////////////////////////////////////////////////////////////////

module Hazard (ID_EX_WriteAddr,ID_EX_MemRead,rs,rt,PC_Keep,IF_ID_Hold,
            Jump, if_branch, IF_ID_Flush, ID_EX_Flush);
        
    input [4:0] ID_EX_WriteAddr;
    input ID_EX_MemRead;
    input [4:0] rs;
    input [4:0] rt;
    input Jump;
    input if_branch;

    output PC_Keep,IF_ID_Hold;
    output IF_ID_Flush;
    output ID_EX_Flush;

    wire Load_Use;

    assign Load_Use = ID_EX_MemRead 
                && (ID_EX_WriteAddr != 0) 
                && (ID_EX_WriteAddr == rs || ID_EX_WriteAddr == rt);
    assign PC_Keep = Load_Use;
    assign IF_ID_Hold = Load_Use;


    assign IF_ID_Flush = Jump || if_branch;
    assign ID_EX_Flush = if_branch ||  Load_Use;

endmodule
