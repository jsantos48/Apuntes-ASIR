precios = {"cafe": 1.50, "tostada": 2.20, "zumo": 3.00}
# 1. Usamos LISTA [] para no perder el segundo café
pedidos_mesa = ["cafe", "tostada", "zumo", "bollo", "15", "cafe"]


# Lo que hay dentro del parentesis de la variable, será sustituido.
def calcular_cuenta(lista_pedidos):
    total = 0

    for pedido in lista_pedidos:
        print(f"Procesando: {pedido}...")

        try:
            # 2. Comprobamos si es un número
            if pedido.isdigit():
                raise ValueError(f"Formato incorrecto: '{pedido}' no es un producto.")

            # 3. Buscamos el precio usando la variable del bucle: 'pedido'
            precio_producto = precios[pedido]
            total += precio_producto

        except KeyError:
            print(f"ERROR: '{pedido}' no está en el catálogo.")

        except ValueError as e:
            print(f"ERROR: {e}")

    return total

if __name__ == "__main__":
    resultado = calcular_cuenta(pedidos_mesa)
    print(f"\n--- CUENTA TOTAL: {resultado}€ ---")