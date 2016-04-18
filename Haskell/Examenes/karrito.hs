-- Los datos de las compras de los usuarios se mantienen en carritos individuales 
-- (un carrito es una dupla (nombrecomprador,[(producto,cantidad)])
-- Los carritos se consolidan en una lista:

carroSanti = ( "Santiago", [ ("WD TV Live", 1), ("Cable HDMI 1.3", 3) ] )

carroMatias = ( "Matias", [ ("Torre DVD", 3), ("Cartucho Epson D40",1), ("Papel adhesivo DVD", 120) ] )

carroSilvia = ( "Silvia", [ ("Monitor DELL WF424",1), ("Teclado 101",1), ("Mouse MX500",1) ] )

carroFede = ( "Fede", [ ("Cable HDMI 1.3", 1), ("Teclado 101",3) ] )

compras = [ carroSanti, carroMatias, carroSilvia, carroFede ]

-- Tenemos además la lista precio de productos:

productos = [ ("HP P1005", 526.5),("Epson C420", 415),
			  ("Toner HP 22 Black", 153.12),
			  ("Monitor DELL WF424",1322),
			  ("WD TV Live", 745.3),
			  ("Gabinete Vitsuba G240",102.94),
			  ("Cartucho Epson D40", 52.49),
			  ("Papel adhesivo DVD",0.49),
			  ("Cable HDMI 1.3",40.99),
			  ("Torre DVD", 19.99),
			  ("Teclado 101",19.50),
			  ("Mouse MX500",79)
			]

type Producto = (String, Double)
type Carrito = ( String, [Producto] )

nombreComprador (nombre, _) = nombre
productosCarrito (_, productos) = productos

nombreProducto (nombre, _) = nombre
cantidadDeProducto (_, cantidad) = cantidad

nombreProductosEnCarrito :: Carrito -> [String]
nombreProductosEnCarrito = map nombreProducto . productosCarrito 

find criterio = head . filter criterio

-- comproProducto/2, que recibe un nombre de producto y un carrito
-- y retorna True si el carrito contiene el producto:
-- >comproProducto "Torre DVD" carroFede
-- False
comproProducto :: String -> Carrito -> Bool
comproProducto nombreProducto = elem nombreProducto . nombreProductosEnCarrito

-- quienesCompraron/1, que recibe un nombre de producto y retorna los
-- nombres de las personas que compraron ese producto:
-- >quienesCompraron "Teclado 101"
-- ["Silvia","Fede"]

quienesCompraron :: String -> [String]
quienesCompraron nombreProducto = (nombresDeCompradores . filter (compradorCompro nombreProducto)) compras

compradorCompro :: String -> Carrito -> Bool
compradorCompro nombreProducto = (elem nombreProducto) . nombreProductosEnCarrito

nombresDeCompradores :: [Carrito] -> [String]
nombresDeCompradores = map nombreComprador


-- cuantoCompro/2, que recibe un nombre de producto y una dupla carrito, y
-- retorna la cantidad de ítems comprados, o cero si no compró nada
-- >cuantoCompro "Teclado 101" carroSanti
-- 0

-- >cuantoCompro "Teclado 101" carroFede
-- 3

cuantoCompro :: String -> Carrito -> Double
cuantoCompro nombreProducto unCarrito | compradorCompro nombreProducto unCarrito = snd (traerProductoConNombre nombreProducto unCarrito)
									  | otherwise = 0

traerProductoConNombre nombreProducto = find (flip productoTieneEsteNombre nombreProducto) . productosCarrito

productoTieneEsteNombre unProducto = ( nombreProducto unProducto== )


-- cantidadVendida/1, que recibe un nombre de producto y retorna el total vendido de ese producto:
-- >cantidadVendida "Teclado 101"
-- 4
-- >cantidadVendida "HP P1005"
-- 0

cantidadVendida :: String -> Double
cantidadVendida = sum . ventasTotales

ventasTotales :: String -> [Double]
ventasTotales nombreProducto = map (cuantoCompro nombreProducto) compras


-- queCompro/1, que recibe un nombre de usuario y retorna el carrito de esa persona:
-- >queCompro "Fede"
-- [("Cable HDMI 1.3", 1),("Teclado 101",3)]

queCompro :: String -> [Producto]
queCompro = productosCarrito . traerUsuarioConNombre

traerUsuarioConNombre :: String -> Carrito
traerUsuarioConNombre nombreUsuario = find (flip usuarioTieneEsteNombre nombreUsuario) compras

usuarioTieneEsteNombre unNombre = ( nombreComprador unNombre== )


-- precioDe/1, que recibe un nombre de producto y retorna el precio unitario de ese producto:
-- > precioDe "WD TV Live"
-- 745.3

precioDe :: String -> Double
precioDe = snd . traerProducto

traerProducto :: String -> Producto
traerProducto nombreProducto = find (flip productoTieneEsteNombre nombreProducto) productos


-- gastoDeUsuario/1, que recibe un nombre de usuario y retorna el gasto total de ese usuario:
-- >gastoDeUsuario "Santiago"
-- 868.27

gastoDeUsuario :: String -> Double
gastoDeUsuario nombreUsuario = sum (zipWith (*) (precioPorProducto nombreUsuario) (cantidadPorProducto nombreUsuario))

precioPorProducto :: String -> [Double]
precioPorProducto = (map precioDe) . (map nombreProducto) . queCompro

cantidadPorProducto :: String -> [Double]
cantidadPorProducto = map cantidadDeProducto . queCompro


-- mayorGastador, que retorna el nombre del usuario que gastó más.
-- >mayorGastador
-- "Silvia"
-- En este punto se puede usar recursividad.

mayorGastador :: String
mayorGastador = traerUsuarioPorGastos maximoGasto

maximoGasto :: Double
maximoGasto = maximum (map gastoDeUsuario (map nombreComprador compras))

traerUsuarioPorGastos :: Double -> String
traerUsuarioPorGastos gasto = find (flip usuarioTuvoEsteGasto gasto) (map nombreComprador compras)

usuarioTuvoEsteGasto usuario = (gastoDeUsuario usuario == )