	.data
text0:	.asciiz		"Wprowadz dane\n"
buff:	.space		100

	.text
	.globl main
	
main:
	la $a0, text0
	li $v0, 4
	syscall
	
	la $a0, buff
	li $a1, 99
	li $v0, 8
	syscall

	la $t0, buff	
	
loop:
	lb $t4, ($t0)
	beq $t4, $zero, end
	bge $t4, 'a', mala
	bge $t4, 'A', duza
	b increment
		

duza:
	bgt $t4, 'Z', increment
	addiu $t4, $t4, 32
	sb $t4, ($t0)
	b increment

mala:
	bgt $t4, 'z', increment
	addi $t4, $t4, -32
	sb $t4, ($t0)
	b increment

increment:
	addiu $t0, $t0, 1
	b loop

end:
	la $a0, buff
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall