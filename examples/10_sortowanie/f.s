section .text

global f

f:
  	push ebp
	mov ebp, esp
	
	push ebx
	push esi
	push edi
	
	mov eax, [ebp + 8]
	xor edx, edx
	xor edi, edi
	
lenght:
	mov cl, [eax]
	inc eax
	inc edx
	
	cmp cl, 0
	jne lenght	
	
	sub edx, 2
	
outer_loop:
	mov eax, [ebp + 8]
	xor esi, esi
		
inner_loop:
	mov cl, [eax]
	mov bl, [eax + 1]
		
	cmp cl, bl
	jle next_inner
	
swap:
	mov [eax], bl
	mov [eax + 1], cl
	
next_inner:
	inc eax
	inc esi
	cmp esi, edx
	jne inner_loop

next_outer:
	inc edi
	cmp edi, edx
	jne outer_loop
	
end:
	pop edi
	pop esi
	pop ebx
	
	mov esp, ebp
	pop ebp
	ret	
	
	
