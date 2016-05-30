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
tomo(chamot, compuesto(cocaina)).
tomo(balbo, producto(gatoreit, 2)).

%1)   Hacer lo que sea necesario para incorporar los siguientes conocimientos:

%a.passarella toma todo lo que no tome Maradona
tomo(pasarella, Sustancia) :-
  not(tomo(maradona, Sustancia)).

%b.pedemonti toma todo lo que toma chamot y lo que toma Maradona
tomo(pedemonti, Sustancia) :-
  tomo(chamot, Sustancia).

tomo(pedemonti, Sustancia) :-
  tomo(maradona, Sustancia).

%c.basualdo no toma coca cola
tomo(basualdo, producto(UnProducto, _)) :-
  UnProducto \= cocacola.

% relaciona la maxima cantidad de un producto que un jugador puede ingerir
maximo(cocacola, 3).
maximo(gatoreit, 1).
maximo(naranju, 5).

% relaciona las sustancias que tiene un compuesto
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).

% sustancias prohibidas por la asociación
sustanciaProhibida(efedrina).
sustanciaProhibida(cocaina).

%2)   Definir el predicado puedeSerSuspendido/1 que relaciona si un jugador puede ser
%     suspendido en base a lo que tomó. El predicado debe ser inversible.
%a.    un jugador puede ser suspendido si tomó una sustancia que está prohibida

puedeSerSuspendido(Jugador):-jugador(Jugador),
  tomo(Jugador, Cosa),
  todoMalCon(Cosa).

todoMalCon(sustancia(Sustancia)):-
  sustanciaProhibida(Sustancia).

%b.un jugador puede ser suspendido si tomó un compuesto
%que tiene una sustancia prohibida

todoMalCon(compuesto(Producto)):-
  composicion(Producto, Sustancias),
  sustanciaProhibida(Sustancia),
  member(Sustancia, Sustancias).

%c.   o un jugador puede ser suspendido si tomó una cantidad excesiva de un producto
%(más que el máximo permitido):
%  ?- puedeSerSuspendido(X).
%  X = maradona ;
%  tomó efedrina y cafeVeloz
%  X = chamot ;
%  tomó cafeVeloz
%  X = balbo ;     
%  tomó 2 gatoreits! > 1

todoMalCon(producto(Producto, CantidadTomada)):-
  maximo(Producto, Maximo),
  CantidadTomada > Maximo.

%3)   Si agregamos los siguientes hechos:

amigo(maradona, caniggia).
amigo(caniggia, balbo).
amigo(balbo, chamot).
amigo(balbo, pedemonti).

%Defina el predicado malaInfluencia/2 que relaciona dos jugadores, si ambos pueden ser
%suspendidos y además se conocen.
%Un jugador conoce a sus amigos y a los conocidos de sus amigos.
%? malaInfluencia(maradona, Quien).
%Quien = chamot ;
%Quien = balbo ;
%Quien = pedemonti ;

%(con el agregado del punto 1)
%(Maradona no es mala influencia para Caniggia porque no lo podrían suspender).

malaInfluencia(UnJugador, OtroJugador) :-
  puedenSerSuspendidos(UnJugador, OtroJugador),
  seConocen(UnJugador, OtroJugador).

puedenSerSuspendidos(UnJugador, OtroJugador) :-
  puedeSerSuspendido(UnJugador),
  puedeSerSuspendido(OtroJugador).

seConocen(UnJugador, OtroJugador) :-
  amigo(UnJugador, OtroJugador).

seConocen(UnJugador, OtroJugador) :-
  amigo(UnJugador, OtroJugadorMas),
  seConocen(OtroJugadorMas, OtroJugador).

%4)   Agregamos ahora la lista de médicos que atiende a cada jugador
atiende(cahe, maradona).
atiende(cahe, chamot).
atiende(cahe, balbo).
atiende(zin, caniggia).
atiende(cureta, pedemonti).
atiende(cureta, basualdo).

