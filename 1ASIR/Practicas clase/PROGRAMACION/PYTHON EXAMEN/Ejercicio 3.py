def elegir_color():
    colores = ["Rojo", "Azul", "Verde", "Amarillo", "Violeta"]

    print("Colores disponibles: ¿Cuál quieres ver?")

    try:
        indice = int(input("Introduce un número de índice (0-4): "))

        color_elegido = colores[indice]
        print(f"¡Buena elección! El color en el índice {indice} es el {color_elegido}.")

    except IndexError:
        print(
            f"El índice está fuera de rango. Recuerda que la lista solo tiene {len(colores)} elementos (índices del 0 al 4).")

    except ValueError:
        print("Eso no es un número válido. Por favor, ingresa un número entero.")

elegir_color()