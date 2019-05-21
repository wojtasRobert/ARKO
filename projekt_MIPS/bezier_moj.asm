		.data
buffer: 	.space 4	# tymczasowy bufor
size:		.space 4	# rozmiar bitmapy w bajtach
offset:		.space 4	# przesuniecie pikseli wzgledem naglowka
start:		.space 4	# poczatek bajtow opisujacych piksele
width:		.space 4	# szerokosc w pikselach
height:		.space 4	# wysokosc w pikselach

line:		.asciiz " ------------------------ \n"
title:		.asciiz "| Bezier curve generator |\n"
filename:	.asciiz "bezier.bmp"

com_meas:	.asciiz "Measurements of a bitmap: \n"
com_width:	.asciiz "Width: "
com_height:	.asciiz "Height: "

com_p1:		.asciiz "Enter coordinates for p1: \n"
com_p2:		.asciiz "Enter coordinates for p2: \n"
com_p3:		.asciiz "Enter coordinates for p3: \n"
com_x:		.asciiz "x: "
com_y:		.asciiz "y: "

com_error:	.asciiz "ERROR OCCURED!\n"
com_draw:	.asciiz "Drawing in progress...\n"
com_end:	.asciiz "Bitmap saved successfully!\n"
com_x_size:	.asciiz " x "
com_newline:	.asciiz "\n"
	
		.text
		.globl main
main:
		li $v0, 4
		la $a0, line
		syscall
	
		li $v0, 4
		la $a0, title
		syscall
	
		li $v0, 4
		la $a0, line
		syscall	
	
opening:	
		li $v0, 13
		la $a0, filename
		li $a1, 0
		li $a2, 0
		syscall
		
		bltz $v0, error
		move $s7, $v0 		#deskryptor pliku
		
params:
		# pierwsze dwa bajty nag³owka - "BM"
		li $v0, 14
		move $a0, $s7
		la $a1, buffer
		li $a2, 2
		syscall
		
		# rozmiar - 4 bajty
		li $v0, 14
		move $a0, $s7
		la $a1, size
		li $a2, 4
		syscall
		
		lw $s6, size
		
		# alokacja pamieci
		li $v0, 9
		move $a0, $s6
		syscall
		
		beqz $v0, error		# jesli cos poszlo nie tak... 
		move $s5, $v0
		sw $s5, start		
				
		# kolejne 4 bajty - zarezerwowane 
		li $v0, 14
		move $a0, $s7
		la $a1, buffer
		li $a2, 4
		syscall
		
		# offset - 4 bajty
		li $v0, 14
		move $a0, $s7
		la $a1, offset
		li $a2, 4
		syscall 
		
		lw $s4, offset
		
		# rozmiar struktury BITMAPINFOHEADER - 4 bajty
		li $v0, 14
		move $a0, $s7
		la $a1, buffer
		li $a2, 4
		syscall
		
		# szerokosc - 4 bajty
		li $v0, 14
		move $a0, $s7
		la $a1, width
		li $a2, 4
		syscall
		
		lw $s3, width
		
		# wysokosc - 4 bajty
		li $v0, 14
		move $a0, $s7
		la $a1, height
		li $a2, 4
		syscall
		
		lw $s2, height
		
		# zamkniecie pliku
		li $v0, 16
		move $a0, $s7
		syscall
		
#	s7 - deskryptor
#	s6 - rozmiar
#	s5 - adres w pamieci
#	s4 - offset
#	s3 - szerokosc w pixelach
#	s2 - wysokosc w pixelach

to_memory:
		# otwieram w celu zapisania do pamieci
		li $v0, 13
		la $a0, filename
		li $a1, 0
		li $a2, 0
		syscall
		
		bltz $v0, error
		move $s7, $v0 		#deskryptor pliku
		
		li $v0, 14
		move $a0, $s7
		move $a1, $s5
		move $a2, $s6
		syscall
		
		# zamkniecie pliku
		li $v0, 16
		move $a0, $s7
		syscall
	
#	s3 - szerokosc w pixelach			
padding:
		mul $s1, $s3, 3		#ile bajtow ma kazda linia
		andi $t1, $s1, 0x00000003	# ile potrzebujemy bajtow paddingu
		beqz $t1, print_info
		li $t2, 4
		subu $t2, $t2, $t1
		addu $s1, $s1, $t2	#dodaje dodatkowe bajty do ilosci bajtow jednej linii

