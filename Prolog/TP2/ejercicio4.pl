profesion(ted, arquitecto).
profesion(lily, maestra).
profesion(lily, consultoraDeArte).
profesion(marshall, abogado).
profesion(robin, periodista).

laMadre(Alguien) :-
    tieneParaguasAmarillo(Alguien),
    tieneUnBajo(Alguien),
    tieneLibroDeNeruda(Alguien),
    seRieConTed(Alguien).

tieneLibroDeNeruda(Alguien) :-
    tiene(Alguien, libro(pabloNeruda, _)).
    
tieneParaguasAmarillo(Alguien) :-
	tiene(Alguien, paraguas(amarillo)).
    
tieneUnBajo(Alguien) :-
    tiene(Alguien, instrumento(bajo)).

seRieConTed(Alguien) :-
	seRieCon(Alguien, ted).





%Ted comenta que Barney siempre dice 
%"new is always better" (lo nuevo siempre es mejor).

%Por lo tanto tenés que escribir un 
%predicado elMejor/1 que se verifica 
%para un idividuo si es el que menos antigüedad tiene.

edad(ted, 34).
edad(marshall, 34).
edad(cabra, 18).
edad(jackDaniels, 18).

elMejor(Alguien) :-
	edad(Alguien, EdadDeAlguien),
	forall(edad(_, Edad), EdadDeAlguien =< Edad).





malDia(UnaPersona, UnaFecha) :-
	forAll(eventosMalos(UnaPersona, UnaFecha, EventosMalos), 
		EventosMalos >= 2).

eventosMalos(UnaPersona, UnaFecha, EventosMalos) :-
    tuvoCumpleMalo(UnaPersona, UnaFecha),
    tuvoChisteMalo(UnaPersona, UnaFecha).

tuvoCumpleMalo(UnaPersona, UnaFecha) :-
    evento(UnaPersona, Cumpleanios, UnaFecha),
    cumpleEsMalo(Cumpleanios).

tuvoChisteMalo(UnaPersona, UnaFecha) :-
    evento(UnaPersona, Chiste, UnaFecha),
    chisteEsMalo(Chiste).

chisteEsMalo(chiste(_, _, Reidores)) :-
	length(Reidores, Cantidad),
	Cantidad == 0.

cumpleEsMalo(cumpleanios(_, InvitadosQueAsistieron)) :-
    member(barney, InvitadosQueAsistieron).
















