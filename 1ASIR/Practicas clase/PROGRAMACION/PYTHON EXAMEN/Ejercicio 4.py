def cajero_automatico():
    saldo = 1000

    print(f"Bienvenido. Su saldo actual es de: ${saldo}")

    try:
        monto_str = input("¿Cuánto dinero desea retirar?: ")
        monto = float(monto_str)

        if monto > saldo:
            raise Exception("Saldo insuficiente para realizar esta operación.")

        if monto < 0:
            raise Exception("No puedes retirar cantidades negativas.")

        saldo -= monto

    except ValueError:
        print("Error: Por favor, ingrese un monto numérico válido.")

    except Exception as e:
        print(f"Operación cancelada: {e}")

    else:
        print(f"Retiro exitoso. Su nuevo saldo es: ${saldo}")

    finally:
        print("Gracias por usar nuestro cajero. ¡Que tenga un buen día!")

cajero_automatico()