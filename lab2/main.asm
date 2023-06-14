section .data
	; Объявление массива из девяти элементов и его длины
	nums: db -1, 2, -3, 4, -5, 6, -7, 16, -9
	len: db 9
	
	; Формат сообщения для вывода (с использованием printf)
	msg: db "%d", 0xa, 0

section .text
	global main
	extern printf

main:
	; Сохранение стека
	push ebp
	mov ebp, esp
	xor edx, edx					; индекс текущего элемента

_loop:
	; Условие выхода из цикла
	cmp dl, byte [len]
	je _finalize

	mov bl, byte [nums + edx]		; получение текущего числа
	cmp bl, 0
	jl _negative_logic
	jmp _positive_logic

_negative_logic:
	sar bl, 2						; арифметический сдвиг вправо
	mov byte [nums + edx], bl		; перезапись числа в массиве nums
	inc dl
	jmp _loop

_positive_logic:
	and bl, 0xee					; обнуление [0] и [4] бита.
	mov byte [nums + edx], bl		; перезапись числа в массиве nums
	inc dl
	jmp _loop

_finalize:
	xor edx, edx					; обнуление индекса элемента

_print_loop:
	; Условие выхода из цикла
	cmp dl, byte [len]
	je _exit

	; movzx (zero-extends) добивает значение незначащими нулями,
	; чтобы оно стало того же размера, что и регистр.
	; Ее приходится использовать,
	; потому что al нельзя запушить в стек
	movzx eax, byte [nums + edx]
	push edx
	push eax
	push msg
	call printf

	; Очистка стека для функции printf
	pop eax
	pop eax
	pop edx

	inc dl
	jmp _print_loop

_exit:
	; Восстановление стека
	mov esp, ebp
	pop ebp
	ret
