sll $s3 $v0 16
srl $s3 $v0 28
sll $s2 $v0 20
srl $s2 $s2 28
sll $s1 $v0 24
srl $s1 $s1 28
sll $s0 $v0 28
srl $s0 $s0 28

addi $a0 $0 268501248
addi $t0 $0 63
sw $t0 0($a0)
addi $t0 $0 6
sw $t0 4($a0)
addi $t0 $0 91
sw $t0 8($a0)
addi $t0 $0 79
sw $t0 12($a0)
addi $t0 $0 102
sw $t0 16($a0)
addi $t0 $0 109
sw $t0 20($a0)
addi $t0 $0 125
sw $t0 24($a0)
addi $t0 $0 7
sw $t0 28($a0)
addi $t0 $0 127
sw $t0 32($a0)
addi $t0 $0 111
sw $t0 36($a0)
addi $t0 $0 95
sw $t0 40($a0)
addi $t0 $0 124
sw $t0 44($a0)
addi $t0 $0 57
sw $t0 48($a0)
addi $t0 $0 94
sw $t0 52($a0)
addi $t0 $0 123
sw $t0 56($a0)
addi $t0 $0 113
sw $t0 60($a0)

sll $s0 $s0 2
add $s0 $s0 $a0
lw $s0 0($s0)
addi $s0 $s0 256

sll $s1 $s1 2
add $s1 $s1 $a0
lw $s1 0($s1)
addi $s1 $s1 512

sll $s2 $s2 2
add $s2 $s2 $a0
lw $s2 0($s2)
addi $s2 $s2 1024

sll $s3 $s3 2
add $s3 $s3 $a0
lw $s3 0($s3)
addi $s3 $s3 2048

Bigfor:
sw $s0 0x40000010($0)
addi $t0 $0 0
for1:
addi $t0 $t0 1
bne $t0 10000 for1

sw $s1 0x40000010($0)
addi $t0 $0 0
for2:
addi $t0 $t0 1
bne $t0 10000 for2

sw $s2 0x40000010($0)
addi $t0 $0 0
for3:
addi $t0 $t0 1
bne $t0 10000 for3

sw $s3 0x40000010($0)
addi $t0 $0 0
for4:
addi $t0 $t0 1
bne $t0 10000 for4
j Bigfor



