#!/bin/bash
# VALIDACION
if [ ! -w $0 ]
then
	echo "El archivo no es Editable"
	exit 1
fi

#PROGRAMA PRINCIPAL

if [ $# -ne 1 ]
then
	echo "Hola mundo"
else
	echo "Hola $1"
fi
