#!/bin/bash

opcion=0
while [ $opcion -ne 3 ]
do
	echo "1) Moverse del directorio"
	echo "2) Mostrar lo que hay en el directorio"
	echo "3) Mostrar en que directorio esta el usuario"

	read -p "Elige [1-3]: " opcion
	case $opcion in

		1) read -p "Dime a q directorio te quieres mover: " directorio
		cd $directorio
		;;

		2) ls
		;;

		3) pwd
	;;

	esac
done





