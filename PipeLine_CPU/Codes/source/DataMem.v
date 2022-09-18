`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/25
// Design Name: PipelineCPU
// Module Name: DataMem
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4 
// Description: store all the datas, memory.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module DataMem (clk,reset,addr,WriteData,MemRead,MemWrite,LwLb,
                ReadData,leds,AN,BCD);
    input clk;
    input reset;
    input [31:0] addr;
    input [31:0] WriteData;
    input MemRead;
    input MemWrite;
    input LwLb;
    output [31:0] ReadData;
    output reg [7:0] leds;
    output reg [3:0] AN;
    output reg [7:0] BCD;

    parameter MEM_SIZE = 512;
    reg [31:0] system_clocks;
    reg [31:0] data [MEM_SIZE - 1:0];
    wire [1:0] tail;
    assign tail  =  addr[1:0];

    assign ReadData = MemRead == 0 ? 0 :
                        LwLb == 0 ?
                        (addr[31:2] < MEM_SIZE ? data[addr[31:2]] 
                        : addr == 32'h4000000C ? {24'h0, leds} 
                        : addr == 32'h40000010 ? {20'h0, AN, BCD} 
                        : addr == 32'h40000014 ? system_clocks
                        : 0)
                        : 
                        (tail==2'b00 ? {24'h0, data[addr[31:2]][31:24]}
                        :tail==2'b01 ? {24'h0, data[addr[31:2]][23:16]}
                        :tail==2'b10 ? {24'h0, data[addr[31:2]][15:8]}
                        :tail==2'b11 ? {24'h0, data[addr[31:2]][7:0]}
                        :0);


    integer i;
    always @(posedge clk or posedge reset) 
    begin
        if (reset) 
        begin
            for (i = 0; i < MEM_SIZE; i = i + 1) 
                data[i] <= 0;
            leds <= 0;
            AN <= 0;
            BCD <= 0;
            system_clocks <= 0;     
        end
        else 
            if (MemWrite) 
            begin
                if (addr[31:2] < MEM_SIZE) 
                    data[addr[31:2]] <= WriteData;
                else if (addr == 32'h4000000C)
                begin
                    leds <= WriteData[7:0];
                end
                else if (addr == 32'h40000010)
                begin
                    BCD <= WriteData[7:0];
                    AN <= WriteData[11:8];
                end                
            end
			system_clocks <= system_clocks + 1'b1;
    end

endmodule
