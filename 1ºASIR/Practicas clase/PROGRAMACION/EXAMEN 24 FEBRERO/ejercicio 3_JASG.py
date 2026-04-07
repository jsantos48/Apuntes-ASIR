def validar_perfil(username,password,edad):
    try:
        if int(edad)<18:
            raise ValueError("Debes ser mayor de edad")
        if len(password)<8:
            raise ValueError("La contraseña es demasiado corta, min 8 caracteres")
        if username.isspace():
            raise NameError("Nombre de usuario no valido")
        return True
    except NameError as err:
        print(err)
    except ValueError as passwd:
        print(passwd)
    except ValueError as edad:
        print(edad)



intentos = 3
while intentos >0:
    try:
        u = input("Ingrese su usuario: ")
        p = input("Ingrese su password: ")
        e = input("Ingrese su edad: ")

        if validar_perfil(u,p,e):
            print("Usuario registrado correctamente")
            break
    except ValueError as err:
        print(err)
    except NameError as err:
        print(err)

    finally:
        print("Fin del intento de registro")
        intentos -= 1

        if intentos == 0:
            print("Error al registrar al usuario")