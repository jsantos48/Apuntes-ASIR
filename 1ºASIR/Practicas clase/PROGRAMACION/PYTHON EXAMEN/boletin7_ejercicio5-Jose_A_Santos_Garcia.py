def comprobar_fecha(fecha):
    dia, mes, anio = fecha.split('/')
    dia = int(dia)
    mes = int(mes)
    anio = int(anio)
    if mes > 12 or mes < 1:
        return False
    if dia > 31 or dia < 1:
        return False
    if anio < 1:
        return False
    if mes == 2:
        if bisiesto(anio) and dia <=29:
            return True
        elif not bisiesto(anio) and dia <= 28:
            return True
    if mes in (4,6,9,11) and dia <= 30:
        return True
    if mes in (1,3,5,7,8,10,12) and dia <= 31:
        return True
    else:
        return False

def bisiesto(anio):
    return anio % 4 == 0 and anio % 100 != 0 or anio % 400 == 0

print("\n------ CASOS DE ÉXITO ------")
print(f"Bisiesto correcto (29 feb 2024):            {comprobar_fecha('29/02/2024')}")
print(f"Mes de 30 días (30 abr 2023):               {comprobar_fecha('30/04/2023')}")
print(f"Mes de 31 días (31 ago 2023):               {comprobar_fecha('31/08/2023')}")
print(f"Día normal (15 jun 2022:                    {comprobar_fecha('15/06/2022')}")

print("\n------ CASOS DE ERROR ------")
print(f"Febrero no bisiesto (29 feb 2023):          {comprobar_fecha('29/02/2023')}")
print(f"Día 31 en mes de 30 (31 jun 2023):          {comprobar_fecha('31/06/2023')}")
print(f"Mes inexistente (13):                       {comprobar_fecha('10/13/2023')}")
print(f"Día inexistente (32):                       {comprobar_fecha('32/01/2023')}")