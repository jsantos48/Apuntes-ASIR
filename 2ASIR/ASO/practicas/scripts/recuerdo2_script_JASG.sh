#!/bin/bash

if [ -z "$1" ]
then
    echo "Como usar: $0 <archivo.csv>"
    exit 1
fi

ARCHIVO_CSV="$1"

if [ ! -f "$ARCHIVO_CSV" ] 
then
    echo "ERROR: El archivo '$ARCHIVO_CSV' no existe."
    exit 1
fi

while IFS=',' read -r programa valor_nice || [ -n "$programa" ]
do 
    programa=$(echo "$programa" | tr -d ' ')
    valor_nice=$(echo "$valor_nice" | tr -d ' ')

    if [ -z "$programa" ] || [ -z "$valor_nice" ]
    then
        continue
    fi

    pid=$(pgrep -x "$programa" | head -n 1)

    if [ -n "$pid" ]
    then
        if renice -n "$valor_nice" -p "$pid" > /dev/null 2>&1; then
            echo "Proceso $programa ($pid) - nice cambiado a $valor_nice"
        else
            echo "Proceso $programa - ERROR: No se pudo cambiar el valor nice"
        fi

    else
        nice -n "$valor_nice" "$programa" > /dev/null 2>&1 &
        nuevo_pid=$!

        sleep 0.5
        if ps -p "$nuevo_pid" > /dev/null 2>&1
        then
            echo "Proceso $programa ($nuevo_pid) - nuevo proceso con nice $valor_nice"
        else
            echo "Proceso $programa - ERROR: No se pudo ejecutar el programa"
        fi
    fi

done < "$ARCHIVO_CSV"
