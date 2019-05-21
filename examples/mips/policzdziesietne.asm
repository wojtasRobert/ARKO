	.data
text0:	.asciiz		"Wpisz ciag znakow: \n"
buff:	.space		100

	.text
	.globl	main
	
main:
	la $a0, text0
	li $v0, 4
	syscall
	
	la $a0 buff
	li $a1, 99
	li $v0, 8
	syscall
	
	li $t0, 0 # licznik 1
	li $t2, 0 # 1 - w trakcje ciagu jedynek, 0 - niejedynki
	la $t1, buff
	
loop:
	lb $t3, ($t1)
	beq $t3, $zero, end
	blt $t3, '0', check
	bgt $t3, '9', check
	
	beq $t2, 0, addnumber
	b increment
	
check:
	beq $t2, 0, increment
	li $t2, 0
	b increment
	
addnumber:
	addiu $t0, $t0, 1
	li $t2, 1
	b increment

increment:
	addiu $t1, $t1, 1
	b loop
	
end:
	la $a0, ($t0)
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall