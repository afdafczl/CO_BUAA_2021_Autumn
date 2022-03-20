.data

.text

li $v0, 5
syscall
move $s1, $v0

li $v0, 5
syscall
move $s2, $v0

blt $s1, $s2, swap

loop:
div $s3, $s1, $s2
mul $s4, $s2, $s3
sub $s5, $s1, $s4
beq $s5, 0, answer
move $s1, $s2
move $s2, $s5
j loop

swap:
move $t0, $s1
move $s1, $s2
move $s2, $t0
j loop

answer:
move $a0, $s2
li $v0, 1
syscall 

li $v0, 10
syscall
