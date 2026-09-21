#!/bin/bash

#VARIABLES
CONTADOR=1

#PROGRAMA PRINCIPAL
read -p "Introduzca un número para su multiplicación [for]: " mult1

for i in {1..10}
do
	echo "$mult1 x $i = $(($mult1 * $i))"
done

echo

read -p "Introduzca un número para su multiplicación [while]: " mult2

while [ $CONTADOR -le 10 ]
do
	echo "$mult2 x $CONTADOR = $(($mult2 * $CONTADOR))"
	CONTADOR=$((CONTADOR + 1))
done
