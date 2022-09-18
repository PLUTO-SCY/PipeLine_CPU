`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/25
// Design Name: PipelineCPU
// Module Name: InstMem
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4 
// Description:  store all the instructions, instructions memory. 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module InstMem (clk, InstAddr, ReadInst, uart_addr, uart_wr_en, uart_wdata, recv_done);

    input clk;
    input [31:0] InstAddr;
    input [15:0] uart_addr;
    input uart_wr_en;
    input [31:0] uart_wdata;
    input recv_done;

    output [31:0] ReadInst;

    parameter MEM_SIZE = 512;
    reg [31:0] instData [MEM_SIZE-1 : 0];

    always@(posedge clk)
    begin
        if (uart_wr_en) instData[uart_addr-1] <= uart_wdata;
    end

    assign ReadInst = recv_done ? instData[InstAddr[10:2]] : 0;

endmodule
/*
    parameter Inst_Num = 134;
    integer i;
    initial 
    begin   
        instData[9'd0] <= 32'h20100050;
        instData[9'd1] <= 32'h20110320;
        instData[9'd2] <= 32'h20120020;
        instData[9'd3] <= 32'h20130004;
        instData[9'd4] <= 32'h3c016162;
        instData[9'd5] <= 32'h34216162;
        instData[9'd6] <= 32'h00014020;
        instData[9'd7] <= 32'hae080000;
        instData[9'd8] <= 32'hae080004;
        instData[9'd9] <= 32'hae080008;
        instData[9'd10] <= 32'hae08000c;
        instData[9'd11] <= 32'hae080010;
        instData[9'd12] <= 32'hae080014;
        instData[9'd13] <= 32'hae080018;
        instData[9'd14] <= 32'hae08001c;
        instData[9'd15] <= 32'h3c016162;
        instData[9'd16] <= 32'h34216162;
        instData[9'd17] <= 32'h00014020;
        instData[9'd18] <= 32'hae280000;
        instData[9'd19] <= 32'h24080000;
        instData[9'd20] <= 32'h24090000;
        instData[9'd21] <= 32'h240a0000;
        instData[9'd22] <= 32'h02605827;
        instData[9'd23] <= 32'h216b0001;
        instData[9'd24] <= 32'h0172a020;
        instData[9'd25] <= 32'h228b0001; // for 1
        instData[9'd26] <= 32'h010b582a;
        instData[9'd27] <= 32'h20010001;
        instData[9'd28] <= 32'h142b0011;
        instData[9'd29] <= 32'h24090000;
        instData[9'd30] <= 32'h0133582a; // for2
        instData[9'd31] <= 32'h20010001;
        instData[9'd32] <= 32'h142b0009;
        instData[9'd33] <= 32'h01095820;
        instData[9'd34] <= 32'h01705820;
        instData[9'd35] <= 32'h816b0000;
        instData[9'd36] <= 32'h00096021;
        instData[9'd37] <= 32'h01916020;
        instData[9'd38] <= 32'h818c0000;
        instData[9'd39] <= 32'h156c0002;
        instData[9'd40] <= 32'h21290001;
        instData[9'd41] <= 32'h0800001e;  //j for2
        instData[9'd42] <= 32'h15330001;
        instData[9'd43] <= 32'h214a0001;
        instData[9'd44] <= 32'h21080001;
        instData[9'd45] <= 32'h08000019;  // j for1
        instData[9'd46] <= 32'h000a1021;

        instData[9'd47] <= 32'h2402000f;
        instData[9'd48] <= 32'h00029c00;
        instData[9'd49] <= 32'h00029f02;
        instData[9'd50] <= 32'h00029500;
        instData[9'd51] <= 32'h00129702;
        instData[9'd52] <= 32'h00028e00;
        instData[9'd53] <= 32'h00118f02;
        instData[9'd54] <= 32'h00028700;
        instData[9'd55] <= 32'h00108702;
        instData[9'd56] <= 32'h20040640;
        instData[9'd57] <= 32'h2008003f;
        instData[9'd58] <= 32'hac880000;
        instData[9'd59] <= 32'h20080006;
        instData[9'd60] <= 32'hac880004;
        instData[9'd61] <= 32'h2008005b;
        instData[9'd62] <= 32'hac880008;
        instData[9'd63] <= 32'h2008004f;
        instData[9'd64] <= 32'hac88000c;
        instData[9'd65] <= 32'h20080066;
        instData[9'd66] <= 32'hac880010;
        instData[9'd67] <= 32'h2008006d;
        instData[9'd68] <= 32'hac880014;
        instData[9'd69] <= 32'h2008007d;
        instData[9'd70] <= 32'hac880018;
        instData[9'd71] <= 32'h20080007;
        instData[9'd72] <= 32'hac88001c;
        instData[9'd73] <= 32'h2008007f;
        instData[9'd74] <= 32'hac880020;
        instData[9'd75] <= 32'h2008006f;
        instData[9'd76] <= 32'hac880024;
        instData[9'd77] <= 32'h2008005f;
        instData[9'd78] <= 32'hac880028;
        instData[9'd79] <= 32'h2008007c;
        instData[9'd80] <= 32'hac88002c;
        instData[9'd81] <= 32'h20080039;
        instData[9'd82] <= 32'hac880030;
        instData[9'd83] <= 32'h2008005e;
        instData[9'd84] <= 32'hac880034;
        instData[9'd85] <= 32'h2008007b;
        instData[9'd86] <= 32'hac880038;
        instData[9'd87] <= 32'h20080071;
        instData[9'd88] <= 32'hac88003c;
        instData[9'd89] <= 32'h00108080;
        instData[9'd90] <= 32'h02048020;
        instData[9'd91] <= 32'h8e100000;
        instData[9'd92] <= 32'h22100100;
        instData[9'd93] <= 32'h00118880;
        instData[9'd94] <= 32'h02248820;
        instData[9'd95] <= 32'h8e310000;
        instData[9'd96] <= 32'h22310200;
        instData[9'd97] <= 32'h00129080;
        instData[9'd98] <= 32'h02449020;
        instData[9'd99] <= 32'h8e520000;
        instData[9'd100] <= 32'h22520400;
        instData[9'd101] <= 32'h00139880;
        instData[9'd102] <= 32'h02649820;
        instData[9'd103] <= 32'h8e730000;
        instData[9'd104] <= 32'h22730800;
        instData[9'd105] <= 32'h3c014000;   //bigfor
        instData[9'd106] <= 32'h00200821;
        instData[9'd107] <= 32'hac300010;
        instData[9'd108] <= 32'h20080000;
        instData[9'd109] <= 32'h21080001;
        instData[9'd110] <= 32'h20012710;
        instData[9'd111] <= 32'h1428fffd;
        instData[9'd112] <= 32'h3c014000;
        instData[9'd113] <= 32'h00200821;
        instData[9'd114] <= 32'hac310010;
        instData[9'd115] <= 32'h20080000;
        instData[9'd116] <= 32'h21080001;
        instData[9'd117] <= 32'h20012710;
        instData[9'd118] <= 32'h1428fffd;
        instData[9'd119] <= 32'h3c014000;
        instData[9'd120] <= 32'h00200821;
        instData[9'd121] <= 32'hac320010;
        instData[9'd122] <= 32'h20080000;
        instData[9'd123] <= 32'h21080001;
        instData[9'd124] <= 32'h20012710;
        instData[9'd125] <= 32'h1428fffd;
        instData[9'd126] <= 32'h3c014000;
        instData[9'd127] <= 32'h00200821;
        instData[9'd128] <= 32'hac330010;
        instData[9'd129] <= 32'h20080000;
        instData[9'd130] <= 32'h21080001;
        instData[9'd131] <= 32'h20012710;
        instData[9'd132] <= 32'h1428fffd;
        instData[9'd133] <= 32'h08000068; // j Bigfor

        for (i = Inst_Num; i < MEM_SIZE; i = i + 1)
            instData[i] <= 0;
    end
*/


/*
instData[9'd0] <= 32'h20100008;
instData[9'd1] <= 32'h20110028;
instData[9'd2] <= 32'h20120008;
instData[9'd3] <= 32'h20130004;
instData[9'd4] <= 32'h3c016162;
instData[9'd5] <= 32'h34216162;
instData[9'd6] <= 32'h00014020;
instData[9'd7] <= 32'hae080000;
instData[9'd8] <= 32'hae080004;
instData[9'd9] <= 32'hae080008;
instData[9'd10] <= 32'hae08000c;
instData[9'd11] <= 32'hae080010;
instData[9'd12] <= 32'hae080014;
instData[9'd13] <= 32'hae080018;
instData[9'd14] <= 32'hae08001c;
instData[9'd15] <= 32'h3c016162;
instData[9'd16] <= 32'h34216162;
instData[9'd17] <= 32'h00014020;
instData[9'd18] <= 32'hae280000;
instData[9'd19] <= 32'h24080000;
instData[9'd20] <= 32'h24090000;
instData[9'd21] <= 32'h240a0000;
instData[9'd22] <= 32'h02605827;
instData[9'd23] <= 32'h216b0001;
instData[9'd24] <= 32'h0172a020;
instData[9'd25] <= 32'h228b0001; // for 1
instData[9'd26] <= 32'h010b582a;
instData[9'd27] <= 32'h20010001;
instData[9'd28] <= 32'h142b0011;
instData[9'd29] <= 32'h24090000;
instData[9'd30] <= 32'h0133582a; // for2
instData[9'd31] <= 32'h20010001;
instData[9'd32] <= 32'h142b0009;
instData[9'd33] <= 32'h01095820;
instData[9'd34] <= 32'h01705820;
instData[9'd35] <= 32'h816b0000;
instData[9'd36] <= 32'h00096021;
instData[9'd37] <= 32'h01916020;
instData[9'd38] <= 32'h818c0000;
instData[9'd39] <= 32'h156c0002;
instData[9'd40] <= 32'h21290001;
instData[9'd41] <= 32'h0800001e;  //j for2
instData[9'd42] <= 32'h15330001;
instData[9'd43] <= 32'h214a0001;
instData[9'd44] <= 32'h21080001;
instData[9'd45] <= 32'h08000019;  // j for1
instData[9'd46] <= 32'h000a1021;
*/
/*
 instData[9'd0] <= 32'h20100050;
    instData[9'd1] <= 32'h201104b0;
    instData[9'd2] <= 32'h20120008;
    instData[9'd3] <= 32'h20130004;
    instData[9'd4] <= 32'h3c016162;
    instData[9'd5] <= 32'h34216162;
    instData[9'd6] <= 32'h00014020;
    instData[9'd7] <= 32'hae080000;
    instData[9'd8] <= 32'hae080004;
    instData[9'd9] <= 32'h82180003;  // lb test
    instData[9'd10] <= 32'h3c016162;
    instData[9'd11] <= 32'h34216162;
    instData[9'd12] <= 32'h00014020;
    instData[9'd13] <= 32'hae280000;
    instData[9'd14] <= 32'h24080000;
    instData[9'd15] <= 32'h24090000;
    instData[9'd16] <= 32'h240a0000;
    instData[9'd17] <= 32'h02605827;
    instData[9'd18] <= 32'h216b0001;
    instData[9'd19] <= 32'h0172a020;
    instData[9'd20] <= 32'h228b0001; // for 1
    instData[9'd21] <= 32'h010b582a;
    instData[9'd22] <= 32'h20010001;
    instData[9'd23] <= 32'h142b0011;
    instData[9'd24] <= 32'h24090000;
    instData[9'd25] <= 32'h0133582a; // for2
    instData[9'd26] <= 32'h20010001;
    instData[9'd27] <= 32'h142b0009;
    instData[9'd28] <= 32'h01095820;
    instData[9'd29] <= 32'h01705820;
    instData[9'd30] <= 32'h816b0000;
    instData[9'd31] <= 32'h00096021;
    instData[9'd32] <= 32'h01916020;
    instData[9'd33] <= 32'h818c0000;
    instData[9'd34] <= 32'h156c0002;
    instData[9'd35] <= 32'h21290001;
    instData[9'd36] <= 32'h08000019;  // j for2
    instData[9'd37] <= 32'h15330001;
    instData[9'd38] <= 32'h214a0001;
    instData[9'd39] <= 32'h21080001;
    instData[9'd40] <= 32'h08000014;  // j for1
    instData[9'd41] <= 32'h000a1021;
*/

/*
    instData[9'd0] <= 32'h20100050;
    instData[9'd1] <= 32'h20110320;
    instData[9'd2] <= 32'h20120020;
    instData[9'd3] <= 32'h20130004;
    instData[9'd4] <= 32'h3c016162;
    instData[9'd5] <= 32'h34216162;
    instData[9'd6] <= 32'h00014020;
    instData[9'd7] <= 32'hae080000;
    instData[9'd8] <= 32'hae080004;
    instData[9'd9] <= 32'hae080008;
    instData[9'd10] <= 32'hae08000c;
    instData[9'd11] <= 32'hae080010;
    instData[9'd12] <= 32'hae080014;
    instData[9'd13] <= 32'hae080018;
    instData[9'd14] <= 32'hae08001c;
    instData[9'd15] <= 32'h3c016162;
    instData[9'd16] <= 32'h34216162;
    instData[9'd17] <= 32'h00014020;
    instData[9'd18] <= 32'hae280000;
    instData[9'd19] <= 32'h24080000;
    instData[9'd20] <= 32'h24090000;
    instData[9'd21] <= 32'h240a0000;
    instData[9'd22] <= 32'h02605827;
    instData[9'd23] <= 32'h216b0001;
    instData[9'd24] <= 32'h0172a020;
    instData[9'd25] <= 32'h228b0001; // for 1
    instData[9'd26] <= 32'h010b582a;
    instData[9'd27] <= 32'h20010001;
    instData[9'd28] <= 32'h142b0011;
    instData[9'd29] <= 32'h24090000;
    instData[9'd30] <= 32'h0133582a; // for2
    instData[9'd31] <= 32'h20010001;
    instData[9'd32] <= 32'h142b0009;
    instData[9'd33] <= 32'h01095820;
    instData[9'd34] <= 32'h01705820;
    instData[9'd35] <= 32'h816b0000;
    instData[9'd36] <= 32'h00096021;
    instData[9'd37] <= 32'h01916020;
    instData[9'd38] <= 32'h818c0000;
    instData[9'd39] <= 32'h156c0002;
    instData[9'd40] <= 32'h21290001;
    instData[9'd41] <= 32'h0800001e;  //j for2
    instData[9'd42] <= 32'h15330001;
    instData[9'd43] <= 32'h214a0001;
    instData[9'd44] <= 32'h21080001;
    instData[9'd45] <= 32'h08000019;  // j for1
    instData[9'd46] <= 32'h000a1021;
   
    instData[9'd47] <= 32'h00029c00;
    instData[9'd48] <= 32'h00029f02;
    instData[9'd49] <= 32'h00029500;
    instData[9'd50] <= 32'h00129702;
    instData[9'd51] <= 32'h00028e00;
    instData[9'd52] <= 32'h00118f02;
    instData[9'd53] <= 32'h00028700;
    instData[9'd54] <= 32'h00108702;
    instData[9'd55] <= 32'h20040640;
    instData[9'd56] <= 32'h2008003f;
    instData[9'd57] <= 32'hac880000;
    instData[9'd58] <= 32'h20080006;
    instData[9'd59] <= 32'hac880004;
    instData[9'd60] <= 32'h2008005b;
    instData[9'd61] <= 32'hac880008;
    instData[9'd62] <= 32'h2008004f;
    instData[9'd63] <= 32'hac88000c;
    instData[9'd64] <= 32'h20080066;
    instData[9'd65] <= 32'hac880010;
    instData[9'd66] <= 32'h2008006d;
    instData[9'd67] <= 32'hac880014;
    instData[9'd68] <= 32'h2008007d;
    instData[9'd69] <= 32'hac880018;
    instData[9'd70] <= 32'h20080007;
    instData[9'd71] <= 32'hac88001c;
    instData[9'd72] <= 32'h2008007f;
    instData[9'd73] <= 32'hac880020;
    instData[9'd74] <= 32'h2008006f;
    instData[9'd75] <= 32'hac880024;
    instData[9'd76] <= 32'h2008005f;
    instData[9'd77] <= 32'hac880028;
    instData[9'd78] <= 32'h2008007c;
    instData[9'd79] <= 32'hac88002c;
    instData[9'd80] <= 32'h20080039;
    instData[9'd81] <= 32'hac880030;
    instData[9'd82] <= 32'h2008005e;
    instData[9'd83] <= 32'hac880034;
    instData[9'd84] <= 32'h2008007b;
    instData[9'd85] <= 32'hac880038;
    instData[9'd86] <= 32'h20080071;
    instData[9'd87] <= 32'hac88003c;
    instData[9'd88] <= 32'h00108080;
    instData[9'd89] <= 32'h02048020;
    instData[9'd90] <= 32'h8e100000;
    instData[9'd91] <= 32'h22100100;
    instData[9'd92] <= 32'h00118880;
    instData[9'd93] <= 32'h02248820;
    instData[9'd94] <= 32'h8e310000;
    instData[9'd95] <= 32'h22310200;
    instData[9'd96] <= 32'h00129080;
    instData[9'd97] <= 32'h02449020;
    instData[9'd98] <= 32'h8e520000;
    instData[9'd99] <= 32'h22520400;
    instData[9'd100] <= 32'h00139880;
    instData[9'd101] <= 32'h02649820;
    instData[9'd102] <= 32'h8e730000;
    instData[9'd103] <= 32'h22730800;
    instData[9'd104] <= 32'h3c014000;   //bigfor
    instData[9'd105] <= 32'h00200821;
    instData[9'd106] <= 32'hac300010;
    instData[9'd107] <= 32'h20080000;
    instData[9'd108] <= 32'h21080001;
    instData[9'd109] <= 32'h20012710;
    instData[9'd110] <= 32'h1428fffd;
    instData[9'd111] <= 32'h3c014000;
    instData[9'd112] <= 32'h00200821;
    instData[9'd113] <= 32'hac310010;
    instData[9'd114] <= 32'h20080000;
    instData[9'd115] <= 32'h21080001;
    instData[9'd116] <= 32'h20012710;
    instData[9'd117] <= 32'h1428fffd;
    instData[9'd118] <= 32'h3c014000;
    instData[9'd119] <= 32'h00200821;
    instData[9'd120] <= 32'hac320010;
    instData[9'd121] <= 32'h20080000;
    instData[9'd122] <= 32'h21080001;
    instData[9'd123] <= 32'h20012710;
    instData[9'd124] <= 32'h1428fffd;
    instData[9'd125] <= 32'h3c014000;
    instData[9'd126] <= 32'h00200821;
    instData[9'd127] <= 32'hac330010;
    instData[9'd128] <= 32'h20080000;
    instData[9'd129] <= 32'h21080001;
    instData[9'd130] <= 32'h20012710;
    instData[9'd131] <= 32'h1428fffd;
    instData[9'd132] <= 32'h08000068; // j Bigfor
*/