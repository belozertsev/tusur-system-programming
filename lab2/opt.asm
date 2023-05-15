section .data
	nums: db -1, 2, -3, 4, -5, 6, -7, 16, -9
	len: db 9

section .text
	global _start

_start:
	xor edx, edx

_loop:
	cmp dl, byte [len]
	je _finalize

	mov bl, byte [nums + edx]
	cmp bl, 0
	jl _negative_logic
	jmp _positive_logic

_negative_logic:
	sar bl, 2
	mov byte [nums + edx], bl
	inc dl
	jmp _loop

_positive_logic:
	and bl, 0xee
	mov byte [nums + edx], bl
	inc dl
	jmp _loop

_finalize:
	mov eax, 1
	mov ebx, [nums]
	int 0x80
