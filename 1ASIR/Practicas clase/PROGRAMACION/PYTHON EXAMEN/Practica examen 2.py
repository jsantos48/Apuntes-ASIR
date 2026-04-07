inventario = {"manzanas": 50, "peras": 20, "naranjas": 10}

def actualizar_stock():

    try:
        producto = input(f"¿Que producto desea comprar?: ").lower()
        cantidad = int(input("¿Que cantidad desea comprar?: "))

        disponible = inventario[producto]
        if cantidad > disponible:
            raise Exception("\nERROR: Stock insuficiente")

        inventario[producto] -= cantidad
        print(f"\nVenta realizada. Quedan {inventario[producto]} {producto}.")

    except KeyError:
        print(f"\nError: El producto no está en el catálogo")

    except ValueError:
        print("\nERROR: Se requiere un número")

    except Exception as e:
        print(f"{e}")

    finally:
        print("\nConsulta de inventario finalizada")

actualizar_stock()






