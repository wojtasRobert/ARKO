	.data
text0:	.asciiz		"Wpisz ciag znakow: \n"
text1:	.asciiz		"Nie ma cyfr: \n"
buff:	.space		100

	.text
	.globl main
main:
	la $a0, text0
	li $v0, 4
	syscall

	li $a1, 99	
	la $a0, buff
	li $v0, 8
	syscall
	
	la $t0, buff
	li $t1, 0 		# obecny licznik
	li $t2, 0		# maksymalny licznik
	
loop:
	lb $t4, ($t0)
	beq $t4, $zero, endloop
	bgt $t4, '9', increment_zero
	blt $t4, '0', increment_zero

	addiu $t1, $t1, 1		
	beq $t1, 1, first
	b increment
		
first:
	addiu $t3, $t0, 0
	b increment
	
greater:
	addiu $t2, $t1, 0
	addiu $t5, $t3, 0
	b loop
	
increment_zero:
	li $t1, 0
	
increment:
	addiu $t0, $t0, 1
	bgt  $t1, $t2, greater
	b loop	
	
endloop:
	beq $t2, 0, pusty
	
	addu $t1, $t5, $t2
	li $t0, 0
	sb $t0, ($t1)
		
	la $a0, ($t5)
	b end
	
pusty:
	la $a0, text1
		
end:	
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
