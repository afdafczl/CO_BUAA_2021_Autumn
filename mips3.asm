.data
A: .asciiz "A"
B: .asciiz "B"
C: .asciiz "C"
to: .asciiz "->"
enter: .asciiz "\n"

.text

li $v0, 5
syscall
move $s0, $v0 # $s0 = n
la $s1, A
la $s2, B
la $s3, C
move $a0, $s0
move $a1, $s1
move $a2, $s2
move $a3, $s3
jal hanoi
li $v0, 10
syscall

hanoi:
beq $a0, 1, mov

subi $sp, $sp, 32
sw $a0, 0($sp)
sw $a1, 4($sp)
sw $a2, 8($sp)
sw $a3, 12($sp)
sw $ra, 16($sp)
subi $a0, $a0, 1
move $t0, $a2
move $a2, $a3
move $a3, $t0
jal hanoi
lw $a0, 0($sp)
lw $a1, 4($sp)
lw $a2, 8($sp)
lw $a3, 12($sp)
lw $ra, 16($sp)
addi $sp, $sp, 32

mov:
move $t0, $a0
move $a0, $a1
li $v0, 4
syscall
la $a0, to
li $v0, 4
syscall
move $a0, $a3
li $v0, 4
syscall
la $a0, enter
li $v0, 4
syscall
move $a0, $t0

beq $a0, 1, return

subi $sp, $sp, 32
sw $a0, 0($sp)
sw $a1, 4($sp)
sw $a2, 8($sp)
sw $a3, 12($sp)
sw $ra, 16($sp)
subi $a0, $a0, 1
move $t0, $a1
move $a1, $a2
move $a2, $t0
jal hanoi
lw $a0, 0($sp)
lw $a1, 4($sp)
lw $a2, 8($sp)
lw $a3, 12($sp)
lw $ra, 16($sp)
addi $sp, $sp, 32

return:
jr $ra