`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Engineer: Shao Chenyang
// 
// Create Date: 2022/07/09
// Design Name: 
// Module Name: UART_MEM
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: 
// Description: Modified from the code provided by Professor Sun
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module UART_MEM(
    input clk,      // 100MHz
    input rst,      // S1 
    input mem2uart, // SW0     
    input [31:0] result,
    /*---------------------------MEM--------------------------------*/
    output reg recv_done,   // led 0 
    output reg send_done,   // led 1     
    /*---------------------------UART-------------------------------*/
    input Rx_Serial,
    output Tx_Serial,
    output reg [15:0] addr0,
    output reg wr_en0,
    output reg [31:0] wdata0
    );
    
    parameter CLKS_PER_BIT = 16'd10417;  // 100M/9600
    parameter MEM_SIZE = 512;
    
    /*--------------------------------UART RX-------------------------*/
    wire Rx_DV;
    wire [7:0] Rx_Byte;
    
    uart_rx #(.CLKS_PER_BIT(CLKS_PER_BIT)) uart_rx_inst
        (.i_Clock(clk),
         .i_Rx_Serial(Rx_Serial),
         .o_Rx_DV(Rx_DV),
         .o_Rx_Byte(Rx_Byte)
         );
         
    /*--------------------------------UART TX-------------------------*/
    reg Tx_DV;
    reg [7:0] Tx_Byte;
    wire Tx_Active;
    wire Tx_Done;
    
    uart_tx #(.CLKS_PER_BIT(CLKS_PER_BIT)) uart_tx_inst
        (.i_Clock(clk),
         .i_Tx_DV(Tx_DV),
         .i_Tx_Byte(Tx_Byte),
         .o_Tx_Active(Tx_Active),
         .o_Tx_Serial(Tx_Serial),
         .o_Tx_Done(Tx_Done)
         );
         
    /*----------------------------------MEM Control----------------------------*/
    
    reg [2:0] byte_cnt;
    reg [31:0] word;
    reg [31:0] cntByteTime;
    
    always@(posedge clk)begin
        if(rst)begin
            addr0 <= 16'd0;
            wr_en0 <= 1'b0;
            wdata0 <= 32'd0;
            byte_cnt <= 3'd0;
            word <= 32'd0;
            recv_done <= 1'b0;
            cntByteTime <= 32'd0;
            
            Tx_DV <= 1'b0;
            Tx_Byte <= 8'd0;
            send_done <= 1'b0;
        end
        else
        begin
            // uart to memory
            if(Rx_DV)begin
                // receive a word = 4Byte
                if(byte_cnt == 3'd3)
                begin
                    byte_cnt <= 3'd0;
                    
                    // receive instruction
                    if(addr0 < MEM_SIZE)
                    begin
                        addr0 <= addr0 + 1'b1;
                        wr_en0 <= 1'b1;
                        wdata0 <= {word[31:8],Rx_Byte};
                    end
                end
                else begin
                    byte_cnt <= byte_cnt+1'b1;
                    
                    if(byte_cnt==3'd0) word[31:24] <= Rx_Byte;
                    else if(byte_cnt==3'd1) word[23:16] <= Rx_Byte;
                    else if(byte_cnt==3'd2) word[15:8] <= Rx_Byte;
                    else;
                    
                    wr_en0 <= 1'b0;
                end                
            end
            else begin
                wr_en0 <= 1'b0;
                
                if(addr0 == MEM_SIZE && recv_done == 1'b0)begin  // receive done
                    recv_done <= 1'b1;
                    addr0 <= 16'd0;
                    byte_cnt <= 3'd0;
                end
            end
        
            // memory to uart
            if(mem2uart==1'b1)begin
                if(cntByteTime == CLKS_PER_BIT*20 && send_done==1'b0)begin  // 1Byte time
                    cntByteTime <= 32'd0;
                    
                    Tx_DV <= 1'b1;
                    if(byte_cnt==3'd0) Tx_Byte <= result[31:24];
                    else if(byte_cnt==3'd1) Tx_Byte <= result[23:16];
                    else if(byte_cnt==3'd2) Tx_Byte <= result[15:8];
                    else if(byte_cnt==3'd3) Tx_Byte <= result[7:0];
                    else;
                    
                    if(byte_cnt == 3'd3)
                    begin
                        byte_cnt <= 3'd0;
                        send_done <= 1'b1;
                    end
                    else 
                    begin
                        byte_cnt <= byte_cnt+1'b1;    
                    end
                end
                else 
                begin
                    cntByteTime <= cntByteTime+1'b1;         
                    Tx_DV <= 1'b0;
                end
            end       
        end
    end
endmodule
