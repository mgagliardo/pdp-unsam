armadorasDeLaCasa::[Armadora]
armadorasDeLaCasa = armadorasConFlambera ++ armadorasSinFlambera 1

armadorasConFlambera = [ directo10, licuadora, directo5, cocteleraFlambeada10]

armadorasSinFlambera tiempo = [coctelera False tiempo] ++ armadorasSinFlambera (tiempo+1)

directo10 = directo 10
directo5 = directo 5
cocteleraFlambeada10 = coctelera True 10 

beber :: Persona -> Trago -> Persona
beber unaPersona unTrago = UnaPersona (nombrePersona unaPersona) (aumentarResistencia unaPersona) (aumentarEbriedad unaPersona unTrago) (agregarTragoAPersona unaPersona unTrago)
 
nombrePersona :: Persona -> String
nombrePersona (UnaPersona nombre _ _ _ ) = nombre

aumentarResistencia :: Persona -> Float
aumentarResistencia unaPersona = (resistencia unaPersona) + 2

aumentarEbriedad :: Persona -> Trago -> Float
aumentarEbriedad unaPersona unTrago = (ebriedad unaPersona) + (calcularPromedioEscabio unTrago)

calcularPromedioEscabio :: Trago -> Float
calcularPromedioEscabio unTrago = (calcularEscabioDeTrago unTrago) / fromIntegral (cantidadIngredientesEnTrago unTrago)

cantidadIngredientesEnTrago :: Trago -> Int
cantidadIngredientesEnTrago = length . ingredientes

calcularEscabioDeTrago :: Trago -> Float
calcularEscabioDeTrago = sum . (map alcohol) . ingredientes

agregarTragoAPersona :: Persona -> Trago -> [Trago]
agregarTragoAPersona unaPersona unTrago = [unTrago] ++ (tragos unaPersona)

nombreTrago :: Trago -> String
nombreTrago (UnTrago nombre _ ) = nombre

degustar:: Persona -> Trago -> Int -> Persona
degustar persona trago = beberVarios persona . armarNumeroDeTragos trago

beberVarios :: Persona -> [Trago] -> Persona
beberVarios unaPersona = foldl beber unaPersona

armarNumeroDeTragos:: Trago -> Int -> [Trago]
armarNumeroDeTragos trago = map (armarTrago trago) . (flip take armadorasDeLaCasa)

armarTrago:: Trago -> Armadora -> Trago
armarTrago trago armadora= UnTrago (nombreTrago trago) (armadora . ingredientes $ trago)