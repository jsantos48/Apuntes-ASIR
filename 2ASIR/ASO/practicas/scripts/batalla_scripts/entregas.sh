#!/bin/bash
clear
if [ $# -ne 1 ]
then
	
	echo "Debes introducir el directorio y su ruta completa(junto con el script al ejecutarse)"
	echo "Recuerda poner la ruta entera para no obtener un error(/home/*usuario*/...)"
	exit 1
fi

if ! [ -d $1 ]
then
	echo "El directorio adjuntado no existe, comprueba si lo has introducido bien"
	exit 2
fi

cuenta=$(ls | wc -l)

 echo "El directorio contiene $cuenta archivos"
 
 if  [ $cuenta -gt 5 ]
 then
 	echo "ADVERENCIA: El directorio contiene más de 5 archivos"
 	exit 2
 fi
 
 
 
