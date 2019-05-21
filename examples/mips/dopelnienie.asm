	.data
text0:	.asciiz		"Wpisz ciag znakow: \n"
buf:	.space 		100

	.text
	.globl main

main:
	la $a0, text0
	li $v0, 4
	syscall
	
	la $a0, buf
	li $a1, 99
	li $v0, 8
	syscall

	li $t0, '0'
	li $t1, '9'
	
	la $t2, buf
	
loop:
	lb $t4, ($t2)
	beq $t4, $zero, end
	blt $t4, $t0, increment
	bgt $t4, $t1, increment
	
	subu $t4, $t1, $t4
	addu $t4, $t4, $t0
	
	sb $t4, ($t2)
	
increment:
	addiu $t2, $t2, 1
	b loop	

end:
	la $a0, buf
	li $v0, 4
	syscall

	li $v0, 10
	syscall