#!/bin/bash

#VARIABLE
contador=1

#PROGRAMA PRINCIPAL
read -p "Introduzca un número: " num
if [[ ! "$num" =~ ^?[0-9]+$ ]]
then
	for i in $(seq $num -1 1) 
	do
		contador=$((contador * i))
	done
	
	echo "El factorial de $num es $contador"
else
	echo "Solo se aceptan números positivos"
fi
