--- Por ningún motivo se debe repetir lógica.
--- Buscar dividir los problemas grandes en problemas más chicos.
--- Es obligatorio declarar los tipos de todas
---  las funciones que se piden, no así de las auxiliares que definan.
--- Usar composición siempre que puedan.


type Post = (String, Int)
postCualquiera = ("Este es un post", 10)

obtenerPalabrasPost :: Post -> [String]
obtenerPalabrasPost = words . fst

cuentaPalabrasPost :: Post -> Int
cuentaPalabrasPost = length . obtenerPalabrasPost

tienePuntajeNegativo :: Post -> Bool
tienePuntajeNegativo unPost = (snd unPost) < 0

esSpam :: Post -> Bool
esSpam unPost = elem "ATENCION" (obtenerPalabrasPost unPost)

concatenar :: Post -> String -> String
concatenar unPost unString = (fst unPost) ++ " -- " ++ unString

--- Saber los puntosBase/1 de un post sabiendo que 
-- se calcula como la cantidad de palabras del mensaje * su puntaje.
puntosBase :: Post -> Int
puntosBase unPost = cuentaPalabrasPost unPost * snd unPost

--- Saber si un post esMolesto/1. 
--- Un post se considera molesto cuando tiene un puntaje negativo
--- o bien es spam. Se considera spam a todo post
---cuyo mensaje contenga la palabra "ATENCION".
esMolesto :: Post -> Bool
esMolesto unPost = tienePuntajeNegativo unPost || esSpam unPost



--- responder/2 un post. Esto significa que
---  dado un post (pregunta) y
--  una mensaje (respuesta) crea un nuevo post
---  con puntaje 0 y un mensaje con el formato " -- ". Por ej:
--- > responder ("Maniana hay clases?", 3) "Si"
--- ("Maniana hay clases? -- Si",0)
responder :: Post -> String -> Post
responder unPost unaRespuesta =  (concatenar unPost unaRespuesta, 0)