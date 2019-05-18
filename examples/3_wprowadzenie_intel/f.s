section .text

global f

f:
  	push EBP
        mov EBP, ESP
        mov EAX, [ebp + 8]

begin:
      	mov cl, [eax]
        cmp cl, 0
        jz end

        add cl, 1
        mov [eax], cl
        inc eax
        jmp begin

end:
    	mov esp, ebp
        pop ebp
        ret

