; ZALOZENIE ZE WPISYWANE SA TYLKO CYFRY LUB MALE LITERY ALFABETU

section .text

global f

f:
	push ebp
	mov ebp, esp
	push ebx
		
	mov eax, [ebp + 8]
	mov dl, '9'			; zapisanie kodu '9'
	mov bl, 'z'			; zapisanie kodu 'z'

begin:
	mov cl, [eax]
	cmp cl, 0
	je end

	cmp cl, 'a'			; sprawdzenie czy litera czy liczba
	jge letter
	
digit:
	sub dl, cl			; od kodu '9' odejmuje kod cyfry
	add dl, '0'
	mov [eax], dl			; wynik zachowuje pod adresem znaku
	inc eax
	mov dl, '9'
	jmp begin
	
letter:
	sub bl, cl			; odejmuje od kodu 'z' kod znaku
	add bl, 'a'			; dodaje wynik do kodu 'a'
	mov [eax], bl
	inc eax
	mov bl, 'z'
	jmp begin
	
end:
	pop ebx
	mov esp, ebp
	pop ebp
	ret

