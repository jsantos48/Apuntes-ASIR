def fraccion(cadena = ""):
    if cadena.count("/") != 1:
        return 0.0
    numerador, denominador = cadena.split("/")
    if not numerador.isdecimal() or not denominador.isdecimal():
        return 0.0
    return int(numerador)/int(denominador)


def main ():
    print(fraccion("1000000"))
    print(fraccion("//10"))
    print(fraccion("10/*"))
    print(fraccion("a/10"))
    print(fraccion("25/10"))
    print(fraccion("45/53"))
    print(fraccion("10/10"))


if __name__ == "__main__":
    main()