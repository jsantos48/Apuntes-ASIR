# Queremos definir una clase llamada libro que nos permita almacenar información sobre libros.
from prompt_toolkit.key_binding.bindings.named_commands import self_insert


# Libro: título, autor, páginas, editorial, leído o no leído.

# Definimos una clase:

class Autor:
    def __init__(self,nombre,apellidos,genero):
        self.nombre = nombre
        self.apellidos = apellidos
        self.genero = genero
    def describir_autor(self):
        return self.nombre.title() + " " + self.apellidos.title() + " genero: " + self.genero

class Libro:
    def __init__(self,titulo,autor:Autor,paginas:int,editorial,leido = False):
        self.titulo = titulo
        self.autor = autor
        self.paginas = paginas
        self.editorial = editorial
        self.leido = leido
    def describir_libro(self):
        return "El titulo es: " + self.titulo + "el autor es" + self.autor + "leido: " + self.leido
        str(self.autor.describir()) + " leido: " + str(self.leido)
    def marcar_leido(self):
        self.leido = True

autor1 = Autor("George","Orwell","Ciencia Ficcion,Terror")
autor2 = Autor("Virginia","Wolf", "Novela, Cuento")

libro1 = Libro("1984","George Orwell","400","Anaya")
libro2 = Libro("Al faro","Virginia Wolf","400","Santillana")

print(libro1.describir_libro())
print(libro2.describir_libro())