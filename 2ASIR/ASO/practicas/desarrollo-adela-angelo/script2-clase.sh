#!/bin/bash


read -p "Introduce una ruta de archivo o directorio. Ejemplo: /home/usuario/Escritorio/: " ruta

if [ -e "$ruta" ]
then
	echo "Existe"
else
	echo "No existe"
	exit 1
fi

if [ -f "$ruta" ]
then
	echo "Es un archivo regular"

	if [ -s "$ruta" ]
	then
		echo "El archivo tiene contenido"
	else
		echo "El archivo está vacío"
	fi

else
	echo "No es un archivo"

	if [ -d "$ruta" ]
	then
		echo "Es un directorio"

		if [ -z "$(ls -A "$ruta")" ]
		then
			echo "El directorio está vacío"
		else
			echo "El directorio tiene contenido"
		fi
	fi
fi

echo "La ubicación es: $ruta"



