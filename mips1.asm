.data
	ans: .space 4096
	space: .asciiz ","
	left: .asciiz "["
	right: .asciiz "]"
.text 
	li $v0, 5
	syscall
	move $t0, $v0 # t0, n
	
	la $s0, ans # s0, ans
	move $t1, $zero # t1, i
	
input:
	beq $t1, $t0, sort
	li $v0, 5
	syscall
	sll $t2, $t1, 2 # t2  i * 4
	add $t2, $s0, $t2
	sw $v0, 0($t2)
	addi $t1, $t1, 1
	j input
	
sort:
	move $a0, $zero # a0 i
	subi $a1, $t0, 1 # a1 j
	jal quicksort
	move $t1, $zero
	
	la $a0, left
	li $v0, 4
	syscall
	
	j print
	
quicksort:
	blt $a0, $a1, owo
owon:
	jr $ra
	
owo:
	
	move $t5, $a0
	move $t6, $a1
	sll $t2, $t5, 2
	add $t2, $s0, $t2
	lw $t4, 0($t2) # t4 key
	
while1:
	bge $t5, $t6, get2
	
while2:	
	blt $t5, $t6, con1
	j while1
	
con1:
	sll $t2, $t6, 2
	add $t2, $s0, $t2
	lw $t9, 0($t2)
	
	bge $t9, $t4, con2
	
	sll $t2, $t5, 2
	add $t2, $s0, $t2
	sw $t9, 0($t2)
	
	j while3
	
con2:
	subi $t6, $t6, 1
	j while2

while3:
	blt $t5, $t6, con3
	j while1
	

con3:
	sll $t2, $t5, 2
	add $t2, $s0, $t2
	lw $t8, 0($t2)
	
	ble $t8, $t4, con4
	
	sll $t2, $t6, 2
	add $t2, $s0, $t2
	sw $t8, 0($t2)
	
	j while1
	
con4:
	addi $t5, $t5, 1
	j while3 
	
get2:
	sll $t2, $t5, 2
	add $t2, $s0, $t2
	sw $t4, 0($t2)
	
	move $v0, $t5
	
	subi $sp, $sp, 32
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $v0, 12($sp)
	subi $a1, $v0, 1
	jal quicksort
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $v0, 12($sp)
	addi $sp, $sp, 32
	
	subi $sp, $sp, 32
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $v0, 12($sp)
	addi $a0, $v0, 1
	jal quicksort
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $v0, 12($sp)
	addi $sp, $sp, 32
	j owon
	
print:
	beq $t1, $t0, exit
	sll $t2, $t1, 2
	add $t2, $s0, $t2
	lw $a0, 0($t2)
	li $v0, 1
	syscall
	addi $t1, $t1, 1
	beq $t1, $t0, exit
	la $a0, space
	li $v0, 4
	syscall
	j print
	

exit:
	la $a0, right
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	