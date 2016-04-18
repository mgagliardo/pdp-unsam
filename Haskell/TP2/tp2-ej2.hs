nombre :: Ingrediente -> String
nombre (UnIngrediente nombre _ _ _ _) = nombre

directo :: Float -> Armadora
directo cantidadHielo ingredientes = agregarHielo cantidadHielo ingredientes

agregarHielo :: Float -> [Ingrediente] -> [Ingrediente]
agregarHielo cantidad ingredientes = [ UnIngrediente "hielo" 0 0 0 (cantidad*10) ] ++ ingredientes

licuadora :: Armadora
licuadora = batir . (agregarHielo 5) . agregarAzucar

agregarAzucar :: [Ingrediente] -> [Ingrediente]
agregarAzucar = map (flip condimentar azucar)

coctelera :: Bool -> Float -> Armadora
coctelera True segundos (primerIngrediente:restoDeIngredientes) = (flambearIngrediente primerIngrediente segundos):restoDeIngredientes

coctelera False segundos ingredientes   | (even (truncate segundos)) = licuadora ingredientes
                                        | otherwise = directo 2 ingredientes

flambearIngrediente :: Ingrediente -> Float -> Ingrediente
flambearIngrediente ingrediente segundos = UnIngrediente (nombre ingrediente) (dulzura ingrediente +2) ((alcohol ingrediente) * 0.5) (color ingrediente +5) (cant ingrediente - diezPorCiento segundos)

diezPorCiento segundos = fromIntegral (truncate (segundos*0.1))