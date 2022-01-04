# Написать скрипт, который будет спрашивать пользователя число (1, 2 или 3) и будет вызывать функцию с соответствующим числом в имени. 
# Функция выводит сообщение, содержащее её номер, например «This message is from function 3»

echo 'input number from 1 to 3:'
read Number
while [ $Number -ne 1 ] && [ $Number -ne 2 ] && [ $Number -ne 3 ]; do
	echo 'wrong number, try again:'
	read Number
done
function echoprint {
	echo "This message is from function $Number"
}
echoprint
