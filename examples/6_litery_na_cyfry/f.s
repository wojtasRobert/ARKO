section .text

global f

f:
	push ebp
	mov ebp, esp
	
	mov eax, [ebp + 8]
	
loop:
	mov cl, [eax]
	cmp cl, 0
	jz end
	
	cmp cl, 'a'
	jl dodaj
	
	sub cl, '1'
	jmp write
	
dodaj:
	add cl, '1'
	
write:
	mov [eax], cl
	inc eax
	jmp loop
	
end:
	mov [eax], cl
	
	mov esp, ebp
	pop ebp
	ret
	

