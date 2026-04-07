def fraccion(cadena):
    try:
        if cadena.count('/') != 1:
            return 0
        partes = cadena.split('/')

        numerador = int(partes[0])
        denominador = int(partes[1])

        return numerador / denominador

    except (ValueError, ZeroDivisionError):
        return 0


texto_usuario = input("Introduce la fracción (ejemplo: 25/10): ")

resultado = fraccion(texto_usuario)

print(f"Resultado: {resultado}")