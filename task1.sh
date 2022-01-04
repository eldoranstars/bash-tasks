# Написать скрипт, который спросит пользователя ввести имя папки, которую затем скрипт создаст. 
# Затем сменить рабочую директорию на новую папку и вывести сообщение о текущей папке с помощью команды pwd. 
# Далее создать новый файл и записать в него что-нибудь с помощью перенаправления (> или >>). 
# Показать пользователю содержимое файла.

echo '##Now input DirectoryName:'
read DirectoryName
mkdir $DirectoryName
echo '##Directory' \'$DirectoryName\' 'was created' 
cd ./$DirectoryName
echo '##Current directory was changed:' 
pwd
touch $DirectoryName
echo '##Writing file' \'$DirectoryName\'
echo 'Hello Victor'> $DirectoryName
echo '##Reading file' \'$DirectoryName\'
cat $DirectoryName
cd ..
rm -r $DirectoryName
