    addi $s0 $0 80
    addi $s1 $0 800
    addi $s2 $0 32
    addi $s3 $0 4

    addi $t0 $0 1633837410
    sw $t0 0($s0)
    sw $t0 4($s0)
    sw $t0 8($s0)
    sw $t0 12($s0)
    sw $t0 16($s0)
    sw $t0 20($s0)
    sw $t0 24($s0)
    sw $t0 28($s0)
    #lb $t8 4($s0)
    addi $t0 $0 1633837410
    sw $t0 0($s1)
    #lw $t9 0($s1)
    # $s4: next 

     li $t0 0  #i
    li $t1 0  #j
    li $t2 0  #cnt
    nor $t3, $s3, $zero	
    addi $t3, $t3, 1	
    add	$s4, $t3, $s2		#s4:len_str - len_pattern\\not changed

for1:        
    addi $t3 $s4 1
    slt	$t3, $t0, $t3		# i<len_str - len_pattern+1
    bne $t3 1 endfor1
    
    li $t1 0  #j=0
    for2:        
        slt	$t3, $t1, $s3		# $t0 = ($s0 < $s1) ? 1 : 0
        bne $t3 1 endfor2

        add $t3 $t0 $t1  # i+j
        add $t3, $t3, $s0 # str[i+j] 
        lb $t3, 0($t3)

        move $t4 $t1
        add $t4, $t4, $s1 # pattern[j] 
        lb $t4, 0($t4)

        bne $t3 $t4 endfor2 #if(str[i + j] == pattern[j])--> for
        addi $t1, $t1, 1			# j++
        j for2	
        
    endfor2:
        bne $t1 $s3 cnt_not_add
        addi $t2 $t2 1  

    cnt_not_add:

    addi $t0, $t0, 1		# $t0 = $t0 + 1
    j for1
    
endfor1:
    move $v0 $t2
