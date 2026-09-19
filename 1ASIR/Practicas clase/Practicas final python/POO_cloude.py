class Vehiculo:
    def __init__(self, marca, modelo, anio, kilometros):
        if kilometros < 0:
            raise ValueError("Kilometraje erroneo")
        self.marca = marca
        self.modelo = modelo
        self.anio = anio
        self.kilometros = kilometros
    def __str__(self):
        return f"El siguiente vehículo tiene de características: \n\tMarca: {self.marca}" \
               f"\n\tModelo:{self.modelo} \n\tAño: {self.anio} \n\tKilometros: {self.kilometros}"
class Flota:
    def __init__(self, nombre, *vehiculos):
        if len(vehiculos) < 1 or len(vehiculos) > 5:
            raise IndexError("Cantidad de vehículos incorrecta")
        self.nombre = nombre
        self.vehiculos = []
        for vehiculo in vehiculos:
            self.vehiculos.append(vehiculo)
    def kilometraje_total(self):
        total = 0
        for v in self.vehiculos:
            total += v.kilometros
        return total
    def __str__(self):
        flota = (f"La flota de dichos vehículos es: \n\tEmpresa: {self.nombre} \n")
        for vehiculo in self.vehiculos:
            flota += f"{vehiculo}\n"
        return flota
vehiculo = Vehiculo("Lamborghini", "Temerario", 2025, 20)
flota = Flota("Gilberto S.A", vehiculo, vehiculo, vehiculo)
print(flota)
print("Kilometraje total:", flota.kilometraje_total())