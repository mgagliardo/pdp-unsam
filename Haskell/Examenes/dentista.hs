-- Cada tupla representa: 
-- > El nombre del paciente (que no puede repetirse con otro, cada nombre es único) 
-- > Una tupla día / mes / año que modela la fecha de nacimiento 
-- > Qué obra social tiene 
-- > La lista de servicios o tratamientos que el dentista lepracticó 
-- Por otra parte se tiene el monto de cada servicio por obra social: 

pacientes = [ ("karl",(10,10,1993), "OSDE", [ "Conducto", "Puente" ]), 
              ("achi",(18,11,1987), "Swiss med", []), 
              ("mike",(12,04,1978), "OSDE", [ "Limpieza" ])
            ]

-- El formato que sigue la tupla es: 
-- > Nombre de la obra social 
-- > Servicio 
-- > Valor que la obra social le paga al dentista 
-- Se cuenta con estas funciones: 

precios = [ ("OSDE", "Conducto", 100), ("OSDE", "Puente", 50), 
    		("OSDE", "Limpieza", 60), ("Swiss medical", "Conducto", 30),  
    		("Swiss med", "Puente", 50), ("Swiss med", "Limpieza",60)
          ]

servicios (_, _, _, s) = s 
paciente (p, _, _, _) = p 
anio (_, _, a) = a
obraSocial (_, _, os, _) = os 
fechaNacimiento (_, f, _, _) = f 
find criterio = head . filter criterio

-- Encontrar un paciente en la lista por el nombre
-- >datosDe "karl"  
-- ("karl",(10,10,1993), "OSDE", ["Conducto", "Puente"])

type Paciente = (String, Fecha, String, [String])
type Fecha = (Int, Int, Int)
type Facturacion = (String, String, Int)

nombreObraSocial (n, _, _) = n
servicioObraSocial (_, t, _) = t
cuantoPagaObraSocial (_, _, c) = c


datosDe :: String -> Paciente
datosDe nombrePaciente = find (flip pacienteTieneEsteNombre nombrePaciente) pacientes

pacienteTieneEsteNombre unPaciente = (paciente unPaciente ==)


-- Conocer el monto de facturación de un paciente, o sea, lo que el dentista 
-- le facturó a la obra social por los servicios / tratamientos que le dio:
-- >montoFacturacionDe "karl"  
-- 150 (100 del conducto + 50 del puente según paga OSDE)


montoFacturacionDe nombrePaciente = sum (tratamientos nombrePaciente)
 
tratamientos nombrePaciente = (obraSocialPaciente nombrePaciente)

obraSocialPaciente = obraSocial . datosDe