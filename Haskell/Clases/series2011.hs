series = [("los soprano", 6, 1999, "HBO"),
          ("lost", 6, 2004, "ABC"),
          ("4400", 4, 2004, "CBS"), 
          ("United States of Tara", 3, 2009, "Dreamworks"),
          ("V", 3, 2009, "Warner Bross"),
          ("dr house", 7, 2004, "Universal")]

actores = [("Ken Leung", ["lost", "los soprano"]),
    ("Joel Gretsch", ["4400", "V", "United States of Tara"]),
    ("James Gandolfini", ["los soprano"]),
    ("Elizabeth Mitchell", ["dr house", "V", "lost"])]

serie (s, _, _, _) = s
temporadas (_, t, _, _) = t
cadenaTV (_, _, _, c) = c	
anioComienzo (_, _, a, _) = a
seriesDeActor = snd
nombreActor = fst

find criterio = head . filter criterio

-- 1) Encontrar los datos de una serie en base al nombre
datosDe nombreSerie = find ((== nombreSerie) . serie) series

-- 2) Conocer la lista de actores que trabajaron en una serie
listaDeActoresDe serie = [ actor | (actor, series) <- actores, elem serie series ]

-- 3) Conocer la lista de actores que actuaron en dos series diferentes
quienesActuaronEn serie1 serie2 = (map nombreActor . filter (\(actor, series)->elem serie1 series && elem serie2 series)) actores 

-- 4) Saber si la lista de series en la que participó un actor está ordenada por año de comienzo
seriesOrdenadas [serie] = True
seriesOrdenadas (serie1:serie2:series) = anioDeComienzoDe serie1 <= anioDeComienzoDe serie2 && seriesOrdenadas (serie2:series)

anioDeComienzoDe nombreSerie = (anioComienzo . find ((== nombreSerie) . serie)) series
anioDeComienzoDe' = anioComienzo . datosDe

-- 5) 
queSeriesCumplen unCriterio = map serie . filter unCriterio 

-- Qué series duraron más de 3 temporadas
-- >queSeriesCumplen ((> 3) . temporadas) series
-- ["los soprano","lost","4400","dr house"]  

-- Qué series tuvieron más de 4 actores (tip: puede servir una función hecha anteriormente)
-- queSeriesCumplen ((> 4) . length . listaDeActoresDe . serie) series

-- Qué series tienen un título de menos de 5 letras
-- queSeriesCumplen ((< 5) . length . serie) series 

-- 6) a) Queremos saber en promedio cuántas temporadas duran las series
promedioGeneral = div sumaTemporadas cantidadSeries

sumaTemporadas = foldl (\acum (_, t, _, _) -> acum + t) 0 series

cantidadSeries = (fromInt . length) series

-- b) Agregar como parámetro una función que devuelva un valor al cual se le calcule el promedio
-- (con división entera) de todas las series
promedio fnMagnitud = div (sumaTemporadas' fnMagnitud) cantidadSeries

sumaTemporadas' fnMagnitud = foldl (\acum serie -> acum + fnMagnitud serie) 0 series

-- 7) Inferir los tipos de la función funcionHeavy
funcionHeavy a b c d e | d > e     = map a c 
                       | otherwise = map b c

-- funcionHeavy :: Ord c => (a -> b) -> (a -> b) -> [a] -> c -> c -> [b]
