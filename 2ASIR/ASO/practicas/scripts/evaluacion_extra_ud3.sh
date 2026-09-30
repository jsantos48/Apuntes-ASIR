#!/bin/bash

cd

#VARIABLES
encontrar_backup=$(find ~ -name "backup" 2>/dev/null) 
encontrar_archivo=$(find ~ -name $1 2>/dev/null)  

#COMPROBACIONES
if [ $# -ne 1 ]
then
	echo "Se debe de introducir al menos un archivo: ./script.sh archivo"
fi

if [ ! -d "backup" ]
then
	mkdir backup 2>/dev/null
	echo "La carpeta backup no existía, se ha creado correctamente"
fi

#PROGRAMA PRINCIPAL
if [ -f $1 ]
then
	mv "$encontrar_archivo" "$encontrar_backup" 2>/dev/null
else 
	touch "$encontrar_backup/$1" 2>/dev/null
	if [ $? -ne 0 ]
	then 
		echo "Algo ha salido mal"
	fi
fi


