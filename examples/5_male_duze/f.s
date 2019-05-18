section .text

global f

f:
	; prolog 
	
	push ebp			; zapamietanie wskaznika ramki procedury wolajacej
	mov ebp, esp			; ustanowienie nowego wskaznika ramki
	mov eax, [ebp + 8]		; zaladowanie adresu stringa
	
begin:					; wczytanie pierwszego znaku
	mov cl, [eax]
	cmp cl, 0
	je end	
	cmp cl, 'a' 			; sprawdzam czy mala czy wielka litera
	jl upper			; jesli litera wielka (kod mniejszy od 'a') zapisuj wielka
	
lower:	
	sub cl, 32			; odejmuje 32 od kodu malej litery	
	jmp write
	
upper:
	add cl, 32			; dodaje 32 do kodu wielkiej litery
		
write:
	mov [eax], cl			; zapisuje znak na odpowiednie miejsce
	inc eax
	jmp begin
	
end:
	; epilog
	mov esp, ebp
	pop ebp
	ret
