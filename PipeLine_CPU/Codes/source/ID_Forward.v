`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/28
// Design Name: PipelineCPU
// Module Name: ID_Forward
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4 
// Description: Dicide the data forwarding process.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ID_Forward (ID_EX_RegWrite,ID_EX_WriteAddr,EX_MEM_RegWrite,
        EX_MEM_WriteAddr,rs,rt,ForwardA,ForwardB);
        
    input ID_EX_RegWrite;
    input [4:0] ID_EX_WriteAddr;
    input EX_MEM_RegWrite;
    input [4:0] EX_MEM_WriteAddr;
    input [4:0] rs;
    input [4:0] rt;

    output [1:0] ForwardA;     
    output [1:0] ForwardB;

    assign ForwardA = (ID_EX_RegWrite && ID_EX_WriteAddr != 0 && ID_EX_WriteAddr == rs) ? 2'b01 
                : (EX_MEM_RegWrite && EX_MEM_WriteAddr != 0 && EX_MEM_WriteAddr == rs) ? 2'b10 
                : 2'b00;

    assign ForwardB = (ID_EX_RegWrite && ID_EX_WriteAddr != 0 && ID_EX_WriteAddr == rt) ? 2'b01 
                : (EX_MEM_RegWrite && EX_MEM_WriteAddr != 0 && EX_MEM_WriteAddr == rt) ? 2'b10 
                : 2'b00;

endmodule
