	.data
text1:	.asciiz		"Wpisz ciag znakow\n"
buff:	.space		100

	.text
	.globl main
	
main:
	la $a0, text1
	li $v0, 4
	syscall
	
	la $a0, buff
	li $a1, 99
	li $v0, 8
	syscall
	
	la $t1, buff #koniec
	la $t2, buff #poczatek
	la $t6, buff
	
firstloop:	
	lb $t4, ($t1)
	beq $t4, $zero, changeloop
	addiu $t1, $t1, 1
	b firstloop
	
changeloop:
	lb $t4, ($t2)
	beq $t1, $t2, end
	beq $t2, $zero, end
	
	bgt $t4, '9', increment
	blt $t4, '0', increment
	
	b backloop
	
backloop:
	lb $t5, ($t1)
	
	beq $t1, $t2, end
	beq $t1, $t6, end
	
	bgt $t5, '9', decrement
	blt $t5, '0', decrement
		
	sb $t5, ($t2)
	sb $t4, ($t1)
	
	addi $t1, $t1, -1
	beq $t2, $t1, end
	addiu $t2, $t2, 1
	
	b changeloop
			
decrement:
	addi $t1, $t1, -1
	b backloop
			
increment:
	addiu $t2, $t2, 1
	b changeloop
			
end:
	la $a0, buff
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall	
