series = [ ("los soprano", 6, 1999, "HBO"),  	
           ("lost", 6, 2004, "ABC"), 
           ("4400", 4, 2004, "CBS"),  
           ("United States of Tara", 3, 2009, "Dreamworks"), 
           ("V", 3, 2009, "Warner Bross"), 
           ("dr house", 7, 2004, "Universal")
         ]

-- (nombreSerie cantTemporadas, anioPrimerTemporada, cadenaProductora)

actores = [ ("Ken Leung", ["lost", "los soprano"]), 
            ("Joel Gretsch", ["4400", "V", "United States of Tara"]), 
            ("James Gandolfini", ["los soprano"]), 
            ("Elizabeth Mitchell", ["dr house", "V", "lost"])

          ]

-- nombreActor listaSeries

serie (s, _, _, _) = s 
temporadas (_, t, _, _) = t 
cadaTV (_, _, _, c) = c
anioComienzo (_, _, a, _) = a 
seriesDeActor = snd 
nombreActor = fst  
find criterio = head . filter criterio

-------------------------------------

type Serie = (String, Int, Int, String)

type Actor = (String, [String])

-- Encontrar los datos de una serie en base al nombre
-- > datosDe "4400"
-- ("4400",4,2004,"CBS")

datosDe :: String -> Serie
datosDe nombreSerie = find (flip laSerieTieneEsteNombre nombreSerie) series

laSerieTieneEsteNombre unaSerie =  (serie unaSerie ==)

-- Conocer la lista de actores que trabajaron en una serie
-- >listaDeActoresDe "los soprano"  
-- ["Ken Leung", "James Gandolfini"]

listaDeActoresDe :: String -> [String]
listaDeActoresDe nombreSerie = (nombresDeActores . filter (actorTrabajoEn nombreSerie)) actores

actorTrabajoEn :: String -> Actor -> Bool
actorTrabajoEn nombreSerie = (elem nombreSerie) . seriesDeActor

nombresDeActores :: [Actor] -> [String]
nombresDeActores = map nombreActor

-- Conocer la lista de actores que actuaron en dos series diferentes
-- >quienesActuaronEn "V" "lost" 
-- ["Elizabeth Mitchell"]

quienesActuaronEn :: String -> String -> [String]
quienesActuaronEn nombreSerie1 nombreSerie2 = nombresDeActores (trabajaronEn nombreSerie1 nombreSerie2)

trabajaronEn :: String -> String -> [Actor]
trabajaronEn nombreSerie1 nombreSerie2 = filter (trabajoEnLasDosPeliculas nombreSerie1 nombreSerie2) actores

trabajoEnLasDosPeliculas :: String -> String -> Actor -> Bool
trabajoEnLasDosPeliculas nombreSerie1 nombreSerie2 actor = (actorTrabajoEn nombreSerie1 actor) && (actorTrabajoEn nombreSerie2 actor)

-- Poder determinar el año de una serie en base a su nombre
-- > anioDeComienzoDe "lost" 
-- 2004    

anioDeComienzoDe :: String -> Int
anioDeComienzoDe = anioComienzo . datosDe


-- Saber si una lista de series está ordenada por año de comienzo.
-- >seriesOrdenadas ["dr house", "V", "lost"]  
-- False 
-- (House arranca en el 2004 y “V Invasión extraterrestre” en el 2009 –hasta acá es correcto-
-- pero luego sigue con “Lost”  que comenzó en el 2004)

seriesOrdenadas :: [String] -> Bool
seriesOrdenadas =  estaOrdenada . listaDeAnios

listaDeAnios :: [String] -> [Int]
listaDeAnios = map anioDeComienzoDe

estaOrdenada :: [Int] -> Bool
estaOrdenada [] = True
estaOrdenada [a] = True
estaOrdenada (x:y:xs)= x<=y && estaOrdenada (y:xs)

-- Queremos saber cuáles son las series que cumplen un determinado criterio.
-- Tenemos esta función.


queSeriesCumplen unCriterio = map serie . filter unCriterio

-- Utilizar la función para resolver: 
-- Qué series duraron más de 3 temporadas
-- Qué series tuvieron más de 4 actores  
-- Qué series tienen un título de menos de 5 letras 
-- No se pueden definir funciones auxiliares ni expresiones lambda/definiciones locales 


-- Qué series duraron más de 3 temporadas
-- >queSeriesCumplen ((> 3) . temporadas) series
-- ["los soprano","lost","4400","dr house"]  

-- Qué series tuvieron más de 4 actores (tip: puede servir una función hecha anteriormente)
-- queSeriesCumplen ((> 4) . length . listaDeActoresDe . serie) series

-- Qué series tienen un título de menos de 5 letras
-- queSeriesCumplen ((< 5) . length . serie) series 


-- Queremos saber en promedio cuántas temporadas duran las series
-- >promedioGeneral 
-- 4 (6 + 6 + 4 + 3 + 3 + 7 = 29 / 6 series, en división entera me da 4) 

promedioGeneral :: Int
promedioGeneral = promedioPor temporadas

sumaListaConParametro :: Num c => (a -> c) -> [a] -> c
sumaListaConParametro param = sum . map param

cantidadDeSeries :: Int
cantidadDeSeries = length series

-- Agregar como parámetro una función que devuelva un valor al cual se le calcule el 
-- promedio (con división entera) de todas las series 
-- > promedio anioComienzo 
-- 2004 (los años de comienzo de cada serie / 6 series)

-- >promedio anioFin where anioFin serie = anioComienzo serie + temporadas serie  
-- 2009 (2005 + 2010 + 2008 + 2012 + 2012 + 2011 = 12058 / 6 = 2009, 666)

promedioPor :: (Serie -> Int) -> Int
promedioPor parametro = div (sumaListaConParametro parametro series) cantidadDeSeries

-- Inferir los tipos de la función funcionHeavy
-- funcionHeavy :: Ord c => (a -> b) -> (a -> b) -> [a] -> c -> c -> [b]
funcionHeavy a b c d e | d > e     = map a c  
                       | otherwise = map b c 