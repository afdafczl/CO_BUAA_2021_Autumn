.data

.text
	li $v0, 5
	syscall
	move $t0, $v0
	div $t1, $t0, 400
	mul $t2, $t1, 400
	beq $t2, $t0, is
	div $t1, $t0, 4
	mul $t2, $t1, 4
	bne $t2, $t0, isNot
	div $t1, $t0, 100
	mul $t2, $t1, 100
	beq $t2, $t0, isNot
	bne $t2, $t0, is

is:
	li $v0, 1
	la $a0, 1
	syscall
	
	li $v0, 10
	syscall
	
isNot:
	li $v0, 1
	la $a0, 0
	syscall
	
	li $v0, 10
	syscall