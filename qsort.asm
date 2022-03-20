.data
 array:.space 4000
 str_comma:.asciiz","
 str_left_kuo:.asciiz"["
 str_right_kuo:.asciiz"]"
.text
  li $v0,5
  syscall
  move $s0,$v0 #s0为个数
  li $t0,0
  li $s2,0 #low
  addi $s3,$s0,-1 #high
  sw $s2,-4($sp)
  sw $s3,-8($sp)
input:
  beq $t0,$s0,end_input
  sll $t1,$t0,2
  li $v0,5
  syscall
  sw $v0,array($t1)
  addi $t0,$t0,1
  j input
end_input:
  li $t0,0
  li $t1,0 #把寄存器清零先
  jal QuickSort#之后就是纯输出
  li $t0,0
  la $a0,str_left_kuo
  li $v0,4
  syscall
  addi $s0,$s0,-1 #为了让逗号能不多
  out:
   beq $t0,$s0,finish
   sll $t1,$t0,2
   lw $t3,array($t1)
   move $a0,$t3
   li $v0,1
   syscall
   la $a0,str_comma
   li $v0,4
   syscall
   addi $t0,$t0,1
   j out
 finish: 
   sll $t1,$t0,2
   lw $t3,array($t1)
   move $a0,$t3
   li $v0,1
   syscall
  la $a0,str_right_kuo
  li $v0,4
  syscall
  li $v0,10
  syscall
  
 getStandard:
   lw $t0,8($sp) #j
   lw $t1,12($sp) #i
   sll $t2,$t1,2
   lw $s1,array($t2) #key,$t3=array[i]
   li $t7,2
   loop1:
      bge $t1,$t0,end_loop1
        loop2:
           slt $t4,$t1,$t0
           sll $t2,$t0,2
           lw $t5,array($t2) #$t5=array[j]
           sle $t6,$s1,$t5
           addu $t4,$t4,$t6
           bne $t4,$t7,end_loop2
           addi $t0,$t0,-1
           j loop2
      end_loop2:
         bge $t1,$t0,loop3
         sll $t2,$t0,2
         lw $t5,array($t2) #$t5=array[j]
         sll $t2,$t1,2
         sw $t5,array($t2)
     loop3:
         slt $t4,$t1,$t0
         sll $t2,$t1,2
         lw $t3,array($t2) #$t3=array[i]
         sle $t6,$t3,$s1
         addu $t4,$t4,$t6
         bne $t4,$t7,end_loop3
         addi $t1,$t1,1
         j loop3
     end_loop3:
         bge $t1,$t0,again
         sll $t2,$t1,2
         lw $t3,array($t2) #$t3=array[i]
         sll $t2,$t0,2
         sw $t3,array($t2)
      again:
         j loop1
    end_loop1:
       sll $t2,$t1,2
       sw $s1,array($t2)
       sw $t1,4($sp) #每次$sp都对准$ra
       jr $ra
    
QuickSort:
    addi $sp,$sp,-16
    sw $ra,0($sp)
    lw $s2,12($sp) #low
    lw $s3,8($sp) #high
    bge $s2,$s3,end
    #sw $s2,-4($sp)
    #sw $s3,-8($sp)
    jal getStandard
    lw $s4,4($sp) #standard
    lw $s2,12($sp) #low
    lw $s3,8($sp) #high
    sw $s2,-4($sp)
    addi $s5,$s4,-1
    sw $s5,-8($sp)
    jal QuickSort
    
    lw $s2,12($sp) #low 这里要重新取一下low和high
    lw $s3,8($sp) #high
    lw $s4,4($sp)
    sw $s3,-8($sp)
    addi $s5,$s4,1
    sw $s5,-4($sp)
    jal QuickSort
   end:
     lw $ra,0($sp)
     addi $sp,$sp,16
     jr $ra