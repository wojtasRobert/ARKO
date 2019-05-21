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
	bgt $t4, 'Z', increment
	blt $t4, 'A', increment
	addi $t4,  $zero ,'*'
	sb $t4, ($t0) 
	sb $t4, ($t0) 



increment:
	addiu $t0, $t0,1
	b loop
		
end:
	la $a0, buff
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
