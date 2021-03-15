
#Importo librerias
import csv
from random import randrange
import random
import string

#funcion generadora de password de los usuarios

###Nota adicional
## Yo en este caso utilice solo numeros y letras pero utilizarse otros tipos de caracteres especiales para aumentar la complejidad de la contrasenia

def password_generator():
    #Creo un string con letras aleatorias de longitud 6 y las uno en un string unico. En este caso se puede agrandar el rango para mas complejidad
    letras = ''.join((random.choice(string.ascii_letters)) for i in range(6))
    #Creo un string con numeros aleatorios de longitud 6 y las uno en un string unico. En este caso se puede agrandar el rango para mas complejidad
    digitos = ''.join((random.choice(string.digits)) for i in range(6))
    #Agrupo las variables en una lista 
    lista = list(letras+digitos)
    #Mezclo los valores de la lista de manera aleatoria
    random.shuffle(lista)
    #Guardo el string obtenido en una variable
    contras= ''.join(lista)
    #Retorno contrasenia
    return contras

# creo diccionario diccionario de OU y grupos
areas = [("OU=IT,OU=Area,DC=LABORATORIO,DC=LOCAL","IT"),("OU=RRHH,OU=Area,DC=LABORATORIO,DC=LOCAL","RRHH"),("OU=Legales,OU=Area,DC=LABORATORIO,DC=LOCAL","Legales"),("OU=Defensa,OU=Area,DC=LABORATORIO,DC=LOCAL","Defensa"),("OU=Jefatura,OU=Area,DC=LABORATORIO,DC=LOCAL","Jefatura")]

# abro el archivo de nombres
with open('/path/a/archivo/de/nombres.csv') as csv_nombres:
    #creo reader del archivo con el delimitador correspondiente, en el caso el caracter ","
    csv_reader_nombres = csv.reader(csv_nombres, delimiter=',')
    csv_reader_nombres = list(csv_reader_nombres)

# abro el archivo de apellidos
with open('/path/a/archivo/de/apellidos.csv') as csv_apellidos:
    #creo reader del archivo con el delimitador correspondiente, en el caso el caracter ","
    csv_reader_apellidos = csv.reader(csv_apellidos, delimiter=',')
    csv_reader_apellidos = list(csv_reader_apellidos)

# creo el archivo donde se guardaran los usuarios
with open('/path/a/destino/final/de/usuarios_ad.csv', mode='w') as usuarios:
    #creo writer del archivo con el delimitador correspondiente, en el caso el caracter ","
    csv_writer_usuarios = csv.writer(usuarios,delimiter=',', quotechar='"')
    #creo los nombres de la columna del csv
    csv_writer_usuarios.writerow(['firstname','lastname','username','email','password','initials','computer','ou','group'])

    #loop for que indica la cantidad de usuarios a crearse
    for x in range(0,10000):
        #variable a utilizar en la variable OU y Group
        index = randrange(0,5)
        #Elijo un nombre aleatorio dentro del reader nombres y lo asigno a la variable
        nombre = csv_reader_nombres[randrange(1,844237)][0]
        #Elijo un nombre aleatorio dentro del reader apellido y lo asigno a la variable
        apellido = csv_reader_apellidos[randrange(1,25849)][0]
        #Concateno el primer caracter de nombre y apellido, luego lo asigno a la variable
        iniciales = nombre[0]+apellido[0]
        #llamo a la funcion password_generator y asigno el valor devuelvo a password
        password = password_generator()
        #asigno el valor en la posicion 0 del diccionario creado anteriormente y que utiliza el numero aleatorio creado mas arriba
        ou = areas[index][0]
        #asigno el valor en la posicion 1 del diccionario creado anteriormente y que utiliza el numero aleatorio creado mas arriba
        group = areas[index][1]
        #reviso si el apellido es compuesto, revisando si contiene espacios.En este caso, utilizo solo el primer apellido para componer el
        #nombre del usuario a crear
        find_spaces_surname = apellido.find(" ")
        #Valido si el string contiene espacios    
        if (find_spaces_surname == -1):
            #creo el usuario con la combinacion de primera letra del nombre + apellido
            usuario = nombre[0]+apellido
            #creo el correo utilizando el criterio anterior
            email = nombre[0]+apellido + "@laboratorio.local"
            #creo el nombre del equipo utilizado el criterio definido previamente
            computer = usuario + "-DESKTOP"
        else:
            #creo el usuario con la combinacion de primera letra del nombre + apellido
            usuario = nombre[0]+apellido[:find_spaces_surname]
            #creo el correo utilizando el criterio anterior
            email = nombre[0]+apellido[:find_spaces_surname] + "@laboratorio.local"
            #creo el nombre del equipo utilizado el criterio definido previamente
            computer = usuario + "-DESKTOP"
        #escribo todas las variables en el csv respetando el orden dado
        csv_writer_usuarios.writerow([nombre.lower(),apellido.lower(),usuario.lower(),email.lower(),password,iniciales,computer,ou,group])
    #Informo que el archivo ha sido creado
    print ("Archivo usuarios.ad creado")
    