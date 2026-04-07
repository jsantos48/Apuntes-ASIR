#!/bin/bash

url="https://github.com/jsantos48/Apuntes-ASIR.git"
repositorio=$(basename "$url" .git)

# DETECCIÓN AUTOMÁTICA DE RUTA (Funciona en Clase y Casa)
# Obtiene la carpeta donde está el script y sube un nivel
ruta=$(dirname "$(readlink -f "$0")")/..
cd "$ruta"

if [ -d .git ]
then
	echo ''
	git add .
	git commit -m '⬆️ ASIR: Subida de nuevos materiales y prácticas'
	git push
	if [ $? -eq 0 ]
	then
		echo ''
		echo 'Cambios publicados correctamente'
	else
		echo ''
		echo 'ERROR al publicar los cambios'
	fi
else
    echo "ERROR: No se detecta el repositorio Git en $ruta"
	exit 1
fi
