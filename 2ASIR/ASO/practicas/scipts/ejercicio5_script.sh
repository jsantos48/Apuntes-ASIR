#!/bin/bash

#VARIABLES 
contador=0

#PROGRAMA PRINCIPAL
read -p "Introduzca un número para la suma (introduzca 'fin' para mostrar el resultado): " num

while [ "$num" != "fin" ]
do
	contador=$(($contador + $num))
	read -p "Introduzca un número para la suma (introduzca 'fin' para mostrar el resultado): " num
done

echo "El resultado final es: $contador" 

