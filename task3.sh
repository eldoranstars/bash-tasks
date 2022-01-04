# Используя выражение case, написать скрипт, который будет получать на вход номер месяца и выводить его имя.

echo 'now input number of month:'
read Number
while ! [[ $Number -ge 1 && $Number -le 12 ]]; do
	echo 'wrong number, try again:'
	read Number
done
case $Number in
1) echo 'Jan';;
2) echo 'Feb';;
3) echo 'Mar';;
4) echo 'Apr';;
5) echo 'May';;
6) echo 'Jun';;
7) echo 'Jul';;
8) echo 'Aug';;
9) echo 'Sep';;
10) echo 'Okt';;
11) echo 'Nov';;
12) echo 'Dec';;
esac
