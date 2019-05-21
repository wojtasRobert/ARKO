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
	
	addiu $t4, $t4, 49
	sb $t4, ($t0)
	b increment	
	
	b increment
		
mala:
	addi $t4, $t4, -49
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
