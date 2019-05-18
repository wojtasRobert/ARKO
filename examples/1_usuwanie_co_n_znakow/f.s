section .text

global f

f:					; prolog funkcji
	push ebp			; zapamietanie wskaznika ramki procedury wolajacej
	mov ebp, esp			; ustanowienie wlasnego wskaznika ramki	
	push ebx
	
	mov eax, [ebp + 8]		; zapisanie adresu stringa		
	mov ebx, [ebp + 8]		; drugi wskaznik na napis
	mov ecx, [ebp + 12]		; zapisanie co ile mamy usuwac
	
begin:
	mov dl, [eax]
	cmp dl, 0
	je end

	inc eax
	dec ecx
	jz reload		 	; jesli zero to pomijamy znak
	
write:
	mov [ebx], dl
	inc ebx
	jmp begin

reload:
	mov ecx, [ebp + 12]
	jmp begin
	
end:
	mov [ebx], dl
	pop ebx
	mov esp, ebp
	pop ebp
	ret
	
	
	
