--- Por ningún motivo se debe repetir lógica.
--- Buscar dividir los problemas grandes en problemas más chicos.
--- Es obligatorio declarar los tipos de todas
---  las funciones que se piden, no así de las auxiliares que definan.
--- Usar composición siempre que puedan.
type Post = (String, Int)

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


-------------------------------------------------

--- Bien, hasta ahora ya implementamos todas las
--- funcionalidades que nos pidieron para cualquier post.

--- Pero los usuarios suelen tener muchos posts. Por ej:

postsDeFer = [
     ("PDP", 10),
     ("El Lunes a que aula vamos? -- Laboratiorio de Sociales!", 0),
     ("ATENCION avisos parroquiales...", 2), ("PHM", -2)
     ]  :: [Post]


postsDeLucas = [
   ("El Lunes a que aula vamos?", 0),
   ("El Lunes a que aula vamos? -- Laboratiorio de Sociales! -- Ok, gracias!", 1)
 ] :: [Post]


cuentaCaracteres :: Post -> Int
cuentaCaracteres = length . fst

esPar :: Post -> Bool
esPar = even . cuentaCaracteres

noEsMolesto :: Post -> Bool
noEsMolesto = not . esMolesto

obtenerPuntosPosts :: [Post] -> [Int]
obtenerPuntosPosts postsUsuario = map (puntosBase) postsUsuario

devolverPostsPopulares :: [Post] -> [Post]
devolverPostsPopulares = filter devolverMensajePopular

devolverMensajePopular :: Post -> Bool
devolverMensajePopular post = (esImpar post) && (noEsMolesto post)

esImpar :: Post -> Bool
esImpar = not . esPar

--- Saber los puntosTotales/1 de un usuario. Esto significa,
---  dada la lista de sus posts, la sumatoria de los puntos
--- base de cada post.
puntosTotales :: [Post] -> Int
puntosTotales =  sum . obtenerPuntosPosts

--Obtener los mensajesPopulares/1 de los posts de un usuario.
--O sea, los mensajes de aquellos posts que son populares.
--Nos dijeron que un post es popular cuando no es molesto y,
--además, tiene una cantidad de caracteres impar en su mensaje.
mensajesPopulares :: [Post] -> [String]
mensajesPopulares postsUsuario = map (fst) (devolverPostsPopulares postsUsuario)

-----------------------------------

data Categoria = Novato | Groso | Estrella deriving (Show, Eq, Enum)

data Usuario =  Nuevo String [Post] | Full String Categoria [Post] deriving (Show, Eq)


obtenerPrimeros3 :: String -> String
obtenerPrimeros3 palabra= take 3 palabra

primerPost :: Usuario -> Post
primerPost = head . posts

--Saber las iniciales/1 de un usuario, estas son las primeras 3 letras de su nick.
iniciales :: Usuario -> [Char]
iniciales = obtenerPrimeros3 . nick

--Obtener un mensajito/1 para un usuario (para mostrar en una preview).
--El mensajito de un usuario  =son las primeras 3 letras del mensaje del primer post.
mensajito :: Usuario -> String
mensajito unUsuario = obtenerPrimeros3 (fst (primerPost unUsuario))

---Poder upgradear/1 a un usuario, con las siguientes indicaciones:
--Si el usuario es nuevo y suma más de 100 puntos totales en sus posts
-- => pasa a ser full estrella,
--Si el usuario es nuevo y tiene algún post molesto => pasa a ser full novato,
--Si el usuario es nuevo y no suma más de 100 puntos totales  ni tiene ningún post molesto 
-- => pasa a ser full groso,


--Si el usuario es full novato => pasa a ser full groso,
--Si el usuario es full groso => pasa a ser full estrella
--Los usuarios full estrellas no pueden upgradearse más
--así que están fuera de este dominio. 


sumaMasDe100 :: [Post] -> Bool
sumaMasDe100 posts = (puntosTotales posts) > 100


mostrarPostsMolestos :: [Post] -> [Post]
mostrarPostsMolestos = filter esMolesto

hayPostsMolestos :: [Post] -> Bool
hayPostsMolestos posts = mostrarPostsMolestos posts /= []


upgradear :: Usuario -> Usuario
upgradear (Nuevo n p)	| sumaMasDe100 p = (Full n Estrella p)
						| hayPostsMolestos p = (Full n Novato p)
						| otherwise = (Full n Groso p)

upgradear (Full n Novato p) = (Full n Groso p)
upgradear (Full n Groso p)  = (Full n Estrella p)


--Algunos ejemplos de usuarios podrían ser:
nahue = Nuevo "Nahuel" [("Hola", 0)]
fer = Full "Fernando" Estrella postsDeFer
lucas = Full "Lucas" Groso postsDeLucas
migue = Nuevo "Migue" [("Miguel", 10), ("ATENCION", 10)] 

--También ya tenemos definidas las siguientes funciones:

nick (Nuevo n _) = n
nick (Full n _ _) = n

posts (Nuevo _ p) = p
posts (Full _ _ p) = p

categoria (Full _ c _) = c