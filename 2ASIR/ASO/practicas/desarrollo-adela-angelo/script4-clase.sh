#!/bin/bash


suma=0
resta=0
multiplicacion=1

for i in 1 2 3 4 5
do
	read -p "Introduce el número $i: " numero

	
	if [ $numero -gt 0 ]
	then
		echo "El número es positivo"
	elif [ $numero -lt 0 ]
	then
		echo "El número es negativo"
	else
		echo "El número es cero"
	fi

	
	if [ $((numero % 2)) -eq 0 ]
	then
		echo "El número es par"
	else
		echo "El número es impar"
	fi

	
	suma=$((suma + numero))
	resta=$((resta - numero))
	multiplicacion=$((multiplicacion * numero))

	echo ""
done


echo "Suma: $suma"
echo "Resta: $resta"
echo "Multiplicación: $multiplicacion"


if [ $suma -gt 0 ]
then
	echo "La suma es mayor que cero"
elif [ $suma -lt 0 ]
then
	echo "La suma es menor que cero"
else
	echo "La suma es igual a cero"
fi


