section .text

global f

f:
	push ebp
	mov ebp, esp
	push ebx			; przyda sie do zliczania ile danych wrzucilismy na stos
	
	mov eax, [ebp + 8]		; utworzenie wskaznika na pierwszy znak
	xor ebx, ebx			; KONIECZNIE nalezy wyzerowac
	
push_loop:
	mov cl, [eax]			; zaladowanie znaku
	cmp cl, 0
	je push_end
	
	inc ebx
	push ecx			; zachowanie na stosie znaku
	inc eax				; nastepny znak
	jmp push_loop
	
push_end:
	mov eax, [ebp + 8]
	
pop_loop:
	pop ecx				; robimy pop - zapisuje sie w rejestrze
	mov [eax], cl			; zapisanie znaku w odwrotnej kolejnosci
	inc eax
	
	dec ebx
	cmp ebx, 0
	jnz pop_loop
	
end:
	pop ebx
	mov esp, ebp
	pop ebp
	ret
	
	
	
