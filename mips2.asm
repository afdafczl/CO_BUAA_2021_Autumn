.data
.text 
	li $v0, 5
	syscall
	move $t0, $v0
	li $t1, 2

	beq $t0, 1, exit1

loop:
	div $t2, $t0, $t1
	beq $t2, 1, Add
	mul $t3, $t2, $t1
	mul $t4, $t1, $t1
	beq $t0, $t3, exit1
	slt $t5, $t4, $t0
	beq $t5, 1, Add
	beq $t5, 0, exit2
	
Add:
	addi $t6, $t1, 1
	move $t1, $t6
	j loop
	
exit1:
	li $v0, 1
	la $a0, 0
	syscall
	
	li $v0, 10
	syscall

exit2:
	li $v0, 1
	la $a0, 1
	syscall
	
	li $v0, 10
	syscall