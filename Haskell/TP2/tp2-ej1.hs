dulzuraCondimento :: Condimento -> Float
dulzuraCondimento (dulzura, _, _)   = dulzura

alcoholCondimento :: Condimento -> Float
alcoholCondimento (_, alcohol, _)   = alcohol

colorCondimento :: Condimento -> Float
colorCondimento (_, _, color)       = color

nombre :: Ingrediente -> String
nombre (UnIngrediente nombre _ _ _ _) = nombre

condimentar :: Ingrediente -> Condimento -> Ingrediente
condimentar unIngrediente unCondimento = UnIngrediente (nombre unIngrediente) (promediarDulzura unIngrediente unCondimento) (promediarAlcohol unIngrediente unCondimento) (promediarColor unIngrediente unCondimento) (cant unIngrediente)

promediarDulzura :: Ingrediente -> Condimento -> Float
promediarDulzura unIngrediente unCondimento = promediar (dulzura unIngrediente) (dulzuraCondimento unCondimento)

promediarAlcohol :: Ingrediente -> Condimento -> Float
promediarAlcohol unIngrediente unCondimento = promediar (alcohol unIngrediente) (alcoholCondimento unCondimento)

promediarColor :: Ingrediente -> Condimento -> Float
promediarColor unIngrediente unCondimento = promediar (color unIngrediente) (colorCondimento unCondimento)

promediar :: Fractional a => a -> a -> a
promediar unNum otroNum = (unNum + otroNum) / 2

mezclar :: Ingrediente -> [Ingrediente] -> Ingrediente
mezclar unIngrediente variosIngredientes = condimentar unIngrediente (construirCondimento variosIngredientes)

construirCondimento :: [Ingrediente] -> Condimento 
construirCondimento listaIngredientes = (obtenerDulzuraMax listaIngredientes, obtenerAlcoholMax listaIngredientes, obtenerColorMax listaIngredientes)

obtenerDulzuraMax :: [Ingrediente] -> Float
obtenerDulzuraMax = maximum . (map dulzura)

obtenerAlcoholMax :: [Ingrediente] -> Float
obtenerAlcoholMax = maximum . (map alcohol)

obtenerColorMax :: [Ingrediente] -> Float
obtenerColorMax = maximum . (map color)

batir :: [Ingrediente] -> [Ingrediente]
batir [] = []
batir listaIngredientes = [ mezclar ingrediente (nuevaListaSin ingrediente listaIngredientes) | ingrediente <- listaIngredientes ]

nuevaListaSin :: Ingrediente -> [Ingrediente] -> [Ingrediente]
nuevaListaSin unIngrediente listaIngredientes = filter (/=unIngrediente) listaIngredientes