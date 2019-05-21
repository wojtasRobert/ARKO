	.data
text0:	.asciiz "Enter strng: \n"	# definicja stringu, który zostanie wypisany na konsoli
buf0:	.space 100					# definicja bufora na wczytywany string
	
	.text
	.globl main
	
main:
	la $a0, text0					# za³adowanie adresu string`a 'text0', jako argument wywo³ania systemowego które wypisze string na konsoli
	li $v0, 4						# za³adowanie numeru procedury systemowej, która zostanie uruchomiona - numer 4 odpowiada procedurze pisz¹cej na konsoli
	syscall							# przekazanie sterowania do systemu operacyjnego, system operacyjny wypisze na konsoli string który znajduje siê pod adresem za³adowanym do rejestru a0
	
	la $a0, buf0					# za³adowanie adresu bufora 'buf0', jako argument wywo³ania systemowego które wczyta string z konsoli
	li $a1, 99						# ile maksymalnie znaków system operacyjny mo¿e wczytaæ do bufora (pamiêtamy, ¿e string musi byæ zakoñczony wartoœci¹ 0)
	li $v0, 8						# za³adowanie numeru procedury systemowej - numer 8 odpowiada procedurze czytaj¹cej z konsoli
	syscall							# przekazanie sterowania do systemu operacyjnego, procedura ta zawiesi program dopuki u¿ytkownik nie wpisze ci¹gu znaków
	
	li $t0, 'a'						# tutaj definiujemy kilka wartoœci które bêd¹ potrzebne póŸniej
	li $t1, 'z'						# 	wartoœci te musz¹ znajdowaæ siê w rejestrach, poniewa¿ instrukcje które z nich bêd¹ korzystaæ, nie mog¹ przyj¹æ jako argumentu wartoœci natychmiastowej (czyli wartoœci na sztywno zapisanej w programie - musz¹ to byæ wartoœci w rejestrach)
	li $t2, 0x20
	
	la $t3, buf0					# rejestr t3 bêdzie tymczasowym wskaŸnikiem na bufor do którego zosta³ wczytany string
									# 	na pocz¹tku dzia³ania programu, wskaŸnik ten, wskazuje na pocz¹tek ci¹gu - póŸniej bêdzie on sukcesywnie przesuwany a¿ do koñca string`u
	
loop_begin:
	lb $t4, ($t3)					# do rejestru t4 ³adujemy bajt, który jest zapisany w pamiêci pod adresem zawartym w t3, w pierwszej iteracji pêtli adres w t3 wskazuje na pocz¹tek bufora, wiêc za³adowana bêdzie pierwsza litera string`u
	beq $t4, $zero, loop_end		# je¿eli wczytany bajt jest równy zero (zawartoœæ rejestru $zero zawsze wynosi 0) to skaczemy do punktu wyjœcia z pêtli (beq == branch if equal)
	
	blt $t4, $t0, increment_ptr		# je¿eli wartoœæ bajtu jest przed 'a' w tablicy ASCII, to skaczemy do etykiety 'increment_ptr' (blt == branch if lower than)
	bgt $t4, $t1, increment_ptr		# je¿eli wartoœæ bajtu jest za 'z' w tablicy ASCII, to skaczemy do etykiety 'increment_ptr' (blt == branch if greater than)
	
	sub $t4, $t4, $t2				# je¿eli znaleŸliœmy siê tutaj tzn. ¿e wczytany bajt jest >= 'a' oraz <= 'z' - a to oznacza ¿e jest on ma³¹ liter¹ alfabetu greckiego; gdyodejmiemy od niego wartoœæ 0x20 to zamiast ma³ej litery otrzymamy odpowiadaj¹c¹ jej wielk¹ literê
	sb $t4, ($t3)					# zamienion¹ wartoœæ musimy jeszcze zapisaæ w pamiêci tam sk¹d zosta³a ona wczeœniej pobrana
	
increment_ptr:
	addi $t3, $t3, 1				# bie¿¹cy znak zosta³ przetworzony, idziemy do kolejnego znaku - wskaŸnik na bufor przesuwamy o jeden bajt do przodu, teraz bêdzie przetwarzany kolejny wczytany znak
	b loop_begin					# skok do pocz¹tku pêtli (b == branch   bezwarunkowy skok)
loop_end:

	la $a0, buf0					# podobnie jak na pocz¹tku programu ³adujemy jako parametr wywo³ania adres bufora w którym znajduje siê przetwarzany string
	li $v0, 4						# numer wywo³ania 4 odpowiada procedurze wypisuj¹cej wskazany string na konsoli
	syscall							# wywo³anie procedury - przetwarzany string zostanie wypisany na konsoli
	
	li $v0, 10						# wywo³anie systemowe numer 10 powoduje zakoñczenie dzia³ania programu
	syscall							# :-)
