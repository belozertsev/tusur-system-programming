#!/bin/bash

# Вывод информации об авторе, названии программы и ее кратком описании
echo "Автор: Эдуард Белозерцев"
echo "Название программы: iso-checker"
echo "Описание: Это скрипт для проверки или имплантации контрольной суммы iso-образа"

# Бесконечный цикл для выполнения задачи по проверке образа
while true; do

	# Счетчик ошибок
	is_error_happened=0

	# Запрос пути к образу CD-диска
	read -p "Введите путь к образу CD-диска: " iso_file 2>&1

	# Проверка существования указанного файла
	if [ -f "$iso_file" ]; then

		# Если сумма уже имплантирована
		if checkisomd5 --md5sumonly "$iso_file" &>/dev/zero; then
			checkisomd5 --verbose "$iso_file" 2>&1 |
				awk 'NR==1 {print "Имплантированная md5-сумма: " $2} \
			NR==7 {sub(/\./, "", $9); print "Проверка целостности: " $9}'

		# Если не имплантирована
		else
			read -p "Контрольная сумма пока не имплантирована. Имплантировать (y/n)? " should_implant 2>&1
			if [ "$should_implant" == "y" ]; then
				implantisomd5 "$iso_file" |
					awk 'NR==2 {print "Имплантирована сумма: " $3}'
			fi
		fi

	# Случай отсутствия файла
	else
		echo "Ошибка: файл $iso_file не существует" >&2
		is_error_happened=1
	fi

	# Запрос продолжения работы или выхода из цикла
	read -p "Желаете продолжить (y/n)? " should_continue 2>&1
	case "$should_continue" in y | Y) continue ;; *) break ;; esac

done

echo "Работа iso-checker завершена!"

# Завершение с кодом возврата
if [ $is_error_happened == 1 ]; then
	exit 1
else
	exit 0
fi
