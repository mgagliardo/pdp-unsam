--La cátedra de Paradigmas de Programación quiere abrir una barra móvil para ofrecerlas en las MeetUps que acudimos.

--Para ello, nos piden hacer un sistema en Haskell que los ayude a preparar tragos y ver cómo las personas que los consumen reaccionan ante los mismos.

--    Se espera que el sistema:

--        Se declaren todos los tipos de las funciones que se piden. No es obligatorio para las auxiliares.

--        No tenga lógica repetida.

--        Aplique composición siempre que se pueda.

--        Haga un buen uso de funciones aplicadas parcialmente.

--Veamos los requemientos funcionales que nos encargaron...


data Ingrediente = UnIngrediente String Float Float Float Float deriving (Show,Eq)

dulzura (UnIngrediente _ dul _ _ _)   = dul
alcohol (UnIngrediente _ _ alc _ _)   = alc
color   (UnIngrediente _ _ _ col _)   = col
cant    (UnIngrediente _ _ _ _ cant)  = cant

vodka10   = UnIngrediente "vodka" 10  55 0 10
vodka50   = UnIngrediente "vodka" 10  55 0 50
vodka100  = UnIngrediente "vodka" 10  55 0 100
speed80   = UnIngrediente "speed" 30 1 10 80
fernet20  = UnIngrediente "fernet" 10 10 50 20
fernet50  = UnIngrediente "fernet" 10 10 50 50
hielo30   = UnIngrediente "hielo" 0 0 0 30
coca50    = UnIngrediente "cocaCola" 100  0 80 50
naranja50 = UnIngrediente "jugoDeNaranja" 70  0 30 50

type Condimento = (Float, Float, Float)

azucar = (80, 5, 0) :: Condimento
colorante = (15, 0, 100) :: Condimento


dulzuraCondimento :: Condimento -> Float
dulzuraCondimento (dulzura, _, _)   = dulzura

alcoholCondimento :: Condimento -> Float
alcoholCondimento (_, alcohol, _)   = alcohol

colorCondimento :: Condimento -> Float
colorCondimento (_, _, color)       = color

nombre :: Ingrediente -> String
nombre (UnIngrediente nombre _ _ _ _) = nombre


--Poder condimentar/2 un ingrediente. Esto significa que dado un ingrediente
-- y un condimento, modifica el los atributos del ingrediente al punto medio
--  entre el valor actual y el del condimento. 

condimentar :: Condimento -> Ingrediente -> Ingrediente
condimentar unCondimento unIngrediente = UnIngrediente (nombre unIngrediente) (promediarDulzura unIngrediente unCondimento) (promediarAlcohol unIngrediente unCondimento) (promediarColor unIngrediente unCondimento) (cant unIngrediente)

promediarDulzura :: Ingrediente -> Condimento -> Float
promediarDulzura unIngrediente unCondimento = promediar (dulzura unIngrediente) (dulzuraCondimento unCondimento)

promediarAlcohol :: Ingrediente -> Condimento -> Float
promediarAlcohol unIngrediente unCondimento = promediar (alcohol unIngrediente) (alcoholCondimento unCondimento)

promediarColor :: Ingrediente -> Condimento -> Float
promediarColor unIngrediente unCondimento = promediar (color unIngrediente) (colorCondimento unCondimento)

promediar :: Fractional a => a -> a -> a
promediar unNum otroNum = (unNum + otroNum) / 2

--Poder mezclar/2 un ingrediente con muchos otros. 
--Al hacer esto el ingrediente se condimenta con los valores máximos, 
--para cada atributo (dulzura, alcohol y color), de los otros ingredientes. 
--Dicho en otras palabras, el ingrediente a mezclar que se va a condimentar
-- tomando como atributos del condimento el más alto entre todos los valores de
--  los otros ingredientes.

mezclar :: Ingrediente -> [Ingrediente] -> Ingrediente
mezclar unIngrediente variosIngredientes = condimentar (construirCondimento variosIngredientes) unIngrediente

