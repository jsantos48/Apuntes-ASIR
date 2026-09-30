#!/bin/bash 

#PROGRAMA PRINCPAL
for i in {1..3}
do 
	read -p "Introduzca la contraseña: " password

	if [ "$password" == "1234" ]
	then 
		echo "Contraseña correcta"
		echo "Acceso permitido"
		exit 1
	else
		echo "Contraseña incorrecta"
	fi
done

	echo "Acceso bloqueado"
