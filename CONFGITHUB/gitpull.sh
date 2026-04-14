#!/bin/bash

ROJO='\033[0;31m'
VERDE='\033[0;32m'
NC='\033[0m'

url="https://github.com/jsantos48/Apuntes-ASIR.git"
repositorio=$(basename "$url" .git)

# DETECCIÓN AUTOMÁTICA DE RUTA
ruta=$(dirname "$(readlink -f "$0")")/..
cd "$ruta"

if [ -d .git ]
then
	git pull
	if [ $? -eq 0 ]
	then
		echo ''
		echo -e "${VERDE}✅ Repositorio actualizado correctamente.${NC}"
	else
		echo ''
		echo -e "${ROJO}❌ Error al actualizar el Repositorio.${NC}"
	fi
else
    echo -e "${ROJO}❌ Error: No se encontró la carpeta .git${NC}"
	exit 1
fi

read -p "Pulse ENTER para continuar..." cont
