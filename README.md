# FullstackAvanzado

Proyecto Flutter mediante el uso de supabase, Geminis y elementos externos.
_______________________________________________
## Creacion de  proyecto y tabla en supabase

CREATE TABLE personas (
    id SERIAL PRIMARY KEY,
    identificacion VARCHAR(255) UNIQUE,
    nombres VARCHAR(255),
    direccion VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    telefono VARCHAR(255),
    urlFoto VARCHAR(255),
    scanner BOOLEAN DEFAULT FALSE,
    usuario BOOLEAN DEFAULT FALSE,
    fecha VARCHAR(255),
    hora VARCHAR(255)
);
__________________________________________________
## registros tabla personas

INSERT INTO personas (identificacion, nombres, direccion, email, telefono, urlFoto, scanner, usuario, fecha, hora, password) VALUES
('1234567890', 'Ana Morales', 'Calle 10 # 5-20', 'anamorales@gmail.com', '3101234567', 'http://foto.com/ana.jpg', TRUE, TRUE, '2025-09-04', '10:00:00', MD5('1234567890')),
('2345678901', 'Luis Pérez', 'Carrera 7 # 15-30', 'luisperez@gmail.com', '3112345678', 'http://foto.com/luis.jpg', FALSE, TRUE, '2025-09-04', '10:05:00', MD5('2345678901')),
('3456789012', 'Sofía Gómez', 'Avenida 20 # 8-50', 'sofiagomez@gmail.com', '3123456789', 'http://foto.com/sofia.jpg', FALSE, FALSE, '2025-09-04', '10:10:00', MD5('3456789012')),
('4567890123', 'Carlos Díaz', 'Calle 50 # 2-10', 'carlosdiaz@gmail.com', '3134567890', 'http://foto.com/carlos.jpg', TRUE, FALSE, '2025-09-04', '10:15:00', MD5('4567890123')),
('5678901234', 'María López', 'Carrera 4 # 25-60', 'marialopez@gmail.com', '3145678901', 'http://foto.com/maria.jpg', FALSE, TRUE, '2025-09-04', '10:20:00', MD5('5678901234')),
('6789012345', 'Juan Ramírez', 'Avenida 3 # 12-45', 'juanramirez@gmail.com', '3156789012', 'http://foto.com/juan.jpg', TRUE, TRUE, '2025-09-04', '10:25:00', MD5('6789012345')),
('7890123456', 'Laura Torres', 'Calle 8 # 3-15', 'lauratorres@gmail.com', '3167890123', 'http://foto.com/laura.jpg', FALSE, FALSE, '2025-09-04', '10:30:00', MD5('7890123456')),
('8901234567', 'Andrés Mendoza', 'Carrera 18 # 7-22', 'andresmendoza@gmail.com', '3178901234', 'http://foto.com/andres.jpg', TRUE, FALSE, '2025-09-04', '10:35:00', MD5('8901234567')),
('9012345678', 'Valeria Castro', 'Calle 25 # 9-8', 'valeriacastro@gmail.com', '3189012345', 'http://foto.com/valeria.jpg', FALSE, TRUE, '2025-09-04', '10:40:00', MD5('9012345678')),
('0123456789', 'David Herrera', 'Avenida 5 # 1-40', 'davidherrera@gmail.com', '3190123456', 'http://foto.com/david.jpg', FALSE, FALSE, '2025-09-04', '10:45:00', MD5('0123456789')),
('1122334455', 'Elena Vargas', 'Calle 33 # 10-5', 'elenavargas@gmail.com', '3201234567', 'http://foto.com/elena.jpg', TRUE, TRUE, '2025-09-04', '10:50:00', MD5('1122334455')),
('2233445566', 'Felipe Ríos', 'Carrera 2 # 14-18', 'feliperios@gmail.com', '3212345678', 'http://foto.com/felipe.jpg', FALSE, TRUE, '2025-09-04', '10:55:00', MD5('2233445566')),
('3344556677', 'Gabriela Mora', 'Avenida 12 # 6-25', 'gabrielamora@gmail.com', '3223456789', 'http://foto.com/gabriela.jpg', FALSE, FALSE, '2025-09-04', '11:00:00', MD5('3344556677')),
('4455667788', 'Hugo Salazar', 'Calle 45 # 1-30', 'hugosalazar@gmail.com', '3234567890', 'http://foto.com/hugo.jpg', TRUE, FALSE, '2025-09-04', '11:05:00', MD5('4455667788')),
('5566778899', 'Isabel Soto', 'Carrera 15 # 9-5', 'isabelsoto@gmail.com', '3245678901', 'http://foto.com/isabel.jpg', FALSE, TRUE, '2025-09-04', '11:10:00', MD5('5566778899')),
('6677889900', 'Javier Peña', 'Calle 28 # 11-12', 'javierpena@gmail.com', '3256789012', 'http://foto.com/javier.jpg', TRUE, TRUE, '2025-09-04', '11:15:00', MD5('6677889900')),
('7788990011', 'Karen Ocampo', 'Avenida 6 # 17-55', 'karenocampo@gmail.com', '3267890123', 'http://foto.com/karen.jpg', FALSE, FALSE, '2025-09-04', '11:20:00', MD5('7788990011')),
('8899001122', 'Leonardo Ruiz', 'Calle 39 # 4-6', 'leonardoruiz@gmail.com', '3278901234', 'http://foto.com/leonardo.jpg', TRUE, TRUE, '2025-09-04', '11:25:00', MD5('8899001122')),
('9900112233', 'Mónica Gil', 'Carrera 1 # 2-33', 'monicagil@gmail.com', '3289012345', 'http://foto.com/monica.jpg', FALSE, TRUE, '2025-09-04', '11:30:00', MD5('9900112233')),
('0011223344', 'Nicolás Solano', 'Calle 13 # 16-10', 'nicolassolano@gmail.com', '3290123456', 'http://foto.com/nicolas.jpg', FALSE, FALSE, '2025-09-04', '11:35:00', MD5('0011223344')),
('1122334456', 'Olga Benítez', 'Avenida 22 # 5-45', 'olgabenitez@gmail.com', '3301234567', 'http://foto.com/olga.jpg', TRUE, FALSE, '2025-09-04', '11:40:00', MD5('1122334456')),
('2233445567', 'Pedro Guzmán', 'Calle 7 # 8-1', 'pedroguzman@gmail.com', '3312345678', 'http://foto.com/pedro.jpg', FALSE, TRUE, '2025-09-04', '11:45:00', MD5('2233445567')),
('3344556678', 'Rosa Jiménez', 'Carrera 3 # 19-20', 'rosajimenez@gmail.com', '3323456789', 'http://foto.com/rosa.jpg', TRUE, TRUE, '2025-09-04', '11:50:00', MD5('3344556678')),
('4455667789', 'Santiago Díaz', 'Avenida 15 # 1-1', 'santiagodiaz@gmail.com', '3334567890', 'http://foto.com/santiago.jpg', FALSE, FALSE, '2025-09-04', '11:55:00', MD5('4455667789')),
('5566778890', 'Teresa Castro', 'Calle 24 # 6-15', 'teresacastro@gmail.com', '3345678901', 'http://foto.com/teresa.jpg', TRUE, TRUE, '2025-09-04', '12:00:00', MD5('5566778890')),
('6677889901', 'Uriel Vargas', 'Carrera 9 # 12-40', 'urielvargas@gmail.com', '3356789012', 'http://foto.com/uriel.jpg', FALSE, TRUE, '2025-09-04', '12:05:00', MD5('6677889901')),
('7788990012', 'Verónica Gómez', 'Avenida 10 # 3-25', 'veronicagomez@gmail.com', '3367890123', 'http://foto.com/veronica.jpg', FALSE, FALSE, '2025-09-04', '12:10:00', MD5('7788990012')),
('8899001123', 'William López', 'Calle 16 # 8-5', 'williamlopez@gmail.com', '3378901234', 'http://foto.com/william.jpg', TRUE, FALSE, '2025-09-04', '12:15:00', MD5('8899001123')),
('9900112234', 'Ximena Salazar', 'Carrera 17 # 1-30', 'ximenasalazar@gmail.com', '3389012345', 'http://foto.com/ximena.jpg', FALSE, TRUE, '2025-09-04', '12:20:00', MD5('9900112234')),
('0011223345', 'Yolanda Ortiz', 'Avenida 4 # 14-18', 'yolandaortiz@gmail.com', '3390123456', 'http://foto.com/yolanda.jpg', TRUE, TRUE, '2025-09-04', '12:25:00', MD5('0011223345'));
_____________________________________________________
## Prompt para crear el proyecto inicial

