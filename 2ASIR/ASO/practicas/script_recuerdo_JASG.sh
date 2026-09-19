#!/bin/bash

#COMPROBACIONES
if [ "$UID" -ne 0 ]
then
	echo "ERROR, debe de ejecutar este programa como usuario root"
	exit 1
fi

#PROGRAMA PRINCIPAL
echo "############################################################################"
echo "En este programa se ejecutarán señales kill para procesos en ejecución.
Aquellos que no se encuentren en ejecución, no servirán para este programa."
echo "############################################################################"
sleep 5

echo

read -p "Introduzca el nombre del programa al que desea mandar la señal: " program

PID=$(pidof "$program")

if [ -n "$PID" ] 
then 
	read -p "Que señal le gustaría mandar [1-64]: " senial

	if [ "$senial" -ge 1 ] 2>/dev/null && [ "$senial" -le 64 ] 2>/dev/null
	then 
		kill -"$senial" $PID 2>/dev/null

		if [ $? -ne 0 ]
		then 
			echo "ERROR, algo ha salido mal"
			exit 4
		else
			echo -n "Ejecutando"
				for i in {1..3}
				do
   					sleep 0.5
    					echo -n "."
				done
			echo
			echo
			echo "La señal se ha enviado correctamente"
		fi
	else
		echo "Esa señal no es válida, recuerde que los valores son del 1 al 64, ambos incluidos"
		exit 3
	fi
else
	echo "ERROR, ese programa no está en ejecución o no existe"
	exit 2
fi
