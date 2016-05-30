% Autor:  Fernando Dodino
% Fecha: 13/10/2010

% Base de conocimientos
dentista(pereyra).
dentista(deLeon).
dentista(cureta).
dentista(patolinger).
dentista(saieg).
% porcentaje que se cobra a clínicas asociadas
clinica(odontoklin, 80).

% costo de servicios por obra social
costo(osde, tratamientoConducto, 200).
costo(omint, tratamientoConducto, 250).
% costo de servicios por atención a particulares
costo(tratamientoConducto, 1200).

puedeAtenderA(pereyra, pacienteObraSocial(karlsson, 1231, osde)).
puedeAtenderA(pereyra, pacienteParticular(rocchio, 24)).
puedeAtenderA(deLeon, pacienteClinica(dodino, odontoklin)).

% Punto 1
puedeAtenderA(cureta, pacienteParticular(_, Edad)):-Edad > 60.	
puedeAtenderA(cureta, pacienteClinica(_, sarlanga)).

puedeAtenderA(patolinger, Paciente):-puedeAtenderA(pereyra, Paciente).
puedeAtenderA(patolinger, Paciente):-not(puedeAtenderA(deLeon, Paciente)).

puedeAtenderA(saieg, _).

% Predicado generador sobre paciente
paciente(pacienteObraSocial(karlsson, 1231, osde)).
paciente(pacienteParticular(rocchio, 24)).
paciente(pacienteClinica(dodino, odontoklin)).

% Punto 2
precio(pacienteObraSocial(_, _, ObraSocial), Servicio, Precio):-
   costo(ObraSocial, Servicio, Precio).

precio(pacienteParticular(_, Edad), Servicio, Precio):-
   costo(Servicio, PrecioBase), aplicarRecargo(PrecioBase, Edad, Precio).

precio(pacienteClinica(_, Clinica), Servicio, Precio):-
   costo(Servicio, PrecioOriginal),
   clinica(Clinica, Porcentaje),
   Precio is PrecioOriginal * Porcentaje / 100.

aplicarRecargo(PrecioBase, Edad, PrecioBase):-not(Edad > 45).
aplicarRecargo(PrecioBase, Edad, Precio):-Edad > 45, Precio is PrecioBase + 50.

% Punto 3
servicioRealizado(fecha(10, 11, 2010), pereyra,  
   servicio(tratamientoConducto, pacienteObraSocial(karlsson, 1231, osde))).
servicioRealizado(fecha(16, 11, 2010), pereyra,   
   servicio(tratamientoConducto, pacienteClinica(dodino, odontoklin))).
servicioRealizado(fecha(21, 12, 2010), deLeon,    
   servicio(tratamientoConducto,  pacienteObraSocial(karlsson, 1231, osde))).

montoFacturacion(Dentista, Mes, Total):-
   dentista(Dentista),
   findall(Monto,(servicioRealizado(fecha(_, Mes, _), Dentista, servicio(Servicio, Paciente)), precio(Paciente, Servicio, Monto)), Montos),
   sumlist(Montos, Total).

% Punto 4
dentistaCool(Dentista):-dentista(Dentista),
   forall(servicioRealizado(_, Dentista, servicio(_, Paciente)), 
          interesante(Paciente)).

interesante(pacienteObraSocial(Paciente, Carnet, ObraSocial)):- 
   precio(pacienteObraSocial(Paciente, Carnet, ObraSocial), tratamientoConducto, Precio),  
   Precio > 1000.

interesante(pacienteParticular(_,_)).

% Punto 5
confia(pereyra, deLeon).
confia(cureta, pereyra).

atiendeDeUrgenciaA(Dentista, Paciente):-dentista(Dentista),
   paciente(Paciente), puedeAtenderA(Dentista, Paciente).
atiendeDeUrgenciaA(Dentista, Paciente):-confia(Dentista,
   OtroDentista), atiendeDeUrgenciaA(OtroDentista, Paciente).

% Punto 6
serviciosCaros(osde, [tratamientoConducto, implanteOseo]).

pacienteAlQueLeVieronLaCara(Paciente):-
   paciente(Paciente), forall(servicioRealizado(_, _, servicio(Servicio, Paciente)), servicioCaro(Servicio, Paciente)).

servicioCaro(Servicio, pacienteObraSocial(_, _, ObraSocial)):-
   serviciosCaros(ObraSocial, ServiciosCaros), 
   member(Servicio, ServiciosCaros).

servicioCaro(Servicio, pacienteParticular(Nombre, Edad)):-
   precio(Servicio, pacienteParticular(Nombre, Edad), Precio), 
   Precio > 500.

% Punto 7
serviciosMalHechos(Dentista, ServiciosMalHechos):-
   dentista(Dentista),
   findall(Servicio, servicioMalHecho(Servicio, Dentista), ServiciosMalHechos).

servicioMalHecho(Servicio, Dentista):-
  servicioRealizado(fecha(_, Mes, _), Dentista, servicio(Servicio, Paciente)),
  MesSiguiente is Mes + 1,
  servicioRealizado(fecha(_, MesSiguiente, _), _,servicio(Servicio, Paciente)).







