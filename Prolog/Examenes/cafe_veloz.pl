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
  jugador(UnJugador),
  tomo(UnJugador, Sustancia).
  not(tomo(maradona, Sustancia)),

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

puedeSerSuspendido(UnJugador) :-
  tomo(UnJugador, sustancia(UnaSustancia)),
  sustanciaProhibida(UnaSustancia).

%b.un jugador puede ser suspendido si tomó un compuesto
%que tiene una sustancia prohibida

puedeSerSuspendido(UnJugador) :-
  tomo(UnJugador, compuesto(UnCompuesto)),
  sustanciaProhibida(UnCompuesto).

%c.   o un jugador puede ser suspendido si tomó una cantidad excesiva de un producto
%(más que el máximo permitido):
%  ?- puedeSerSuspendido(X).
%  X = maradona ;
%  tomó efedrina y cafeVeloz
%  X = chamot ;
%  tomó cafeVeloz
%  X = balbo ;     
%  tomó 2 gatoreits! > 1

puedeSerSuspendido(UnJugador) :-
  tomo(UnJugador, producto(UnProducto, UnaCantidad)),
  maximo(UnProducto, UnaCantidad).



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
  puedeSerSuspendido(UnJugador),
  puedeSerSuspendido(OtroJugador),
%  puedenSerSuspendidos(UnJugador, OtroJugador),
  seConocen(UnJugador, OtroJugador).

puedenSerSuspendidos(UnJugador, OtroJugador) :-
  puedeSerSuspendido(UnJugador),
  puedeSerSuspendido(OtroJugador).

seConocen(UnJugador, OtroJugador) :-
  amigo(UnJugador, OtroJugador).

seConocen(UnJugador, OtroJugador) :-
  amigo(OtroJugador, UnJugador).
