Задание:
Написать программу, которая заполняет матрицу числовыми значениями
и вычисляет сумму квадратов всех ее элементов.
При этом подсчет суммы должен быть оформлен в виде модуля,
написанного на языке Ассемблера (nasm).

Команды для сборки:
[nasm -f elf -o nasm.o main.asm]
[g++ -m32 -o main main.cpp nasm.o]
