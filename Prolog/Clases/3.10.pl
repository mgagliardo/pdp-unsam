%%%% EJERCICIO 3.10 %%%%

puntajeTotal(Participante, Puntaje) :-
	todosPuntajesSuperan(Participante),
	sumaTotal(Participante, Puntaje).

puntajeTotal(Participante, 0) :-
	esParticipante(Participante),
	not(todosPuntajesSuperan(Participante)).

esParticipante(Participante) :-
	puntajeLanzamientoPrecision(Participante, _).

esParticipante(Participante) :-
        puntajeFuerzaMartillo(Participante, _).

esParticipante(Participante) :-
	puntajeEquilibrioEscoba(Participante, _).


todosPuntajesSuperan(Participante) :-
	lanzamientoSupera(Participante),
	martilloSupera(Participante),
	escobaSupera(Participante).

superaMax(Puntaje) :-
	cotaMax(Max),
	Puntaje >= Max.

cotaMax(5).

lanzamientoSupera(Participante) :-
	puntajeLanzamientoPrecision(Participante, PuntajeLanzamiento),
    	superaMax(PuntajeLanzamiento).

martilloSupera(Participante) :-
	puntajeFuerzaMartillo(Participante, PuntajeMartillo),
        superaMax(PuntajeMartillo).

escobaSupera(Participante) :-
	puntajeEquilibrioEscoba(Participante, PuntajeEscoba),
        superaMax(PuntajeEscoba).

sumaTotal(Participante, Puntaje) :-
        puntajeEquilibrioEscoba(Participante, PuntajeEscoba),
        puntajeFuerzaMartillo(Participante, PuntajeMartillo),
        puntajeLanzamientoPrecision(Participante, PuntajeLanzamiento),
	Puntaje is PuntajeLanzamiento + PuntajeMartillo + PuntajeEscoba.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
