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
	
	
	la $t0, buff #calosc do przejscia
	la $t1, buff #nowy tekst
	li $t2, 0 # 0 nie bylo myslnika, #1  byl myslnik
	
loop:
	lb $t4, ($t0)
	beq $t4, $zero, end
	beq $t4, '-', myslnik
	
	bgt $t4, 'z', inny
	blt $t4, 'a', inny
	
	beq $t2, 0, inny
	addi $t4, $t4, -32 
	b inny
	
myslnik:
	li $t2, 1
	b increment

inny:
	li $t2, 0
	sb $t4, ($t1)
	addiu $t1, $t1, 1
	b increment

	
increment:
	addiu $t0, $t0, 1
	b loop

		
end:
	sb $zero, ($t1)
	la $a0, buff
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