%Definir el predicado chanta/1, que se verifica para
%los médicos que sólo atienden a jugadores que
%podrían ser suspendidos. El predicado debe ser inversible
%? chanta(X).
%X = cahe

chanta(Medico):-
  forall(atiende(Medico, Futbolista),
  puedeSerSuspendido(Futbolista)).

%5)   Si conocemos el nivel de alteración en sangre
%de una sustancia con los siguientes hechos

nivelFalopez(efedrina, 10).
nivelFalopez(cocaina, 100).
nivelFalopez(extasis, 120).
nivelFalopez(omeprazol, 5).

%Definir el predicado cuantaFalopaTiene/2, que relaciona
%el nivel de alteración en sangre que tiene
%un jugador, considerando que:
%- todos los productos (como la coca cola y el gatoreit),
% no tienen nivel de alteración (asumir 0)
%- las sustancias tienen definidas el nivel de alteración
%en base al predicado nivelFalopez/2
%- los compuestos suman los niveles de falopez de cada sustancia que tienen.
%El predicado debe ser inversible en ambos argumentos.
%Ej: el cafeVeloz tiene nivel 130
%(120 del éxtasis + 10 de la efedrina, las sustancias que no tienen nivel se asumen 0).
%?- cuantaFalopaTiene(Jugador, Cantidad).
%Jugador = maradona, Cantidad = 140 ;
%tomó efedrina (10) y cafeVeloz (130)
%Jugador = chamot, Cantidad = 130 ;
%tomó cafeVeloz (130)

cuantaFalopaTiene(Jugador, Falopa):-
  jugador(Jugador),
  findall(Cantidad,
          (
            tomo(Jugador, Cosa),
            nivelAlteracion(Cosa, Cantidad)
          ),
          Cantidades),
   sumlist(Cantidades, Falopa).

nivelAlteracion(sustancia(Sustancia), Nivel):-
  nivelFalopez(Sustancia, Nivel).

nivelAlteracion(producto(_), 0).

nivelAlteracion(compuesto(Compuesto), Cantidad):-
  composicion(Compuesto, Sustancias),
	findall(Nivel,
          (
            member(Sustancia, Sustancias),
            nivelFalopez(Sustancia, Nivel)
          ),
          Niveles),
  sumlist(Niveles, Cantidad).



% 6) Definir el predicado medicoConProblemas/1
% , que se satisface si un médico atiende a más de 2
% jugadores conflictivos, esto es
% -     que pueden ser suspendidos o
% -     que conocen a Maradona (según el punto 3, donde son amigos directos o conocen a
% alguien que es amigo de él). El predicado debe ser in
% versible.
% ? medicoConProblemas(X).
% X = cahe

maximoJugadoresConflictivos(2).

medico(cahe).
medico(zin).
medico(cureta).

medicoConProblemas(Medico) :-
  medico(Medico),
  maximoJugadoresConflictivos(CantMax),
  findall(Futbolista,
            (atiendeJugadorConflictivo(Medico, Futbolista)),
          Futbolistas),
  length(Futbolistas, Cant),
  Cant > CantMax.

atiendeJugadorConflictivo(Medico, Futbolista) :-
  atiende(Medico, Futbolista),
  jugador(Futbolista),
  esConflictivo(Futbolista).

esConflictivo(Futbolista) :-
  puedeSerSuspendido(Futbolista).

esConflictivo(Futbolista) :-
  seConocen(Futbolista, maradona).

esConflictivo(Futbolista) :-
  seConocen(maradona, Futbolista).

% 7- Definir el predicadoprogramaTVFantinesco/1
% , que permite armar una combinatoria de jugadores que pueden ser suspendidos. Ej:
% ? programaTVFantinesco(Lista)
% Lista = []
%Lista = [maradona]
%Lista = [maradona, chamot]
%Lista = [maradona, chamot, balbo]
%
% No importa si aparece más de una vez Maradona en su solución.

predicadoprogramaTVFantinesco(Lista) :-
  findall(Futbolista,
            (jugador(Futbolista),
            puedeSerSuspendido(Futbolista)),
            Lista).
