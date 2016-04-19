-- Se cuenta con personas que asisten a una discoteca, entre los que contamos con personas tranquilas 
-- y agitadores modeladas de la siguiente manera: 

data Persona = Tranqui String | Agitador Int Int String deriving (Show, Eq)

fer   = Tranqui "fer"
flor  = Tranqui "flor"
rodri = Agitador 1670 2000 "rodri"
deby  = Agitador 7000 1500 "deby"

-- Las personas tranquilas definen:
--		> Cómo se llama la persona

-- Las que agitan definen
--		> La cantidad de levante que tiene
--		> El nivel de aguante de alcohol
--		> Cómo se llama la persona

-- Por otra parte se tiene la lista de personas en una disco:
type Disco = [ (Persona, [ (String, Int) ]) ]

laDisco :: Disco
laDisco = [
        	(fer, [("Coca cola", 1), ("Sprite Zero", 1)]),
        	(rodri, [("Cerveza", 2)]),
        	(deby, [("Grog XD", 25), ("Cerveza", 1)]),
        	(flor, [("Grapa", 1)])
          ]

-- Modelados como una tupla con: 
--	> Persona
--	> Bebidas que tomó, modeladas como una lista de tuplas con:
--	> Nombre de la bebida
--	> Cantidad de vasos

-- Y por último, información sobre los tragos:

tragos = [("Coca cola", 0), ("Grog XD", 350), 
          ("Sprite Zero", 0), ("Cerveza", 10), ("Grapa", 40)]

-- El formato que sigue la tupla es: 
-- 	> Nombre de la bebida 
-- 	> Graduación alcohólica de cada vaso s


--------------------------------------------------

type Trago = (String, Int)

nombreTrago (n, _) = n

nombreTranqui :: Persona -> String
nombreTranqui (Tranqui n)   = n

nombreAgitador :: Persona -> String
nombreAgitador (Agitador _ _ n)   = n

nivelDeAguante :: Persona -> Int
nivelDeAguante (Agitador _ a _) = a

---- Requerimientos
---- 1) Control de escabio

---- a) Saber las bebidas que tomó una persona en laDisco.

---- (fer, [("Coca cola", 1), ("Sprite Zero", 1)]),
---- queTomo "fer"
---- [ "Coca cola", "Sprite Zero" ] 

find criterio = head . filter criterio

queTomo :: Persona -> [Trago]
queTomo unaPersona = (snd . find (personaEsEsta unaPersona)) laDisco

personaEsEsta persona = (persona==) . fst

----------------------------------

-- 1) b) Obtener la graduación alcohólica de un trago a partir de su nombre.

graduacion :: String -> Int
graduacion = snd . traerTrago 

traerTrago nombreTrago = find (flip tragoTieneEsteNombre nombreTrago) tragos

tragoTieneEsteNombre unNombre = (nombreTrago unNombre==)

----------------------------------

-- 1) c) Calcular la cantidad de alcohol en sangre que tiene una persona.
-- cantidadAlcoholEnSangre nombrePersona 

cantidadAlcoholEnSangre :: Persona -> Int
cantidadAlcoholEnSangre persona = head $ zipWith (*) (graduacionBebidasQueTomaste persona) (cantidadBebidasQueTomaste persona)

graduacionBebidasQueTomaste persona = map graduacion (queBebidasTomaste persona)

queBebidasTomaste = map fst . queTomo

cantidadBebidasQueTomaste = map snd . queTomo

----------------------------------

-- Saber si una persona está borracha:
-- para una persona tranquila, no puede tener nada de alcohol en sangre.
-- para un agitador, si el aguante es menor que el alcohol en sangre.

estaBorracho :: Persona -> Bool
estaBorracho (Tranqui nombre) = cantidadAlcoholEnSangre (Tranqui nombre) /= 0
estaBorracho (Agitador levante aguante nombre) = aguante < cantidadAlcoholEnSangre (Agitador levante aguante nombre)

----------------------------------


-- Dada una lista de personas, obtener las personas impresentables
-- que son aquellas que están borrachas o pidieron más de 5 tragos.
-- Por cada una retornar una tupla con el nombre de la persona y su alcohol en sangre.

listaPersonas = [fer, rodri, deby, flor]

sonImpresentables :: [Persona] -> [Persona]
sonImpresentables unaLista = quienesEstanBorrachos unaLista ++ quienesTomaronMasDeCincoTragos unaLista

quienesTomaronMasDeCincoTragos unaLista = filter (cantidadBebidasQueTomasteMayorACinco) unaLista

cantidadBebidasQueTomasteMayorACinco persona = (sum (cantidadBebidasQueTomaste persona)) > 5

quienesEstanBorrachos = filter (estaBorracho)

----------------------------------

-- A festejar!
-- Armar las siguientes funciones que modifican una Disco

-- entrar: agrega una persona a la lista sin haber pedido ningún trago.

agregarPersona :: Persona -> [(Persona, [Trago])]
agregarPersona (Tranqui nombre) = laDisco ++ [ ((Tranqui nombre), []) ]
agregarPersona (Agitador levante aguante nombre) = laDisco ++ [ ((Agitador levante aguante nombre), []) ]


-- pedir bebida: cuando una persona pide una bebida hay que incorporarla
-- a la lista de tragos que bebió (asumir 1 vaso, no importa que se repita la misma bebida en la lista).

perdirBebida :: Persona -> String -> Int -> [Trago]
perdirBebida unaPersona nombreBebida cantidad = queTomo unaPersona ++ [(nombreBebida, cantidad)]

---- descontrolarse: si la persona es un agitador, se pide tantos “Grog XD” 
---- como la mitad de su aguante. Las personas tranquilas no se puede descontrolar.

--descontrolarse (Agitador levante aguante nombre) = perdirBebida "Grog XD" (aguante/2)



