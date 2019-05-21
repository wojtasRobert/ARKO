	.data
text0:	.asciiz "Enter strng: \n"	# definicja stringu, kt�ry zostanie wypisany na konsoli
buf0:	.space 100					# definicja bufora na wczytywany string
	
	.text
	.globl main
	
main:
	la $a0, text0					# za�adowanie adresu string`a 'text0', jako argument wywo�ania systemowego kt�re wypisze string na konsoli
	li $v0, 4						# za�adowanie numeru procedury systemowej, kt�ra zostanie uruchomiona - numer 4 odpowiada procedurze pisz�cej na konsoli
	syscall							# przekazanie sterowania do systemu operacyjnego, system operacyjny wypisze na konsoli string kt�ry znajduje si� pod adresem za�adowanym do rejestru a0
	
	la $a0, buf0					# za�adowanie adresu bufora 'buf0', jako argument wywo�ania systemowego kt�re wczyta string z konsoli
	li $a1, 99						# ile maksymalnie znak�w system operacyjny mo�e wczyta� do bufora (pami�tamy, �e string musi by� zako�czony warto�ci� 0)
	li $v0, 8						# za�adowanie numeru procedury systemowej - numer 8 odpowiada procedurze czytaj�cej z konsoli
	syscall							# przekazanie sterowania do systemu operacyjnego, procedura ta zawiesi program dopuki u�ytkownik nie wpisze ci�gu znak�w
	
	li $t0, 'a'						# tutaj definiujemy kilka warto�ci kt�re b�d� potrzebne p�niej
	li $t1, 'z'						# 	warto�ci te musz� znajdowa� si� w rejestrach, poniewa� instrukcje kt�re z nich b�d� korzysta�, nie mog� przyj�� jako argumentu warto�ci natychmiastowej (czyli warto�ci na sztywno zapisanej w programie - musz� to by� warto�ci w rejestrach)
	li $t2, 0x20
	
	la $t3, buf0					# rejestr t3 b�dzie tymczasowym wska�nikiem na bufor do kt�rego zosta� wczytany string
									# 	na pocz�tku dzia�ania programu, wska�nik ten, wskazuje na pocz�tek ci�gu - p�niej b�dzie on sukcesywnie przesuwany a� do ko�ca string`u
	
loop_begin:
	lb $t4, ($t3)					# do rejestru t4 �adujemy bajt, kt�ry jest zapisany w pami�ci pod adresem zawartym w t3, w pierwszej iteracji p�tli adres w t3 wskazuje na pocz�tek bufora, wi�c za�adowana b�dzie pierwsza litera string`u
	beq $t4, $zero, loop_end		# je�eli wczytany bajt jest r�wny zero (zawarto�� rejestru $zero zawsze wynosi 0) to skaczemy do punktu wyj�cia z p�tli (beq == branch if equal)
	
	blt $t4, $t0, increment_ptr		# je�eli warto�� bajtu jest przed 'a' w tablicy ASCII, to skaczemy do etykiety 'increment_ptr' (blt == branch if lower than)
	bgt $t4, $t1, increment_ptr		# je�eli warto�� bajtu jest za 'z' w tablicy ASCII, to skaczemy do etykiety 'increment_ptr' (blt == branch if greater than)
	
	sub $t4, $t4, $t2				# je�eli znale�li�my si� tutaj tzn. �e wczytany bajt jest >= 'a' oraz <= 'z' - a to oznacza �e jest on ma�� liter� alfabetu greckiego; gdyodejmiemy od niego warto�� 0x20 to zamiast ma�ej litery otrzymamy odpowiadaj�c� jej wielk� liter�
	sb $t4, ($t3)					# zamienion� warto�� musimy jeszcze zapisa� w pami�ci tam sk�d zosta�a ona wcze�niej pobrana
	
increment_ptr:
	addi $t3, $t3, 1				# bie��cy znak zosta� przetworzony, idziemy do kolejnego znaku - wska�nik na bufor przesuwamy o jeden bajt do przodu, teraz b�dzie przetwarzany kolejny wczytany znak
	b loop_begin					# skok do pocz�tku p�tli (b == branch   bezwarunkowy skok)
loop_end:

	la $a0, buf0					# podobnie jak na pocz�tku programu �adujemy jako parametr wywo�ania adres bufora w kt�rym znajduje si� przetwarzany string
	li $v0, 4						# numer wywo�ania 4 odpowiada procedurze wypisuj�cej wskazany string na konsoli
	syscall							# wywo�anie procedury - przetwarzany string zostanie wypisany na konsoli
	
	li $v0, 10						# wywo�anie systemowe numer 10 powoduje zako�czenie dzia�ania programu
	syscall							# :-)
