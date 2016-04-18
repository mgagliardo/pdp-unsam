instance Show (a -> b) where
	show _ = "<function>"



tomaCuatro = take 4

primerosNLetras = flip take ['a'..'z']

aplicarInversa valor f = f valor



esMultiploDe = (\n -> (\m -> ((== 0) . mod n) m))






nombreVariableValido nombre = all (\char -> elem char ['a'..'z']) nombre





data CuentaBancaria = Caja Float deriving (Show, Eq)

depositar monto (Caja actual) = Caja (actual + monto)
extraer monto (Caja actual) = Caja (actual - monto)

cajaPobre = Caja 0

chequesACobrar = [100, 150.5, 2301] :: [Float]

cobrarTodo :: CuentaBancaria -> [Float] -> CuentaBancaria

cobrarTodo cajaInicial cheques = foldl (\caja cheque -> depositar cheque caja) cajaInicial cheques

cobrarTodo' = foldl (flip depositar)


cobrarTodo'' caja cheques = depositar (sum cheques) caja



















