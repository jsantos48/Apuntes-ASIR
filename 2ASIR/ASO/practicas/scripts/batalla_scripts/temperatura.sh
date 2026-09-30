#!/bin/bash

#PROGRAMA PRINCIPAL
read -p "Introduzca un número para la temperatura: " temp

if [ $temp -lt 10 ] 2>/dev/null
then
	echo "Hace frío"
elif [ $temp -ge 10 ] 2>/dev/null && [ $temp -le 25 ] 2>/dev/null
then
	echo "La temperatura es agradable"
elif [ $temp -gt 25 ] 2>/dev/null
then
	echo "Hace calor"
else
	echo "Debes de introducir un número"
fi

