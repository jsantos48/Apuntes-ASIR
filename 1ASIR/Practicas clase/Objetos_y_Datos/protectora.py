from abc import ABCMeta, abstractmethod


class Animal(metaclass=ABCMeta):
    def __init__(self, anio_nacimiento, nombre=None):
        self.anio_nacimiento = anio_nacimiento
        self.nombre = nombre


class AnimalVacunado(Animal):
    def __init__(self, anio_nacimiento, esta_vacunado, nombre=None):
        super().__init__(anio_nacimiento, nombre)
        self.esta_vacunado = esta_vacunado


class Perro(AnimalVacunado):
    pass


class Gato(AnimalVacunado):
    pass


class Tortuga(Animal):
    pass


class Cliente:
    def __init__(self, nombre, apellido, edad, telefono):
        self.nombre = nombre
        self.apellido = apellido
        self.edad = edad
        self.telefono = telefono
        self.animales_adoptados = []

    def adoptar_animal(self, animal):
        if len(self.animales_adoptados) >= 4:
            return False

        perros = [a for a in self.animales_adoptados if isinstance(a, Perro)]
        gatos = [a for a in self.animales_adoptados if isinstance(a, Gato)]
        tortugas = [a for a in self.animales_adoptados if isinstance(a, Tortuga)]

        if isinstance(animal, Perro) and len(perros) < 2:
            self.animales_adoptados.append(animal)
            return True
        elif isinstance(animal, Gato) and len(gatos) < 3:
            self.animales_adoptados.append(animal)
            return True
        elif isinstance(animal, Tortuga) and len(tortugas) < 1:
            self.animales_adoptados.append(animal)
            return True

        return False

    def listar_adoptados(self):
        return self.animales_adoptados


class Protectora:
    def __init__(self):
        self.animales_disponibles = []

    def añadir_animal(self, animal):
        self.animales_disponibles.append(animal)

    def procesar_adopcion(self, cliente, animal):
        if animal in self.animales_disponibles:
            if cliente.adoptar_animal(animal):
                self.animales_disponibles.remove(animal)
                return True
        return False

    def listar_disponibles(self):
        return self.animales_disponibles


mi_protectora = Protectora()
mi_protectora.añadir_animal(Perro(2020, True, "Bobby"))
mi_protectora.añadir_animal(Perro(2021, False, "Rex"))
mi_protectora.añadir_animal(Gato(2019, True, "Michi"))
mi_protectora.añadir_animal(Tortuga(1990, "Rayo"))

juan = Cliente("Juan", "Perez", 30, "600000000")

print(f"Disponibles antes: {len(mi_protectora.listar_disponibles())}")
mi_protectora.procesar_adopcion(juan, mi_protectora.listar_disponibles()[0])
print(f"Adoptados por Juan: {len(juan.listar_adoptados())}")
print(f"Disponibles después: {len(mi_protectora.listar_disponibles())}")