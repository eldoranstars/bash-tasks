# Написать скрипт, который имеет один аргумент – имя папки. И затем он выводит её имя. 
# Также надо обработать ошибку, если аргумента нет и вывести соответствующее сообщение.

if [ -n “$1” ];
	then
		echo $1
	else
		echo “No parameters found”
fi
