
;#a0 = array
;#a1 = start index
;#a2 = size
;#s2 = constante = 5
;#$s3 = constante = 1

if_cond:
    move $t1,$t3
    addi $t3,$t3,1    

for_loop:
    
    ;#cantidad a moverse en memoria array[index]
    mult $t3,$s2

    mflo $t3


    ;#t3 = index
    slt $t4, $t3 ,$a2
    beq $t4,$zero, endloop
    
    ;#sino entraria al if

    ;#elemento de array [index]

    add $s0,$a0,$t3


    ;#elemento de array[minIndex]

    ;#cantidad a moverse en memoria array[minIndex]
    mult $t1,$s2

    mflo $t1

    add $s1,$a0,$t1

    slt $t5,$s0,$s1

    beq $t5,$s3,if_cond

    addi $t3,$t3,1

    j for_loop



endloop:
    


selectionSort:
    
    ;#startindex >= size-1
    subi $t0,$a2,1
    slt $t1, $t0, $a1

    bne $t1,$zero,return_ss
    
    ;# minIndex = startIndex
    or $t1,$zero, $a1

    ;#s2 = 5
    ori $s2,$zero,5
    ;#s3 = 1
    ori $s3,$zero,1

    ;#index = startindex + 1
    addi $t2,$a1,1
    or $t3,$zero,$t2

    j for_loop

return_ss:
    jr	$ra	
    
