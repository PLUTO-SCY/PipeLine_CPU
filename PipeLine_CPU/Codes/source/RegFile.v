`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/26
// Design Name: PipelineCPU
// Module Name: RegFile
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4 
// Description:  32 regs
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module RegFile (clk, reset, ReadAddr1, ReadAddr2, RF_WriteAddr, RF_WriteData, 
                RegWrite,
                RF_ReadData1, RF_ReadData2, stringresult);

//Input Clock Signals
input clk;
input reset;
//Input Control Signals
input RegWrite;
//Input Data Signals
input [4:0] ReadAddr1;
input [4:0] ReadAddr2;
input [4:0] RF_WriteAddr;
input [31:0] RF_WriteData;
//Output Data Signals
output [31:0] RF_ReadData1;
output [31:0] RF_ReadData2;
output [31:0] stringresult;

reg [31:0] regs [31:1];

assign RF_ReadData1 =
            ReadAddr1 == 0 ? 32'h0 :
            RegWrite && RF_WriteAddr == ReadAddr1 ? RF_WriteData :
            regs[ReadAddr1];
assign RF_ReadData2 =
            ReadAddr2 == 0 ? 32'h0 :
            RegWrite && RF_WriteAddr == ReadAddr2 ? RF_WriteData :
            regs[ReadAddr2];

assign stringresult = regs[2];



integer i;
always @(posedge clk or posedge reset) 
begin
    if (reset) 
    begin
        for (i = 1; i < 29; i = i + 1) 
            regs[i] <= 0;
        regs[29] <= 32'h000007fc;   // 511
        for (i = 30; i < 32; i = i + 1) 
            regs[i] <= 0;
    end
    else if (RegWrite && (RF_WriteAddr != 5'b00000)) 
        regs[RF_WriteAddr] <= RF_WriteData;
end

endmodule
