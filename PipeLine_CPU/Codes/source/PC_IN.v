`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/07/01
// Design Name: PipelineCPU
// Module Name: PC_IN
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4 
// Description: A separate module is listed to determine the update value of the PC.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module PC_IN (JumpSrc,Jump,PC_o,ReadData1Actual,if_id_reg_PC_Plus_4,if_id_reg_Inst,
			if_branch,ID_EX_Reg_PC_Plus_4,ID_EX_Reg_imm_ext,PC_i);

    input JumpSrc;
    input Jump;
    input [31:0] PC_o;
    input [31:0] ReadData1Actual;
    input [31:0] if_id_reg_PC_Plus_4;
    input [31:0] if_id_reg_Inst;
	input if_branch;
    input [31:0] ID_EX_Reg_PC_Plus_4;
    input [31:0] ID_EX_Reg_imm_ext;
    
    output [31:0] PC_i;

    wire [31:0] J_out;
    assign J_out = Jump == 0 ? (PC_o + 4) 
                : JumpSrc == 0 ? {if_id_reg_PC_Plus_4[31:28], if_id_reg_Inst[25:0], 2'b00} 
                : ReadData1Actual;

    assign PC_i = !if_branch ? J_out :
                    ID_EX_Reg_PC_Plus_4 + (ID_EX_Reg_imm_ext << 2);



endmodule