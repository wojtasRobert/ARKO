section .text

global f

f:				; prolog funkcji
	push ebp		; zapamietanie wskaznika ramki procedury wolajacej
	mov ebp, esp		; ustanowienie wlasnego wskaznika ramki	
	push ebx		; zachowanie na stosie rejestru zachowywanego
	push esi

	mov eax, [ebp + 8]	; zapisanie w akumulatorze adresu napisu (src)
	mov esi, [ebp + 8]	; utworzenie drugiego wskaznika na napis (dst)

; ebp+12 == a, ebp+16 == b

next_char:

	mov cl, [eax]		; zapisanie kolejnego bajtu z napisu
	cmp cl, 0		; warunek konca petli
	jz end
	
	inc eax			; inkrementacja pierwszego wskaznika na nastepny znak

cond_1:
	mov bl, [ebp + 12]	; zaladowanie dolnej granicy przedzialu
	cmp cl, bl		; porownanie z dolna granica przedzialu
	jge cond_2		; jesli wiekszy to sprawdzamy drugi warunek przynaleznosci do przedzialu
	jmp write		; jak ok to zapisz znak

cond_2:
	mov bh, [ebp + 16]	; zaladowanie gornej granicy przedzialu
	cmp cl, bh		; porownanie z gorna granica przedzialu
	jle next_char		; znak w zakresie wiec przechodzimy dalej nie zapisujac

write:			
	mov [esi], cl		; zapisanie pod adresem przeznaczenia
	inc esi			; inkrementacja wskaznika dst	
	jmp next_char		; zapetlenie

end:
	mov [esi], cl
	pop esi
	pop ebx

	mov esp, ebp
	pop ebp
	ret



	 

	
