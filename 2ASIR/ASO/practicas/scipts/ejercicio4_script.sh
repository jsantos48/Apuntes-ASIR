#!/bin/bash

#PROGRAMA PRINCIPAL
read -p "Introduzca el número para la cuenta atrás: " desp1

contador=$desp1

while [ $contador -ge 1 ]
do
	echo "$contador"
	sleep 1
	contador=$((contador - 1))
	if [ $contador -eq 0 ]
	then
		echo "Despegue!!"
	fi
done

