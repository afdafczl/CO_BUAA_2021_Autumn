.data

.text
	li $v0, 5
	syscall
	
	move $t0, $v0	
	li $v0, 5
	syscall
	
	move $t1, $v0
	li $v0, 5
	syscall
	
	move $t2, $v0
	beq $t2, 0, L0
	beq $t2, 1, L1
	beq $t2, 2, L2
	beq $t2, 3, L3
	
L0: 
	add $t3, $t0, $t1
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 10
	syscall

L1: 
	sub $t3, $t0, $t1
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 10
	syscall
	
L2: 
	mul $t3, $t0, $t1
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 10
	syscall	
	
L3: 
	div $t3, $t0, $t1
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 10
	syscall
	