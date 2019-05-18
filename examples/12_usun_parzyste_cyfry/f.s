section .text

global f

f:
	push ebp
	mov ebp, esp
	
	mov eax, [ebp + 8]
	mov edx, [ebp + 8]
	
begin:
	mov cl, [eax]
	cmp cl, 0
	jz end
	
	inc eax
	
	cmp cl, '0'
	je begin
	cmp cl, '2'
	je begin
	cmp cl, '4'
	je begin
	cmp cl, '6'
	je begin
	cmp cl, '8'
	je begin
	
write:
	mov [edx], cl
	inc edx
	jmp begin

end:
	mov [edx], cl
	
	mov esp, ebp
	pop ebp
	ret	
