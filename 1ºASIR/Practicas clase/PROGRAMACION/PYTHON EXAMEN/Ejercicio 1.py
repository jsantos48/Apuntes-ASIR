def realizar_division():
    try:
        numerador = float(input("Ingresa el primer número (dividendo): "))
        denominador = float(input("Ingresa el segundo número (divisor): "))

        resultado = numerador / denominador
        print(f"El resultado de {numerador} / {denominador} es: {resultado}")

    except ZeroDivisionError:
        print("Error: No se puede dividir entre cero. El universo colapsaría.")

    except ValueError:
        print("Error: Debes ingresar números válidos, no letras ni caracteres especiales.")

    except Exception as e:
        print(f"Ha ocurrido un error inesperado: {e}")

realizar_division()