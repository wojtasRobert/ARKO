[bits 64]
section .text

global drawCurve

drawCurve:
		push rbp			; prolog
		mov rbp, rsp
		
		push r12
		push r13
		push r14 
		
		mov r12, rdi			; rdi - wsk na bufor
		mov r13, rsi			; rsi - x[]
		mov r14, rdx			; rdx - y[]

		xor r8, r8			; poczatkowa wartosc t = 0
		cvtsi2ss xmm0, r8		; t - konwersja na floata
		
		mov r9, 1
		mov r10, 1000
		cvtsi2ss xmm1, r9
		cvtsi2ss xmm2, r10	
		divss xmm1, xmm2		; xmm1 - 0.001 krok t	
		
		mov r11, 0xFF000000		; do zamalowania piksela (kolor czarny)
		finit

bezier_x:
		cvtsi2ss xmm2, [r13] 		; x1
		cvtsi2ss xmm3, [r13 + 4] 	; x2
		cvtsi2ss xmm4, [r13 + 8]	; x3
		cvtsi2ss xmm5, [r13 + 12] 	; x4
		cvtsi2ss xmm6, [r13 + 16] 	; x5

calculate_x:
		mov rcx, 1
		cvtsi2ss xmm7, rcx		; 1
		subss xmm7, xmm0		; (1-t)
		
		;-------------------------------  x1*(1-t)^4
		
		movss xmm8, xmm7		; (1-t)
		mulss xmm8, xmm8		; (1-t)*(1-t)
		mulss xmm8, xmm8		; (1-t)*(1-t)*(1-t)*(1-t)
		mulss xmm8, xmm2		; (1-t)*(1-t)*(1-t)*(1-t) * x1
				
		;------------------------------- 4*x2*t*(1-t)^3
		
		movss xmm9, xmm7		; (1-t)
		mulss xmm9, xmm7		; (1-t)*(1-t)
		mulss xmm9, xmm7		; (1-t)*(1-t)*(1-t)
		mulss xmm9, xmm0		; (1-t)*(1-t)*(1-t)*t
		mov rcx, 4
		cvtsi2ss xmm10, rcx
		mulss xmm9, xmm10		; 4*(1-t)*(1-t)*(1-t)*t
		mulss xmm9, xmm3		; 4*(1-t)*(1-t)*(1-t)*t * x2
		
		;-------------------------------
		
		addss xmm8, xmm9		; wartosc calego wyrazenia
		
		;------------------------------- 6*x3*t^2*(1-t)^2
		
		movss xmm9, xmm7		; (1-t)
		mulss xmm9, xmm9		; (1-t)*(1-t)
		mulss xmm9, xmm0		; (1-t)*(1-t)*t
		mulss xmm9, xmm0		; (1-t)*(1-t)*t*t
		mov rcx, 6
		cvtsi2ss xmm10, rcx
		mulss xmm9, xmm10		; 6*(1-t)*(1-t)*t*t
		mulss xmm9, xmm4		; 6*(1-t)*(1-t)*t*t * x3
		
		;-------------------------------
		
		addss xmm8, xmm9		; wartosc calego wyrazenia
		
		;------------------------------- 4*x4*t^3*(1-t)
		
		movss xmm9, xmm7		; (1-t)
		mulss xmm9, xmm0		; (1-t)*t
		mulss xmm9, xmm0		; (1-t)*t*t
		mulss xmm9, xmm0		; (1-t)*t*t*t
		mov rcx, 4
		cvtsi2ss xmm10, rcx
		mulss xmm9, xmm10		; 4*(1-t)*t*t*t
		mulss xmm9, xmm5		; 4*(1-t)*t*t*t * x4
		
		;-------------------------------
		
		addss xmm8, xmm9		; wartosc calego wyrazenia
		
		;------------------------------- x5*t^4 
		
		movss xmm9, xmm0		; t
		mulss xmm9, xmm9		; t*t
		mulss xmm9, xmm9		; t*t*t*t
		mulss xmm9, xmm6		; t*t*t*t * x5
		
		;-------------------------------
		
		addss xmm8, xmm9		; x_b
		
		;-------------------------------
		
