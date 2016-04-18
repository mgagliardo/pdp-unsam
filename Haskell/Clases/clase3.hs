siguiente x = succ x

data Dia = Lunes | Martes | Miercoles | Jueves | Viernes | Sabado | Domingo deriving (Show, Eq, Enum)

esMalo Lunes = True
esMalo _ = False

esFinde :: Dia -> Bool
esFinde Viernes = True
esFinde Sabado = True
esFinde Domingo = True
esFinde _ = False

finesDeSemana = [Viernes, Sabado, Domingo]
esFinde' dia = elem dia finesDeSemana

data Animal = Perro String Int | Sapo String Bool Int deriving(Show)

nombre :: Animal -> String
nombre (Perro nombre _) = nombre

pepe = Sapo "Pepe" True 5
kalif = Perro "Kalif" 10

anios :: Animal -> Int
anios (Perro nombre edad) = edad
anios (Sapo nombre esMacho edad) = edad

pasarUnAnio :: Animal -> Animal
pasarUnAnio (Perro nombre edad) = Perro nombre (edad + 1)
