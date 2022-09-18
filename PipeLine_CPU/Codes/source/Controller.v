`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/25
// Design Name: PipelineCPU
// Module Name: Controller
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4
// Description:  Generate all the control signals for the whole pipeline 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Controller (OpCode,Funct,
            RegWr,Branch,BranchControl,Jump,MemRead,MemWrite,MemtoReg,JumpSrc,ALUSrcA,
            ALUSrcB,ALUOp,RegDst,LuiOp,SignedOp,LwLb);

    input [5:0] OpCode;
    input [5:0] Funct;
    output reg RegWr;
    output reg Branch;
    output reg BranchControl;
    output reg Jump;
    output reg MemRead;
    output reg MemWrite;
    output reg [1:0] MemtoReg;
    output reg JumpSrc;
    output reg ALUSrcA;
    output reg ALUSrcB;
    output reg [3:0] ALUOp;
    output reg [1:0] RegDst;
    output reg LuiOp;
    output reg SignedOp;
    output reg LwLb;

    always @(*) 
    begin
        //---------------RegWr----------------
        if (OpCode == 0)
            RegWr <= (Funct==6'h08) ? 0 : 1;
        else begin
            case (OpCode)
                6'hf, 6'h08, 6'h09, 6'h0c, 6'h0d, 6'h0b, 6'h23, 6'h20, 6'h03: RegWr <= 1;
                default: RegWr <= 0;
            endcase
        end


        //---------------RegDst---------------
        // 00-rd, 01-rt, 10-%ra
        case (OpCode)
            6'h03: RegDst <= 2'b10;    // jal
            6'h0f, 6'h08, 6'h09, 6'h0c, 6'h0d, 6'h0b, 6'h23, 6'h20: RegDst <= 2'b01; // I and lw
            default: 
                RegDst <= (Funct == 6'h09)&&(OpCode == 6'h0) ? 2'b10 : 2'b00;    
        endcase


        //----------------Brach----------------
        case (OpCode)
            6'h04, 6'h06, 6'h05, 6'h07, 6'h01: // beq, blez, bne, bgtz, bltz
                Branch <= 1;    
            default:
                Branch <= 0;
        endcase


        //------------BranchControl------------
        BranchControl <= (OpCode == 6'h05) || (OpCode == 6'h06);


        //-----------------Jump----------------
        Jump <= (OpCode == 0 && (Funct == 6'h08 || Funct == 6'h09)) 
                        || OpCode == 6'h02 || OpCode == 6'h03;


        //--------------JumpSrc---------------
        // 0-Imm, 1-reg1
        JumpSrc <= (OpCode == 0);


        //-------------MemRead----------------
        MemRead <= (OpCode == 6'h23) || (OpCode == 6'h20);


        //---------------lwlb----------------
        LwLb <= (OpCode == 6'h20);


        //-------------MemWrite--------------
        MemWrite <= (OpCode == 6'h2b);


        //-------------MemtoReg----------------
        // 00-ALUResult, 01-Data-Mem, 10-PC+4 
        if (OpCode == 6'h23 || OpCode == 6'h20) 
            MemtoReg <= 2'b01; // lw
        else 
            MemtoReg <= (OpCode == 6'h23 || OpCode == 6'h20) ? 2'b01 : 2'b00;   //lw->01


        //--------------ALUSrcA----------------
        // 0-ReadData1, 1-Shamt
        ALUSrcA <= (OpCode == 0 && (Funct == 6'h0 || Funct == 6'h02 || Funct == 6'h03));


        //--------------ALUSrcB---------------- 
        // 0-ReadData2, 1-imm
        case (OpCode)
            6'h0f, 6'h08, 6'h09, 6'h0c, 6'h0b, 6'h0d, 6'h20, 6'h23, 6'h2b: ALUSrcB <= 1;
            default: ALUSrcB <= 0;
        endcase


        // LuiOp
        LuiOp <= (OpCode == 6'h0f);


        //-------------SignedOp--------------
        SignedOp <= (OpCode == 6'h0c || OpCode == 6'h0d ? 0 : 1);  // only andi//ori->0
    end


    //------------------------------------------------------
    //ALUOp

    parameter Add      = 4'h0;     // add & addu
    parameter Sub      = 4'h1;     // sub & subu
    parameter And      = 4'h3;     // and
    parameter Or       = 4'h4;     // or
    parameter Xor      = 4'h5;     // xor
    parameter Nor      = 4'h6;     // nor
    parameter Ult      = 4'h7;     // unsigned less than
    parameter Slt      = 4'h8;     // signed less than 
    parameter Sll      = 4'h9;     // sll
    parameter Srl      = 4'hA;     // srl
    parameter Sra      = 4'hB;     // sra
    parameter Gtz      = 4'hC;     // greater than zero, for bgtz\bltz

    always @(*) 
    begin
        case (OpCode)
            6'h08, 6'h09, 6'h0f, 6'h23, 6'h20, 6'h2b: ALUOp <= Add;
            6'h01: ALUOp <= Slt;
            6'h04, 6'h05: ALUOp <= Sub;  //beq\bne
            6'h06, 6'h07: ALUOp <= Gtz;  //bgtz\blez 
            6'h0b: ALUOp <= Ult;
            6'h0c: ALUOp <= And;
            6'h0d: ALUOp <= Or;

            6'h0: 
            begin
                case (Funct)
                    6'h20, 6'h21: ALUOp <= Add;
                    6'h22, 6'h23: ALUOp <= Sub;
                    6'h00: ALUOp <= Sll;
                    6'h02: ALUOp <= Srl;
                    6'h03: ALUOp <= Sra;
                    6'h24: ALUOp <= And;
                    6'h25: ALUOp <= Or;
                    6'h26: ALUOp <= Xor;
                    6'h27: ALUOp <= Nor;
                    6'h2a: ALUOp <= Slt;
                    6'h2b: ALUOp <= Ult;
                    default: ALUOp <= Add;
                endcase
            end        
            default: ALUOp <= Add;
        endcase
    end

endmodule
