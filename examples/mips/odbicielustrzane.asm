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
	li $t1, 219
loop:
	lb $t4, ($t0)
	blt $t4, ' ', end
	
	subu $t4, $t1, $t4
	#addiu $t4, $t4, 'a'
	
	sb $t4, ($t0)
	addiu $t0, $t0, 1
	b loop

end:
	la $a0, buff
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