Creame un interfaz en flutter web responsiva colores agradable, para hacer login con usuario y contraseña y un botón adicional para iniciar sesion con Google(aun no funcional),  una vez sea satisfactoria se visualiara una ventana con las siguientes opciones: Mi Perfil, Mi QR, Escanner(si el valor true es scanner), Usuarios(si el valor es true en usuarios), Acerca de.. y Cerrar Sesion.

Las opciones no van a ser operativas a excepcion de cerrar seison. 



utiliza getx, scafold, cards, listtile, listview o gridview, icons



El entorno donde estoy trabando es firebase studio
___________________________________________________________
## Prompt para crear Interfaz Perfil

construye una interfaz stafullwidget para perfil, toma unicamente los datos identificacion, nombres, direccion, email, telefono, dame unicamente este codigo. utiliza cajas de texto y boton actualizar, usa scafold

____________________________________________________________
## Prompt Actualizar perfil
vamos a actualizar, en el boton de actualizar de perfilpage.dart, los datos, actualiza en base a id del usuario unicamente.


__________________________________________________________
## Prompt para cargar imagen o archivo desde el perfil

En perfilpage debe teenr scafold y floatingactionbutton para cargar un archivo usa filepicker.  y enviarla a supabase, el bucket se llama: documentos.

la url del proyecto es: https://voxiaunrkplxibrzyhhz.supabase.co

utiliza para este proceso supabase_flutter, una vez cargues en el bucket la fotografia debes obtener la url y actualizarlo en la tabla personas con id del usuario.
_________________________________________________________________
## Promot para actualizar la forma de visualizacion del perfil

actualiza la forma en que se ven los datos en el perfil, agrega un image puede ser circleavatar y url publicalo allí.

___________________________________________________________
## Prompt para diseño de carnet

omepage, abra un showmodalbutton dentro tendra un scafold, el appbar titulado como Carnet, dentro de body, dentra toda la informacion del usuario, organizado en un carnet, fotografia(urlfoto), y ademas un codigo qr que pertenece al email del usuario.

foto
QR
datos

diseñando un carnet


##


