usuarios = [{"username": "alfa", "email": "a@mail.com", "nivel": "Premium", "meses": 12},
{"username":"ana_88","email":"ana@tsst.com","nivel":"Premium","meses":24},
{"username":"paco_dev","email":"paco@test.com","nivel":"Gratis","meses":2},
{"username":"marta_python","email":"marta@test.com","nivel":"Premium","meses":10},
{"username":"luacas_sky","email":"lucas@tsst.com","nivel":"Gratis","meses":5}
]

def obtener_emails_premium(lista_usuarios):
    return {u["username"]: u["email"] for u in lista_usuarios if u ["nivel"] == "Premium"}

def transformar_usuarios(lista_usuarios):

    lista_tuplas = []
    for u in lista_usuarios:

        lista_tuplas.append((u["username"], u["meses"]))

    return sorted(lista_tuplas, key=lambda x: x[1], reverse=True)

print(f"Lista usuarios premium: ", obtener_emails_premium(usuarios))
print("Lista ordenada: ", transformar_usuarios(usuarios))
