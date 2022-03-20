.data

s: .space 4096

.text
la $s0, s

li $v0, 5
syscall
move $s1, $v0 # $s1 = n
addi $s7, $s1, 1

li $v0, 5
syscall
move $s2, $v0 # $s2 = x

li $v0, 5
syscall
move $s3, $v0 # $s3 = y

move $a0, $s0
move $a1, $s7
li $v0, 8
syscall

move $s4, $zero
move $s5, $s0
nochange:
beq $s4, $s2, start
lb $a0, 0($s5)
li $v0, 11
syscall
addi $s5, $s5, 1
addi $s4, $s4, 1 
j nochange

start:
add $s5, $s0, $s3
start_main:
bgt $s4, $s3, end
lb $a0, 0($s5)
li $v0, 11
syscall
subi $s5, $s5, 1
addi $s4, $s4, 1
j start_main

end:
add $s5, $s3, $s0
addi $s5, $s5, 1
end_main:
beq $s4, $s1, out
lb $a0, 0($s5)
li $v0, 11
syscall
addi $s5, $s5, 1
addi $s4, $s4, 1
j end_main

out:
li $v0, 10
syscall
 







