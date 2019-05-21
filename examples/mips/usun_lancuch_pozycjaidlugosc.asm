	.data
text0:		.asciiz		"Wprowadz dane\n"
text1:		.asciiz		"Wczytaj dlugosc\n"
text2:		.asciiz		"Wprowadz pozycje\n"
text3:		.asciiz		"Wpisz sensowne dane\n"
buff:		.space		100


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
wpisz:	
	la $a0, text1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	addiu $t8, $v0,0
	
	la $a0, text2
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	addiu $t9, $v0, 0
	 			
	la $t4, buff
	la $t0, buff
						
	blt $t8, $zero, nieprawidlowe
	blt $t9, 1, nieprawidlowe
	
	li $t3, 0 #dlugosc tekstu
	
zliczdlugosc:
	lb $t5, ($t4)
	beq $t5, $zero, sprawdzdlugosc
	addiu $t3, $t3, 1
	addiu $t4, $t4, 1
	b zliczdlugosc
	
sprawdzdlugosc:
	addi $t3, $t3, -1
	addu $t4, $t9, $t8
	addi $t4, $t4, -1
	
	bgt $t4, $t3, nieprawidlowe
	b before
	
nieprawidlowe:
	la $a0, text3
	li $v0, 4
	syscall
	b wpisz
	
before:
	addu $t0, $t0, $t9
	addi $t0, $t0, -1
	addu $t4, $t0, $t8
	b loop
loop:
	lb $t3, ($t4)
	beq $t3, $zero, end
	sb $t3, ($t0)
	addiu $t0, $t0, 1
	addiu $t4, $t4, 1
	b loop
end:
	sb $zero, ($t0)
	la $a0, buff
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall	
