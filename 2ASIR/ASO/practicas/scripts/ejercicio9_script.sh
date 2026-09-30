#!/bin/bash

#VARIABLES
option=0

#PROGRAMA PRINCIPAL
while [ $option -ne 4 ]
do
	echo "####################################"
	echo "############### MENU ###############"
	echo "####################################"
	echo "1) Fecha de hoy"
	echo "2) Usuarios conectados"
	echo "3) Directorio actual"
	echo "4) Salir"
	echo "####################################"
	echo 

	read -p "Introduzca la opción deseada: " option
	echo
	echo "Ha introducido la opción $option"	
	echo 


	case $option in
		1)
			date
		;;
		
		2)
			users
		;;
		
		3)
			pwd
		;;
		
		4) 
			echo "Hasta luego"
			exit
		;;
		
		*)
			echo "Esa opción no es válida"
		;;
	esac
	
	echo
	read -p "Presione ENTER para continuar..." 
done

