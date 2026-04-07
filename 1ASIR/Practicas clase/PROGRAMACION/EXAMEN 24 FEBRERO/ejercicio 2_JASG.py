def calcular_total_pedidos(precio_base, impuesto=0.21 , **kwargs):
    for clave in kwargs:
        descuento = kwargs[clave]
        precio_base= precio_base - descuento


    total_con_impuesto = precio_base * (1 + impuesto)
    return total_con_impuesto

resultado = calcular_total_pedidos(100,bienvenida=10, fiel=12, descuento_discapacidad=20)

print(f'Resultado: {resultado}')