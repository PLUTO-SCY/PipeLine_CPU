`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Experiments on Fundamentals of Digital Logic and Processor
// Designer: Shao Chenyang
// 
// Create Date: 2022/06/25
// Design Name: PipelineCPU
// Module Name: PipeLineCPU
// Project Name: Pipeline-cpu
// Target Devices: 
// Tool Versions: Vivado 2017.4 
// Description:  Combine all the other modules except the testbench, top module.
// 
// Dependencies: all the other modules
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module PipelineCPU (system_clk, reset, leds, AN, BCD, 
                uart_rst, mem2uart, recv_done, send_done, Rx_Serial, Tx_Serial);

    input system_clk;
    input reset;
    input uart_rst;
    input mem2uart;
    output recv_done;
    output send_done;
    input Rx_Serial;
    output Tx_Serial;
    
    output [7:0] leds;
    output [3:0] AN;
    output [7:0] BCD;


    wire clk;
    Frequency ppl_fre (.system_clk(system_clk),.clk(clk)); 

    //-----------------------------------CODE-----------------------------------


    //--------------------------------------------------------------------------
    //------------------------------------IF------------------------------------


    wire [31:0] PC_i, PC_o;
    wire PC_Keep;
    PC ppl_pc (.clk(clk),.reset(reset),.PC_i(PC_i),.PC_Keep(PC_Keep), 
            .PC_o(PC_o));

    wire [31:0] Instruction;
	wire [15:0] uart_addr;
	wire uart_wr_en;
	wire [31:0] uart_wdata;
    InstMem ppl_instMem (.clk(system_clk),.InstAddr(PC_o),.ReadInst(Instruction),
 		.uart_addr(uart_addr), .uart_wr_en(uart_wr_en),.uart_wdata(uart_wdata),
		.recv_done(recv_done));

    wire JumpSrc,Jump;
    wire [31:0] ReadBusA;
	wire [31:0] if_id_reg_PC_Plus_4;
	wire [31:0] if_id_reg_Inst;
	wire ALU_zero;
	wire ID_EX_Reg_Branch;
	wire ID_EX_Reg_BranchControl;
	wire [31:0] ID_EX_Reg_PC_Plus_4;
	wire [31:0] ID_EX_Reg_imm_ext;

    wire if_branch;
    assign if_branch = (ID_EX_Reg_Branch && (ALU_zero ^ ID_EX_Reg_BranchControl));
    
    PC_IN ppl_PC_IN (.JumpSrc(JumpSrc),.Jump(Jump),.PC_o(PC_o),.ReadData1Actual(ReadBusA),
                .if_id_reg_PC_Plus_4(if_id_reg_PC_Plus_4),.if_id_reg_Inst(if_id_reg_Inst),
                .if_branch(if_branch),.ID_EX_Reg_PC_Plus_4(ID_EX_Reg_PC_Plus_4),
				.ID_EX_Reg_imm_ext(ID_EX_Reg_imm_ext),.PC_i(PC_i));

    wire IF_ID_Flush;
    wire IF_ID_Hold;
    IF_ID_Reg if_id_reg (.clk(clk),.reset(reset),.flush(IF_ID_Flush),.hold(IF_ID_Hold),
            .Instruction(Instruction),.IF_PC_Plus_4(PC_o + 4));
	assign if_id_reg_PC_Plus_4 = if_id_reg.PC_Plus_4;
	assign if_id_reg_Inst = if_id_reg.Inst;


    //--------------------------------------------------------------------------
    //------------------------------------ID------------------------------------


    wire [4:0] MEM_WB_WriteAddr;
    wire [31:0] MEM_WB_WriteData;
    wire MEM_WB_RegWr;
    wire [31:0] RF_ReadData1;
    wire [31:0] RF_ReadData2;
    wire [31:0] stringresult;
    RegFile RegFile (.clk(clk),.reset(reset),
            .ReadAddr1(if_id_reg.rs),.ReadAddr2(if_id_reg.rt),
            .RF_WriteAddr(MEM_WB_WriteAddr),.RF_WriteData(MEM_WB_WriteData),
            .RegWrite(MEM_WB_RegWr),.RF_ReadData1(RF_ReadData1),
            .RF_ReadData2(RF_ReadData2),.stringresult(stringresult));

    wire RegWr, Branch, BranchControl;
    wire MemRead, MemWrite, LwLb;
    wire [1:0] MemtoReg;
    wire ALUSrcA, ALUSrcB;
    wire [3:0] ALUOp;
    wire [1:0] RegDst;
    wire LuiOp;
    wire SignedOp;
    Controller Controller (.OpCode(if_id_reg.OpCode),.Funct(if_id_reg.Funct),
            .RegWr(RegWr),.Branch(Branch),.BranchControl(BranchControl),.Jump(Jump),
            .MemRead(MemRead),.MemWrite(MemWrite),.MemtoReg(MemtoReg),
            .JumpSrc(JumpSrc),.ALUSrcA(ALUSrcA),.ALUSrcB(ALUSrcB),.ALUOp(ALUOp),
            .RegDst(RegDst),.LuiOp(LuiOp),.SignedOp(SignedOp),.LwLb(LwLb));

	wire [4:0] EX_WriteAddr;
	wire ID_EX_Reg_RegWr;
	wire EX_MEM_Reg_RegWrite;
    wire [4:0] EX_MEM_Reg_WriteAddr;
	wire [1:0] ForwardA,ForwardB;

	ID_Forward ppl_ID_Forward (.ID_EX_RegWrite(id_ex_reg.RegWr),.ID_EX_WriteAddr(EX_WriteAddr),
		.EX_MEM_RegWrite(EX_MEM_Reg_RegWrite),.EX_MEM_WriteAddr(EX_MEM_Reg_WriteAddr),
		.rs(if_id_reg.rs),.rt(if_id_reg.rt),.ForwardA(ForwardA),.ForwardB(ForwardB));


    wire [31:0] ALU_out;
    wire [31:0] DataMemReadData;
    wire [1:0] EX_MEM_Reg_MemtoReg;
    wire [31:0] EX_MEM_Reg_ALU_out;
    wire [31:0] EX_MEM_Reg_PC_Plus_4;
    wire [31:0] dataForward;
    assign dataForward = EX_MEM_Reg_MemtoReg == 2'b00 ? EX_MEM_Reg_ALU_out 
                    : EX_MEM_Reg_MemtoReg == 2'b01 ? DataMemReadData 
                    : EX_MEM_Reg_PC_Plus_4;

    assign ReadBusA = ForwardA == 2'b01 ? ALU_out 
                        : ForwardA == 2'b10 ? dataForward
                        : RF_ReadData1;

    wire [31:0] RealBusB;
    assign RealBusB = ForwardB == 2'b01 ? ALU_out 
                        : ForwardB == 2'b10 ? dataForward
                        : RF_ReadData2;

    wire [31:0] Imm_Exted;
    ImmProcess ppl_ImmProcess (.Imm({if_id_reg.Inst[15:0]}),.LuiOp(LuiOp),
            .SignedOp(SignedOp),.ImmExtOut(Imm_Exted));

    wire ID_EX_Flush;
    ID_EX_Reg id_ex_reg(.clk(clk),.reset(reset),.flush(ID_EX_Flush),
            .ID_RegWr(RegWr),.ID_Branch(Branch),.ID_BranchControl(BranchControl),.ID_MemRead(MemRead),
            .ID_MemWrite(MemWrite),.ID_MemtoReg(MemtoReg),.ID_ALUSrcA(ALUSrcA),
            .ID_ALUSrcB(ALUSrcB),.ID_ALUOp(ALUOp),.ID_RegDst(RegDst),
            .ID_LwLb(LwLb),.ID_ReadData1(ReadBusA),.ID_ReadData2(RealBusB),
            .ID_imm_ext(Imm_Exted),.ID_PC_Plus_4(if_id_reg.PC_Plus_4),.ID_Shamt(if_id_reg.Shamt),
            .ID_rt(if_id_reg.rt),.ID_rd(if_id_reg.rd));

	assign ID_EX_Reg_RegWr = id_ex_reg.RegWr;
	assign ID_EX_Reg_Branch = id_ex_reg.Branch;
	assign ID_EX_Reg_BranchControl = id_ex_reg.BranchControl;
	assign ID_EX_Reg_PC_Plus_4 = id_ex_reg.PC_Plus_4;
	assign ID_EX_Reg_imm_ext = id_ex_reg.imm_ext;
    

    //--------------------------------------------------------------------------
    //------------------------------------EX------------------------------------

    wire [31:0] ALU_In1;
    wire [31:0] ALU_In2;
    assign ALU_In1 = id_ex_reg.ALUSrcA == 0 ? id_ex_reg.ReadData1 :
                    { 27'h0, id_ex_reg.Shamt };
    assign ALU_In2 = id_ex_reg.ALUSrcB == 0 ? id_ex_reg.ReadData2 :
                    id_ex_reg.imm_ext;

    ALU ALU (.ALUOp(id_ex_reg.ALUOp),.In1(ALU_In1),.In2(ALU_In2),
            .Result(ALU_out),.Zero(ALU_zero));

    assign EX_WriteAddr = id_ex_reg.RegDst == 2'b00 ? id_ex_reg.rd 
                        : id_ex_reg.RegDst == 2'b01 ? id_ex_reg.rt 
                        : 5'd31;

    EX_MEM_Reg ex_mem_reg (.clk(clk),.reset(reset),.EX_MemRead(id_ex_reg.MemRead),
            .EX_MemWrite(id_ex_reg.MemWrite),.EX_WriteData(id_ex_reg.ReadData2),
            .EX_WriteAddr(EX_WriteAddr),.EX_MemtoReg(id_ex_reg.MemtoReg),
            .EX_RegWrite(id_ex_reg.RegWr),.EX_ALU_out(ALU_out),
            .EX_PC_Plus_4(id_ex_reg.PC_Plus_4),.EX_LwLb(id_ex_reg.LwLb));

    assign EX_MEM_Reg_MemtoReg = ex_mem_reg.MemtoReg;
    assign EX_MEM_Reg_ALU_out = ex_mem_reg.ALU_out;
    assign EX_MEM_Reg_PC_Plus_4 = ex_mem_reg.PC_Plus_4;
	assign EX_MEM_Reg_RegWrite = ex_mem_reg.RegWrite;
    assign EX_MEM_Reg_WriteAddr = ex_mem_reg.WriteAddr;

    
    //--------------------------------------------------------------------------
    //-----------------------------------MEM------------------------------------


    DataMem DataMem (.clk(clk),.reset(reset),.addr(ex_mem_reg.ALU_out),.WriteData(ex_mem_reg.WriteData),
            .MemRead(ex_mem_reg.MemRead),.MemWrite(ex_mem_reg.MemWrite),
            .ReadData(DataMemReadData),.leds(leds),.AN(AN),.BCD(BCD),
            .LwLb(ex_mem_reg.LwLb));


    MEM_WB_Reg mem_wb_reg (.clk(clk),.reset(reset),.MEM_RegWr(ex_mem_reg.RegWrite),
            .MEM_MemtoReg(ex_mem_reg.MemtoReg),.MEM_WriteAddr(ex_mem_reg.WriteAddr),
            .MEM_ReadData(DataMemReadData),.MEM_ALU_result(ex_mem_reg.ALU_out),
            .MEM_PC_next(ex_mem_reg.PC_Plus_4));

    assign MEM_WB_WriteAddr = mem_wb_reg.WriteAddr;
    assign MEM_WB_RegWr = mem_wb_reg.RegWr;


    //--------------------------------------------------------------------------
    //------------------------------------WB------------------------------------


    assign MEM_WB_WriteData = mem_wb_reg.MemtoReg == 2'b00 ? mem_wb_reg.ALU_result 
				: mem_wb_reg.MemtoReg == 2'b01 ? mem_wb_reg.ReadData 
				: mem_wb_reg.PC_next;

    
	Hazard ppl_Hazard (.ID_EX_WriteAddr(EX_WriteAddr),.ID_EX_MemRead(id_ex_reg.MemRead),
				.rs(if_id_reg.rs),.rt(if_id_reg.rt),.PC_Keep(PC_Keep),.IF_ID_Hold(IF_ID_Hold),
				.Jump(Jump),.if_branch(if_branch),
                .IF_ID_Flush(IF_ID_Flush),.ID_EX_Flush(ID_EX_Flush));

    //-----------------------------------END-----------------------------------

    UART_MEM ppl_UART_MEM(.clk(system_clk),.rst(uart_rst),.mem2uart(mem2uart),.result(stringresult),
                        .recv_done(recv_done),.send_done(send_done),.Rx_Serial(Rx_Serial),
                        .Tx_Serial(Tx_Serial),
						.addr0(uart_addr),.wr_en0(uart_wr_en),.wdata0(uart_wdata));

endmodule
