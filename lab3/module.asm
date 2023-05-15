global solution

; int solution(int**, int, int)
solution:
	; Сохранение значений регистров, чтобы после выхода из функции ничего не сломалось
	push ebp
	mov ebp, esp
	push ebx
	push ecx
	push edx

	xor eax, eax			; вспомогательный регистр
	xor ebx, ebx			; итератор по i
	xor ecx, ecx			; итератор по j

	push ebx				; заносим значение итератора i в стек
	push ecx				; заносим значение итератора j в стек
	push eax				; заносим значение суммы в стек (изначально 0)
	push dword [ebp + 8]	; заносим текущий адрес строки в стек

; Проход по строкам
_outerLoop:
	; Условие выхода из цикла
	mov ebx, dword [esp + 12]
	cmp ebx, dword [ebp + 12]
	je _exit
	
	jmp _innerLoop

; Проход по столбцам
_innerLoop:
	; Условие выхода из цикла
	mov ecx, dword [esp + 8]
	cmp ecx, dword [ebp + 16]
	
	je _continue

	mov eax, dword [esp]			; eax = CLAddrAddr, где CLAddrAddr - адрес адрсеа начала строки			
	mov eax, dword [eax]			; eax = *CLAddrAddr = CLAddr - адрес начала строки
	mov eax, dword [eax + ecx*4]	; eax = matrix[ebx][ecx]
	mul eax							; eax = eax * eax
	add dword [esp + 4], eax		; накапливаем сумму в стеке
	inc dword [esp + 8]				; инкрементим счетчик

	jmp _innerLoop

; Продолжение цикла прохода по строкам
_continue:
	mov dword [esp + 8], 0		; обнуление счетчика
	inc dword [esp + 12]		; переход к новой строке (индекс)
	add dword [esp], 4			; переход к новой строке (адрес адреса начала) ; 4 байта - размер указателя на указатель

	jmp _outerLoop

; Выход из программы
_exit:
	; Извлечение CLAddrAddr - всё равно, куда выгружать
	pop edx

	; Извлечение S (накопленной суммы). Выгружается именно сюда, потому
	; что по умолчанию результат работы функции выгружается из регистра eax
	pop eax

	; Извлечение значений итераторов - всё равно, куда выгружать
	pop ecx
	pop ebx

	; Восстановление значений регистров - важен порядок
	pop edx
	pop ecx
	pop ebx
	
	; Восстановление указателя на стек
	mov esp, ebp
	pop ebp
	
	ret
