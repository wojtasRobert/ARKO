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

	li $t1, '9'
	li $t2, '0'
	li $t3, 0
	li $t4, 0
		
	# t1 minimum
	# t2 maxminum
	#t3 srednia i suma
	#t4 dlugosc bufora
	
loop:
	lb $t5, ($t0)
	blt $t5, ' ', before
	
	addu $t3, $t3, $t5
	addi $t3, $t3, -48
	
	addiu $t4, $t4, 1
	addiu $t0, $t0, 1
	bgt $t5, $t2, wieksza
	blt $t5, $t1, mniejsza
	b loop
	
mniejsza:
	addiu $t1, $t5, 0
	b loop
	
wieksza:
	addiu $t2, $t5, 0
	blt $t5, $t1, mniejsza
	b loop
		
before:
	div $t3, $t3, $t4
	addiu $t3, $t3, 48
	la $t0, buff
	
zamien:
	lb $t5, ($t0)
	blt $t5, ' ', end
		
	blt $t5, $t3, minimum
	
	addiu $t0, $t0, 1
	b zamien
	
minimum:
	sb $t1, ($t0)
	addiu $t0, $t0, 1
	b zamien

end:
	la $a0, buff
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
