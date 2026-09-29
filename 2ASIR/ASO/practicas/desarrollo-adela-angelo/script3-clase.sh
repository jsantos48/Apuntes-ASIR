#!/bin/bash


resultado=1

while true
do
    read -p "Introduce un número (o esternocleidomastoideo para terminar): " numero

    if [ "$numero" = "esternocleidomastoideo" ]
    then
        break
    fi

    resultado=$((resultado * numero))
done

echo "El resultado de la multiplicación es: $resultado"
