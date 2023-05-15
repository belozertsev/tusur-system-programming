; Дан массив из 9 знаковых чисел. Биты отрицательных чисел сдвинуть 
; арифметчиски вправо на 2 разряда, а биты [0] и [4] положительных
; чисел сбросить

; Команды для сборки
; nasm -f elf -o <объектный файл> main.asm
; gcc -m32 -no-pie -o <исполняемый файл> <объектный файл>

section .data
	nums: db -1, 2, -3, 4, -5, 6, -7, 16, -9
	len: db 9
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
	xor edx, edx

_print_loop:
	; Условие выхода из цикла
	cmp dl, byte [len]
	je _exit

	movzx eax, byte [nums + edx]		; movzx - zeros extend
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