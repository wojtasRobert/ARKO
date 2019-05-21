	.data
text0:	.asciiz		"Wprowadz dane\n"
buff:	.space		100
wynik:	.space		100

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
	
	la $t0, buff #testowany
	la $t1, wynik #na wynik
	li $t8, 0
	li $t2, 'a'
	li $s1, 10
loop:
	lb $t4, ($t0)
	blt $t4, ' ', nextloop
	addiu $t0, $t0, 1
	beq $t4, $t2, dodaj
	b loop
	
dodaj:
	addiu $t8, $t8, 1
	b loop
	
nextloop:	
	beq $t8, 0, pusta
	# nie pusta
	
	sb $t2, ($t1)
	addiu $t1, $t1, 1
	
	
	bgt $t8, 9 , duzaliczba
	addiu $t8, $t8, 48
	sb $t8, ($t1)	
	addu $t1, $t1, 1	
	b pusta
	
duzaliczba:
	div $t8, $s1
	mfhi  $s2       #  remainder moved into $t2
	subu $t8, $t8, $s2
	addiu $s2, $s2, 48
	
	divu $t8, $t8,$s1
	divu $t8, $s1
	mfhi  $s3 
	subu $t8, $t8, $s3
	addiu $s3, $s3, 48
	
	divu $t8,$t8, $s1
	divu $t8, $s1
	mfhi  $s4
	subu $t8, $t8, $s4
	addiu $s4, $s4, 48
	beq $s4, '0', dwucyfrowa
	sb $s4, ($t1)
	addiu $t1, $t1, 1
	b dwucyfrowa
	
dwucyfrowa:
	sb $s3, ($t1)
	addiu $t1, $t1, 1
	sb $s2, ($t1)
	addiu $t1, $t1, 1
	b pusta
		
pusta:	
	li $t8, 0
	addiu $t2, $t2, 1
	beq $t2, 'z' end
	la $t0, buff #testowany
	b loop
	
end:
	sb $zero, ($t1)
	la $a0, wynik
	li $v0, 4
	syscall

	li $v0, 10
	syscall