#	s7 - deskryptor
#	s6 - rozmiar
#	s5 - adres w pamieci
#	s4 - offset
#	s3 - szerokosc w pixelach
#	s2 - wysokosc w pixelach
#	s1 - szerokosc linii w bajtach z paddingiem

print_info:
		li $v0, 4
		la $a0, com_meas
		syscall
		
		li $v0, 4
		la $a0, com_width
		syscall
		
		li $v0, 1
		move $a0, $s3
		syscall
		
		li $v0, 4
		la $a0, com_newline
		syscall
		
		li $v0, 4
		la $a0, com_height
		syscall
		
		li $v0, 1
		move $a0, $s2
		syscall
		
		li $v0, 4
		la $a0, com_newline
		syscall
		
get_coordinates:
		# P1
		li $v0, 4
		la $a0, com_p1
		syscall
		
		li $v0, 4
		la $a0, com_x
		syscall
		
		li $v0, 5
		syscall
		move $t0, $v0	#x1
		
		li $v0, 4
		la $a0, com_y
		syscall
		
		li $v0, 5
		syscall
		move $t1, $v0	#y1
		
		li $v0, 4
		la $a0, com_newline
		syscall	
		
		# P2
		li $v0, 4
		la $a0, com_p1
		syscall
		
		li $v0, 4
		la $a0, com_x
		syscall
		
		li $v0, 5
		syscall
		move $t2, $v0	#x2
		
		li $v0, 4
		la $a0, com_y
		syscall
		
		li $v0, 5
		syscall
		move $t3, $v0	#y2
		
		li $v0, 4
		la $a0, com_newline
		syscall	
		
		# P3
		li $v0, 4
		la $a0, com_p1
		syscall
		
		li $v0, 4
		la $a0, com_x
		syscall
		
		li $v0, 5
		syscall
		move $t4, $v0	#x3
		
		li $v0, 4
		la $a0, com_y
		syscall
		
		li $v0, 5
		syscall
		move $t5, $v0	#y3
		
		li $v0, 4
		la $a0, com_newline
		syscall	
		
###################################		
		
#	t0 = x1		t1 = y1				
#	t2 = x2		t3 = y2					
#	t4 = x3		t5 = y3

#
																						#	s7 - deskryptor
#	s7, s6, s0, t6, t7, t8, t9 - nieuzywane
#	s5 - adres bitmapy w pamieci 
#	s4 - offset (zapisane w pamieci)
#	s3 - szerokosc w pixelach (zapisane w pamieci)
#	s2 - wysokosc w pixelach (zapisane w pamieci)
#	s1 - szerokosc linii w bajtach	z paddinggiem

#	liczby ze stalym przecinkiem 16.16

last_preparations:

		li $t9, 0x00010000	# wartosc t_max = 1
		li $t8, 0x00000010	# co ile rosnie t
		li $t7, 0		# aktualna wartosc t	
		
		# przesuniecie punktow na czesc calkowita
		sll $t0, $t0, 16	#x1
		sll $t1, $t1, 16	#y1
		sll $t2, $t2, 16	#x2
		sll $t3, $t3, 16	#y2
		sll $t4, $t4, 16	#x3
		sll $t5, $t5, 16	#y3
		
calculate_point:
		#WZORY:
		# x(t) = (1-t)^2 * x1 + 2 * t * (1-t) * x2 + t^2 * x3
		# y(t) = (1-t)^2 * y1 + 2 * t * (1-t) * y2 + t^2 * y3
		
		# ( 1-t ) ---------------> s0
		subu $s0, $t9, $t7		
		multu $s0, $s0	
		# ( 1-t )^2 -------------> t6
		mflo $t6
		srl $t6, $t6, 16
		
		multu $t7, $s0 # t * ( 1-t )
		mflo $s7
		srl $s7, $s7, 16
		# 2 * t * (1-t) ---------> s7
		sll $s7, $s7, 1 
		
		# t^2 -------------------> s6
		multu $t7, $t7 
		mflo $s6
		srl $s6, $s6, 16
		
																																																																																																																																																																																																																																																				
		
		
																																																																																																																																																																																																						
		b exit
error:
		li $v0, 4
		la $a0, com_error
		syscall
	
exit:
		li $v0, 10
		syscall
