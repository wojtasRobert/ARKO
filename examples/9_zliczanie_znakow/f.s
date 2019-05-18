section .text

global f

f:
	push ebp
	mov ebp, esp
	push ebx
	
	mov ebx, [ebp + 8]
	xor eax, eax
	
begin:
	mov cl, [ebx]
	cmp cl, 0
	je end
	
	inc ebx
	inc eax
	jmp begin

end:
	pop ebx
	mov esp, ebp
	pop ebp
	ret
	