bezier_y:
		cvtsi2ss xmm2, [r14] 		; y1
		cvtsi2ss xmm3, [r14 + 4] 	; y2
		cvtsi2ss xmm4, [r14 + 8]	; y3
		cvtsi2ss xmm5, [r14 + 12] 	; y4
		cvtsi2ss xmm6, [r14 + 16] 	; y5

calculate_y:
		;mov rcx, 1
		;cvtsi2ss xmm7, rcx		; 1
		;subss xmm7, xmm0		; (1-t)
		
		;-------------------------------  y1*(1-t)^4
		
		movss xmm11, xmm7		; (1-t)
		mulss xmm11, xmm11		; (1-t)*(1-t)
		mulss xmm11, xmm11		; (1-t)*(1-t)*(1-t)*(1-t)
		mulss xmm11, xmm2		; (1-t)*(1-t)*(1-t)*(1-t) * y1
				
		;------------------------------- 4*y2*t*(1-t)^3
		
		movss xmm9, xmm7		; (1-t)
		mulss xmm9, xmm7		; (1-t)*(1-t)
		mulss xmm9, xmm7		; (1-t)*(1-t)*(1-t)
		mulss xmm9, xmm0		; (1-t)*(1-t)*(1-t)*t
		mov rcx, 4
		cvtsi2ss xmm10, rcx
		mulss xmm9, xmm10		; 4*(1-t)*(1-t)*(1-t)*t
		mulss xmm9, xmm3		; 4*(1-t)*(1-t)*(1-t)*t * y2
		
		;-------------------------------
		
		addss xmm11, xmm9		; wartosc calego wyrazenia
		
		;------------------------------- 6*y3*t^2*(1-t)^2
		
		movss xmm9, xmm7		; (1-t)
		mulss xmm9, xmm9		; (1-t)*(1-t)
		mulss xmm9, xmm0		; (1-t)*(1-t)*t
		mulss xmm9, xmm0		; (1-t)*(1-t)*t*t
		mov rcx, 6
		cvtsi2ss xmm10, rcx
		mulss xmm9, xmm10		; 6*(1-t)*(1-t)*t*t
		mulss xmm9, xmm4		; 6*(1-t)*(1-t)*t*t * y3
		
		;-------------------------------
		
		addss xmm11, xmm9		; wartosc calego wyrazenia
		
		;------------------------------- 4*y4*t^3*(1-t)
		
		movss xmm9, xmm7		; (1-t)
		mulss xmm9, xmm0		; (1-t)*t
		mulss xmm9, xmm0		; (1-t)*t*t
		mulss xmm9, xmm0		; (1-t)*t*t*t
		mov rcx, 4
		cvtsi2ss xmm10, rcx
		mulss xmm9, xmm10		; 4*(1-t)*t*t*t
		mulss xmm9, xmm5		; 4*(1-t)*t*t*t * y4
		
		;-------------------------------
		
		addss xmm11, xmm9		; wartosc calego wyrazenia
		
		;------------------------------- y5*t^4 
		
		movss xmm9, xmm0		; t
		mulss xmm9, xmm9		; t*t
		mulss xmm9, xmm9		; t*t*t*t
		mulss xmm9, xmm6		; t*t*t*t * y5
		
		;-------------------------------
		
		addss xmm11, xmm9		; y_b
		
		;-------------------------------		
		
convert_to_int:
		xor r9, r9
		xor r10, r10
		cvtss2si r9, xmm8		; wspolrzedna x piksela
		cvtss2si r10, xmm11		; wspolrzedna y piksela
		
draw_single_pixel:				; wyliczanie offsetu dla wyliczonych pikseli
						; i zamalowanie piksela
		sal r9, 2			; x razy 4 bajty
		
		mov rax, 500
		sub rax, r10
		
		mov r10, 2000
		mul r10
		mov r10, rax
		
		add r10, r9			; wyliczony offset 
		mov rax, r12
		add rax, r10
		
		mov [rax], r11d

loop:
		addss xmm0, xmm1		; zwiekszenie t
		mov rcx, 1
		cvtsi2ss xmm2, rcx
		cmpss xmm2, xmm0, 2
		movq rax, xmm2
		cmp rax, 0
		je bezier_x
		

end:
		pop r14
		pop r13
		pop r12

		mov rsp, rbp			; epilog
		pop rbp				; cofniecie esp o 8 i pobranie starego ebp
		ret 	

