repetirLista elemento = [elemento] ++ repetirLista elemento

-- todosLosNaturales :: [Int]
todosLosNaturales = iterate (+1) 1
todosLosNaturales' = [1..]

todosLosPares = iterate (+2) 0
todosLosPares' = iterate (*2) 1
todosLosPares'' = filter even todosLosNaturales


-- primerosN :: Int -> [Int]
primerosN hastaN = take hastaN todosLosNaturales
primerosN' n = [1..n]


pegarPalabra palabra = (palabra ++) . show

-- pegarPalabra :: String -> Int -> String
-- pegarPalabra "PDP" :: Int -> String


repetirPalabras :: String -> [String]
repetirPalabras = repetirPalabrasDesde todosLosNaturales
repetirPalabrasPares = repetirPalabrasDesde todosLosPares

repetirPalabrasDesde lista palabra = map (pegarPalabra palabra) lista




potenciasDeDos = iterate (*2) 1
potenciasDeDos' = map (2^) [0..]


primeroQueCumple cond inicio f = (head . filter cond . iterate f) inicio


maximoSegun :: Ord b => ( a -> b ) -> [a] -> b
maximoSegun f = maximum . map f


-- maximoSegun (+2) :: (Ord a, Num a) => [a] -> a
