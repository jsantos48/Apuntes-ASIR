#!/bin/bash

#COMPROBACIONES
if [ $# -ne 1 ]
then 
	echo "Solo se debe de introducir un único parámetro: ./script.sh archivo"
fi

if [ ! -d $1 ]
then
	echo "La ruta indicada no existe"
fi

#PROGRAMA PRINCIPAL
echo "#################################"
echo "############## MENU #############"
echo "#################################"
echo
echo "1) Mostrar archivos de un directorio"
echo "2) Buscar un archivo por su nombre"
echo "3) "
echo "4) Mostrar el archivo de mayor tamaño"
echo "5) Crear resumen informe_descargas.txt"
echo "6) Salir"
