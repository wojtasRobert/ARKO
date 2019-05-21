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
	li $t2, 3 
	
loop:
	lb $t4, ($t0)
	beq $t4, $zero, end
	bgt $t4, 'z', increment
	blt $t4, 'a', increment
	
	addi $t2, $t2, -1
	beq $t2, $zero, change	
	b increment
	
change:
	addi $t4, $t4 ,-32
	sb $t4, ($t0) 
	li $t2, 3 
	b increment

increment:
	addiu $t0, $t0,1
	b loop
		
end:
	la $a0, buff
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
