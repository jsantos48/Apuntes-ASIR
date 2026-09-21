#!/bin/bash

# Verificar que se pasa un archivo CSV como parámetro
if [ -z "$1" ]
then
    echo "Uso: $0 <archivo.csv>"
    exit 1
fi

ARCHIVO_CSV="$1"

# Comprobar que el archivo existe
if [ ! -f "$ARCHIVO_CSV" ] 
then
    echo "ERROR: El archivo '$ARCHIVO_CSV' no existe."
    exit 1
fi

# Procesar cada línea del CSV
while IFS=',' read -r programa valor_nice || [ -n "$programa" ]
do
    # Eliminar posibles espacios o retornos de carro en blanco
    programa=$(echo "$programa" | tr -d ' ')
    valor_nice=$(echo "$valor_nice" | tr -d ' ')

    # Ignorar líneas vacías o encabezados no válidos
    if [ -z "$programa" ] || [ -z "$valor_nice" ]
    then
        continue
    fi

    # Buscar el PID del proceso exacto
    pid=$(pgrep -x "$programa" | head -n 1)

    # Caso A: El proceso existe
    if [ -n "$pid" ]
    then
        if renice -n "$valor_nice" -p "$pid" > /dev/null 2>&1
    then
            echo "Proceso $programa ($pid) - nice cambiado a $valor_nice"
        else
            echo "Proceso $programa - ERROR: No se pudo cambiar el valor nice"
        fi

    # Caso B: El proceso NO existe
    else
        # Iniciar la instancia en segundo plano con la prioridad indicada
        nice -n "$valor_nice" "$programa" > /dev/null 2>&1 &
        nuevo_pid=$!

        # Verificar si el proceso realmente arrancó
        sleep 0.5
        if ps -p "$nuevo_pid" > /dev/null 2>&1
        then
            echo "Proceso $programa ($nuevo_pid) - nuevo proceso con nice $valor_nice"
        else
            echo "Proceso $programa - ERROR: No se pudo ejecutar el programa"
        fi
    fi

done < "$ARCHIVO_CSV"
