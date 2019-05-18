section .text

global f

f:
  	push ebp
	mov ebp, esp
	
	mov eax, [ebp + 8]
	
	
	
begin:
	mov ecx, [eax]		; zaladowanie slowa
	cmp cl, 0
	jz end
	
	and ecx, 0xFFFFFFDF	; zamiana pierwszego znaku na wielka litere
	or ecx, 0x20002000	; w razie czego zamiana na mala litere
	
	mov [eax], ecx	
	add eax, 4
	jmp begin
	
end:
	mov esp, ebp
	pop ebp
	ret
