
;#$a0 = array
;#$a1 = start index
;#$a2 = size
;#$s0 = array[index]
;#$s1 = array[minIndex]
;#$s2 = constante = 8
;#$s3 = constante = 1
;#$s4 = element
;#$s5 = container array[startIndex]
;#$s6 = container Array[minIndex]
;#$t1 = minIndex
;#$t3 = index
;#$t5 = direccion del array[index]
;#$t6 = direccion del array[minIndex] 
;#$t8 = condicion

jal main
#stop

if_cond:
    move $t1,$t3
    addi $t3,$t3,1    

for_loop:
    

    ;#t3 = index
    slt $t4, $t3 ,$a2
    beq $t4,$zero, endloop

    ;#cantidad a moverse en memoria array[index] 8* index
    mult $t3,$s2
    mflo $t5
    
    ;#sino entraria al if
    ;#elemento de array [index]
    add $s0,$a0,$t5


    ;#elemento de array[minIndex]

    ;#cantidad a moverse en memoria array[minIndex]
    mult $t1,$s2
    mflo $t6

    ;#elemento de array[minIndex]
    add $s1,$a0,$t6

    slt $t8,$s0,$s1
    beq $t8,$s3,if_cond

    addi $t3,$t3,1

    j for_loop



endloop:

    mult $a1,$s2
    mflo $s5

    ;#temp = element
    add $s4, $a0,$s5

    ;#array[startIndex] = array[minIndex]





    


selectionSort:
    
    ;#startindex >= size-1
    subi $t0,$a2,1
    slt $t1, $t0, $a1

    bne $t1,$zero,return_ss
    
    ;# minIndex = startIndex
    or $t1,$zero, $a1

    ;#s2 = 5 tamaño del struct por relleno
    ori $s2,$zero,8
    ;#s3 = 1
    ori $s3,$zero,1

    ;#index = startindex + 1
    addi $t2,$a1,1
    or $t3,$zero,$t2

    j for_loop

return_ss:
    jr	$ra	
    

main:
    addi $sp,$sp,-4
    sw $ra, 0($sp)

    addi $sp,$sp, 24

    ;# x
    ori $a3,$zero,1
    sb $a3,0($sp)
    ;#rellenar con 0
    sb $zero,1($sp)
    sb $zero,2($sp)
    sb $zero,3($sp)

    ;#guardar element
    ori $a3,$zero, 5
    sw $a3, 4($sp)

     ;# x
    ori $a3,$zero,1
    sb $a3,0($sp)
    ;#rellenar con 0
    sb $zero,1($sp)
    sb $zero,2($sp)
    sb $zero,3($sp)

    ;#guardar element
    ori $a3,$zero, 3
    sw $a3, 12($sp)

     ;# x
    ori $a3,$zero,1
    sb $a3,0($sp)
    ;#rellenar con 0
    sb $zero,1($sp)
    sb $zero,2($sp)
    sb $zero,3($sp)

    ;#guardar element
    ori $a3,$zero, 1
    sw $a3, 20($sp)

    #show memory 4($a0)
    #show memory 12($a0)
    #show memory 20($a0)


    jal selectionSort

    




    lw $ra, 0($sp)
    addi $sp,$sp,4

    jr $ra