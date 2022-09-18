# EX Forward
addi $a1 $0 1
addi $a3 $0 1
addi $a1 $a1 1
addi $a2 $0 5
addi $a1 $a1 13

InstMem[9'd0] <=  32'h20050001;
InstMem[9'd1] <=  32'h20070001;        
InstMem[9'd2] <=  32'h20a50001;
InstMem[9'd3] <=  32'h20060005;
InstMem[9'd4] <=  32'h20a5000d;    
# ex forwarding correct-----------------------------------


# EX forward / Beq 
addi $a0 $0 1
addi $a1 $0 1
beq $a0 $a1 beqq
addi $a0 $a0 1
beqq: 
addi $a0 $a0 1

InstMem[9'd0] <=  32'h20040001;
InstMem[9'd1] <=  32'h20050001;
InstMem[9'd2] <=  32'h10850001;
InstMem[9'd3] <=  32'h20840001;
InstMem[9'd4] <=  32'h20840001;
# Beq test correct---------------------------------------------

