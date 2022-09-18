`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/25
// Design Name: PipelineCPU
// Module Name: ALU
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4
// Description:  ALU module, used for calculation.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU (ALUOp, In1, In2, Result, Zero);

    input [3:0] ALUOp;

    input [31:0] In1;
    input [31:0] In2;

    output reg [31:0] Result;
    output Zero;

    assign Zero = (Result == 0);

    parameter Add      = 4'h0;     // add & addu
    parameter Sub      = 4'h1;     // sub & subu
    parameter And      = 4'h3;     // and
    parameter Or       = 4'h4;     // or
    parameter Xor      = 4'h5;     // xor
    parameter Nor      = 4'h6;     // nor
    parameter Ult      = 4'h7;     // unsigned less than, for SLTU
    parameter Slt      = 4'h8;     // signed less than, for SLT
    parameter Sll      = 4'h9;     // sll
    parameter Srl      = 4'hA;     // srl
    parameter Sra      = 4'hB;     // sra
    parameter Gtz      = 4'hC;     // greater than zero, for bgtz\bltz

    always @(*) 
    begin
      case (ALUOp)
            Add: Result <= In1 + In2;
            Or: Result <= In1 | In2;
            And: Result <= In1 & In2;
            Sub: Result <= In1 - In2;
            Slt: Result <= ($signed(In1) < $signed(In2));  //SLT
            Ult: Result <= (In1 < In2); //SLTU
            Nor: Result <= ~(In1 | In2);    //NOR
            Xor: Result <= In1 ^ In2;       //XOR
            Srl: Result <= (In2 >> In1[4:0]);  //SRL
            Sra: Result <= ($signed(In2)) >>> In1[4:0];  //SRA
            Sll: Result <= (In2 << In1[4:0]);   //SLL
            Gtz: Result <= ($signed(In1) > 0);
            default: Result <= 32'h0;
      endcase
    end   

endmodule
