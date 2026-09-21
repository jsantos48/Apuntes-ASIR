#!/bin/bash
#VALIDACIONES
if [ $# -ne 1 ]
then 
	echo "Uso: $0 <numeros>"
	exit 1
fi

#PROGRAMA PRINCIPAL
if [[ ! "$1" =~ ^-?[0-9]+$ ]]
then 
	echo "Error: '$1' no es un número entero"
	exit 2
fi

if (( $1 % 2 == 0 ))
then
	echo "$1 es par"
else
	echo "$1 es impar"
fi

