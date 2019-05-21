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
	la $t8, buff
loop:
	lb $t4, ($t0)
	beq $t4, $zero, end
	bgt $t4, 'z', wypisz
	blt $t4, 'a', wypisz
	addiu $t5, $t8, 0
	li $t1, 1
	b zlicz
	
zlicz:
	beq $t0, $t5, wypisz_mala
	lb $t2, ($t5)
	beq $t4, $t2, dodaj
	addiu $t5, $t5, 1
	b zlicz
	
dodaj:
	addiu $t1, $t1, 1
	addiu $t5, $t5, 1
	b zlicz
	
wypisz_mala:
	la $a0, ($t4)
	li $v0, 11
	syscall
	
	la $a0, ($t1)
	li $v0, 1
	syscall
	b increment
	
wypisz:
	la $a0, ($t4)
	li $v0, 11
	syscall

increment:
	addiu $t0, $t0, 1
	b loop
	
end:
	li $v0, 10
	syscall