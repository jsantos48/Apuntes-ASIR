def fraccion(cadena):
    """
    Esta función recibe la cadena completa, la procesa y devuelve el decimal.
    Si algo falla, devuelve 0.
    """
    try:
        # 1. Verificamos que el usuario haya puesto exactamente una barra '/'
        if cadena.count('/') != 1:
            return 0

        # 2. Dividimos la cadena en dos partes usando la barra como separador
        partes = cadena.split('/')

        # 3. Convertimos cada parte a número entero
        numerador = int(partes[0])
        denominador = int(partes[1])

        # 4. Realizamos la división y devolvemos el resultado
        return numerador / denominador

    except (ValueError, ZeroDivisionError):
        # Si no son números o el denominador es 0, devolvemos 0 según el ejercicio
        return 0


# --- Bloque principal donde TÚ introduces la cadena ---
texto_usuario = input("Introduce la fracción (ejemplo: 25/10): ")

# Llamamos a la función con lo que escribiste
resultado = fraccion(texto_usuario)

print(f"Resultado: {resultado}")