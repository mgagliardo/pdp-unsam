-- Se pueden usar estas funciones del prelude: all / any / map / filter / elem. También esta función
sumList l = foldl (+) 0 l

-- Se nos pide desarrollar un programa Haskell que analice las calificaciones obtenidas por los aspirantes a
-- distintas becas y concursos. Cada aspirante rinde cuatro exámenes, de materias a su elección. Los aspirantes
-- se reúnen en planillas según en qué mes rindieron sus exámenes. P.ej.:

planillaEnero = [ ("pepe", [("fisica",6),("algebra",9),("datos",8),("disenio",7)]),
				  ("lucia", [("historia",8),("filosofia",9),("algebra",10),("poesia",8)]),
				  ("franco", [("algebra",9),("disenio",9),("datos",10),("derecho",8)]),
                  ("ana", [("derecho",7),("algebra",9),("disenio",8),("poesia",9)])
     			]

planillaFebrero = [ ("marta", [("fisica",5),("algebra",6),("datos",7),("disenio",8)]),
					("pedro", [("historia",8),("derecho",9),("algebra",10),("poesia",8)])
				  ]

-- (lo que sigue lo van a necesitar solamente para el ítem 4).
-- Los requisitos para acceder a una beca o concurso se describen mediante 
-- un par (mínima nota total,exámenes que hay que tener)
-- p.ej. el par
--(35,["algebra","disenio"])


-- Representa un requerimiento en el que para cumplirlo la suma de las notas tiene que ser al menos 35, y
-- además hay que haber rendido los exámenes de álgebra y de diseño (no importa qué nota te sacaste en esos
-- exámenes). De los de la planilla de enero, solamente Franco lo cumple; Lucía suma más de 35 pero no tiene
-- Diseño; Pepe tiene las dos pero no llega a 35.

-- Definir la función maximoF, que dados una función y una lista, 
-- devuelve el elemento de la lista que esmáximo para la función. P.ej.
-- >maximoF abs [-5..3]
-- -5
-- maximoF length ["la", "larga", "paz"]
-- devuelve "larga"

maximoF funcion = foldl1 (\acum vac -> devolverMaximo funcion acum vac)

devolverMaximo funcion acum vac | funcion acum > funcion vac = acum
								| otherwise = vac


-- Definir la función estaIncluida, que dadas dos listas devuelve True si todos los elementos de la 
-- primera son elementos de la segunda, y False en caso contrario. P.ej. 

-- estaIncluida [2,4] [1..5]
-- devuelve 
-- True 

-- estaIncluida [4,6] [1..5]            
-- devuelve 
-- False

estaIncluida [] [] = True
estaIncluida [] [a] = False
estaIncluida [a] [] = False
estaIncluida [a,b] otraLista = (estaEnLista a otraLista) && (estaEnLista b otraLista)
estaIncluida (x:xs) otraLista = (estaEnLista x otraLista) && (estaIncluida xs otraLista)

estaEnLista item lista = elem item lista 


--Definir la función sePresento, que dados un nombre de alumno y una planilla, indica si los exámenes 
--del alumno están en la planilla. P.ej. 

-- >sePresento "franco" planillaEnero    
-- True 

-- >sePresento "franco" planillaFebrero  
-- False 











--¿Cómo preguntarían si Franco se presentó en algún m
--es (o bien en enero o bien en febrero)? La 
--consulta es 
--sePresento "franco" ...
--, completar cómo sigue