% Autor: PDP
% Fecha: 28/05/2011

% jugadores conocidos
jugador(maradona).
jugador(chamot).
jugador(balbo).
jugador(caniggia).
jugador(passarella).
jugador(pedemonti).
jugador(basualdo).

% relaciona lo que toma cada jugador
tomo(maradona, sustancia(efedrina)).
tomo(maradona, compuesto(cafeVeloz)).
tomo(caniggia, producto(cocacola, 2)).
tomo(chamot, compuesto(cafeVeloz)).
tomo(balbo, producto(gatoreit, 2)).

% relaciona la máxima cantidad de un producto que 1 jugador puede ingerir
maximo(cocacola, 3).
maximo(gatoreit, 1).
maximo(naranju, 5).

% relaciona las sustancias que tiene un compuesto
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).

% sustancias prohibidas por la asociación
sustanciaProhibida(efedrina).
sustanciaProhibida(cocaina).


% 1) 1)	Hacer lo que sea necesario para incorporar los siguientes conocimientos:
% a) passarella no toma nada que tome maradona
% b) pedemonti toma todo lo que toma chamot y lo que toma maradona
% c) basualdo no toma coca cola.
toma(passarella, Cosa):-not(toma(maradona, Cosa)).
toma(pedemonti, Cosa):-toma(chamot, Cosa).
toma(pedemonti, Cosa):-toma(maradona, Cosa).
% c) no hay que hacer nada

% 2) Definir el predicado puedeSerSuspendido/1 que relaciona si un jugador puede ser suspendido
% en base a lo que tomó.
% - un jugador puede ser suspendido si tomó una sustancia que está prohibida
% - un jugador puede ser suspendido si tomó un compuesto que tiene una sustancia prohibida
% - o un jugador puede ser suspendido si tomó una cantidad excesiva de un producto (más que el máximo permitido)
% El predicado debe ser inversible.
puedeSerSuspendido(Jugador):-jugador(Jugador),
    tomo(Jugador, Cosa),
    todoMalCon(Cosa).

todoMalCon(sustancia(Sustancia)):-sustanciaProhibida(Sustancia).
todoMalCon(compuesto(Producto)):-composicion(Producto, Sustancias),
    sustanciaProhibida(Sustancia),
    member(Sustancia, Sustancias).
todoMalCon(producto(Producto, CantidadTomada)):-maximo(Producto, Maximo),
    CantidadTomada > Maximo.

% 3) Si agregamos los siguientes hechos
amigo(maradona, caniggia).
amigo(caniggia, balbo).
amigo(balbo, chamot).
amigo(balbo, pedemonti).

% defina el predicado malaInfluencia/2 que relaciona dos jugadores, si ambos
% pueden ser suspendidos y se conocen, ya sea:
% - porque son amigos
% - porque son amigos de otra persona que lo conoce
% En el ejemplo, maradona se conoce con caniggia, pero también con balbo, chamot y pedemonti.
% Ejemplos:
% ? malaInfluencia(maradona, Quien).
% devuelve entre otras soluciones
% Quien = chamot ;
% Quien = balbo ;
% El predicado debe funcionar a n niveles de profundidad posibles.
% El predicado debe ser inversible para ambos argumentos.
malaInfluencia(Jugador1, Jugador2):-puedeSerSuspendido(Jugador1),
   puedeSerSuspendido(Jugador2),
   seConocen(Jugador1, Jugador2).

seConocen(Jugador1, Jugador2):-amigo(Jugador1, Jugador2).
seConocen(Jugador1, Jugador2):-amigo(Jugador1, JugadorX),
   seConocen(JugadorX, Jugador2).

% 4- Agregamos ahora la lista de médicos que atiende a cada jugador
atiende(cahe, maradona).
atiende(cahe, chamot).
atiende(cahe, balbo).
atiende(zin, caniggia).
atiende(cureta, pedemonti).
atiende(cureta, basualdo).

% Definir el predicado chanta/1, que se verifica para los médicos que sólo atienden
% a jugadores que podrían ser suspendidos.
% ? chanta(X)
% X = cahe
% El predicado debe ser inversible.
chanta(Medico):-medico(Medico),
   forall(atiende(Medico, Futbolista), puedeSerSuspendido(Futbolista)).

%chantaNot(Medico):-atiende(Medico, _),
%   not(
%   (atiende(Medico, Futbolista),
%   not(puedeSerSuspendido(Futbolista)))).

% 5- Si conocemos el nivel de alteración en sangre de una sustancia con el siguiente hecho
nivelFalopez(efedrina, 10).
nivelFalopez(cocaina, 100).
nivelFalopez(extasis, 120).
nivelFalopez(omeprazol, 5).


% definir el predicado cuantaFalopaTiene/2, que relaciona el nivel de alteración en sangre que tiene
% un jugador, considerando:
% - los productos como la coca cola y el gatoreit, no tienen nivel de alteración (asumir 0)
% - las sustancias suman el nivel de alteración definido en base al predicado nivelFalopez/2
% - los compuestos suman los niveles de falopez de cada sustancia que tienen.
% Ej: el cafeVeloz tiene nivel 130 (120 del éxtasis + 10 de la efedrina, las sustancias que no tienen nivel se asumen 0)
% El predicado debe ser inversible para el primer argumento.
cuantaFalopaTiene(Jugador, Falopa):-
   jugador(Jugador),
   findall(Cantidad, (tomo(Jugador, Cosa), nivelAlteracion(Cosa, Cantidad)), Cantidades),
   sumlist(Cantidades, Falopa).

nivelAlteracion(sustancia(Sustancia), Nivel):-nivelFalopez(Sustancia, Nivel).
nivelAlteracion(producto(_), 0).
nivelAlteracion(compuesto(Compuesto), Cantidad):-composicion(Compuesto, Sustancias),
	findall(Nivel, (member(Sustancia, Sustancias), nivelFalopez(Sustancia, Nivel)), Niveles), sumlist(Niveles, Cantidad).

% 6- Definir el predicado equipoBienArmado/1, que permite relacionar una lista de jugadores
% y se satisface si todos los jugadores son amigos de los demás.


% b) Definir el predicado medicoConProblemas/1, que se satisface si un médico atiende a más de 2
% jugadores conflictivos, esto es
% - que pueden ser suspendidos
% - o que conocen a Maradona
% La consulta medicoConProblemas(X) debería devolver X = cahe.
% El predicado debe ser inversible.
medicoConProblemas(Medico):-medico(Medico),
     findall(Jugador, (atiende(Medico, Jugador), conflictivo(Jugador)), Jugadores), length(Jugadores, Cant), Cant > 2.

conflictivo(Jugador):-puedeSerSuspendido(Jugador).
conflictivo(Jugador):-seConocen(maradona, Jugador).

medico(cahe).
medico(zin).
medico(cureta).

% 7- Definir el predicado programaTVFantinesco/1, que permite armar una combinatoria
% de jugadores que pueden ser suspendidos. La consulta
% ? programaTVFantinesco(Lista)
% da como resultado
% Lista = []
% Lista = [maradona]
% Lista = [maradona, chamot]
% Lista = [maradona, chamot, balbo]
% etc.
programaTVFantinesco(JugadoresTV):-setof(Jugador, puedeSerSuspendido(Jugador), Jugadores),
      combinar(Jugadores, JugadoresTV).

combinar([], []).
combinar([Jugador|Jugadores], [Jugador|JugadoresTV]):-combinar(Jugadores, JugadoresTV).
combinar([_|Jugadores], JugadoresTV):-combinar(Jugadores, JugadoresTV).

