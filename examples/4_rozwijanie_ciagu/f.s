section .text
global f

f:
	push ebp		; zachowanie wskaznika ramki procedury wolajacej
	mov ebp, esp		; ustalenie nowego wskaznika ramki dla procedury wolanej
	
	push ebx		; rejestr zachowywany
	
	mov eax, [ebp + 8]	; zapisanie adresu na input string
	mov ebx, [ebp + 12]	; zapisanie adresu na output string
	
	xor dl, dl		; wyzerowanie rejestru 8-bitowego dl
	xor cl, cl		
	
begin:
	mov dl, [eax]		; zaladowanie zawartosci adresu (1 bajt)
	cmp dl, 0
	je end 		
	inc eax			; przejscie na kolejny znak
	mov cl, [eax]
	sub cl, '0'		; odjecie od kodu znaku kodu zera
	jz next
	
loop:	
	mov [ebx], dl		; zapisanie znaku do wyjsciowego stringa
	inc ebx			; wskaznik na nastepne miejsce do wpisania
	dec cl			; dekrementacja liczby wystapien znaku
	jnz loop		; dopoki rozne od zera to zapisujemy ten sam znak
	
next:
	inc eax			
	mov dl, [eax] 		; nastepna litera
	cmp dl, 0
	je end
	inc eax			; ile powtorzen
	mov cl, [eax]
	sub cl, '0'
	jz next
	jmp loop
	
end:
	mov [ebx], dl		; zakonczenie stringa znakiem '\0'

	pop ebx
	pop ebp
	ret
	
	
