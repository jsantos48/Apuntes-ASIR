#!/bin/bash

#PROGRAMA PRINCIPAL
read -p "Introduzca el nombre del archivo: " ruta
if [ -e "$ruta" ]
then 
	echo "El archivo introducido existe"
	echo
	
	if [ -f "$ruta" ]
	then 
		echo "El archivo introducido es un archivo regular"
		echo

		if [ -w "$ruta" ]
		then 
			echo "El archivo introducido tiene permisos de lectura"
		else
			echo "El archivo introducido NO tiene permisos de lectura"
		fi
	else
		echo "El archivo introducido NO es un archivo regular"
	fi
else
	echo "El archivo introducido NO existe"
fi