construirCondimento :: [Ingrediente] -> Condimento 
construirCondimento listaIngredientes = (obtenerDulzuraMax listaIngredientes, obtenerAlcoholMax listaIngredientes, obtenerColorMax listaIngredientes)

obtenerDulzuraMax :: [Ingrediente] -> Float
obtenerDulzuraMax = maximum . (map dulzura)

obtenerAlcoholMax :: [Ingrediente] -> Float
obtenerAlcoholMax = maximum . (map alcohol)

obtenerColorMax :: [Ingrediente] -> Float
obtenerColorMax = maximum . (map color)

--Poder batir/1 muchos ingedientes entre sí. Quiere decir que cada 
--ingrediente se va a mezclar con todo el resto (excluyendo dicho ingrediente).

-- batir [Ingrediente] -> [Ingrediente]
-- batir listaIngredientes = 

listaIng = [ vodka10, speed80, naranja50 ]
listaNum = [1, 2, 3, 4, 5]

batir :: [Ingrediente] -> [Ingrediente]
batir [] = []
batir listaIngredientes = [ mezclar ingrediente (nuevaListaSin ingrediente listaIngredientes) | ingrediente <- listaIngredientes ]

nuevaListaSin :: Ingrediente -> [Ingrediente] -> [Ingrediente]
nuevaListaSin unIngrediente listaIngredientes = filter (/=unIngrediente) listaIngredientes


--------------------------------------

type Armadora = [Ingrediente] -> [Ingrediente]

-- directo: Los componentes del trago a armar son los mismos 
-- que los recibidos agregando un nuevo componente que es el hielo. Cada 
-- hielo ocupa 10 cc y la cantidad de hielos que debería llevar el 
-- trago se indica al momento de armarlo. Tené en cuenta que, en este caso,
-- todos los hielos juntos forman un único ingrediente.

-- fromIntegral :: (Integral a, Num b) => a -> b

directo :: Armadora
directo ingredientes = (agregarTodoMenosHielo ingredientes) ++ (agregarCantidadHielo ingredientes)

agregarTodoMenosHielo :: Armadora
agregarTodoMenosHielo = filter (not . sosHielo)

sosHielo :: Ingrediente -> Bool
sosHielo ing = (nombre ing) == "hielo"

agregarCantidadHielo :: Armadora
agregarCantidadHielo lista = [UnIngrediente "hielo" 0 0 0 (calcularCantidad lista)]

calcularCantidad :: [Ingrediente] -> Float
calcularCantidad = sum . (map cant) . sonHielos

sonHielos :: [Ingrediente] -> [Ingrediente]
sonHielos ingredientes = filter sosHielo ingredientes


--licuadora: Los ingredientes finales del trago se consiguen poniéndole azúcar,
--agregando 5 hielos y batiendo (en ese orden).
--Al ponerle azúcar todos los ingredientes se condimentan con azucar (ya declarada en el sistema).

licuadora :: Armadora
licuadora = batir . agregarHielo50 . agregarAzucar

agregarAzucar :: [Ingrediente] -> [Ingrediente]
agregarAzucar = map (condimentar azucar)

agregarHielo50 :: [Ingrediente] -> [Ingrediente]
agregarHielo50 ingredientes = ingredientes ++ [UnIngrediente "hielo" 0 0 0 50]

--coctelera: Se indica al hacer el trago si se sirve flambeado o no
--y cuántos segundos se debe agitar el trago antes de servirlo.

coctelera



coctelera :: Bool -> Float -> Armadora
coctelera True segundos (primerIngrediente:restoDeIngredientes) = (flambearIngrediente primerIngrediente segundos):restoDeIngredientes

coctelera False segundos ingredientes
| (even (truncate segundos)) = licuadora ingredientes
| otherwise = [UnIngrediente "hielo" 0 0 0 20] ++ ingredientes

flambearIngrediente :: Ingrediente -> Float -> Ingrediente
flambearIngrediente ingrediente segundos = UnIngrediente (nombre ingrediente) (dulzura ingrediente +2) ((alcohol ingrediente)/2) (color ingrediente +5) (cant ingrediente - (segundos/10))









