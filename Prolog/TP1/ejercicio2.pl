sonRivales(UnEquipo, OtroEquipo) :-
	rivales(UnEquipo, OtroEquipo);
	rivales(OtroEquipo, UnEquipo).

hinchanPorEquiposRivales(UnaPersona, OtraPersona) :-
	hincha(UnaPersona, UnEquipo),
	hincha(OtraPersona, OtroEquipo),
	sonRivales(UnEquipo, OtroEquipo).

escuchanLaMismaBanda(UnaPersona, OtraPersona) :-
	escucha(UnaPersona, UnaBanda),
	escucha(OtraPersona, UnaBanda).

practicanElMismoJuego(UnaPersona, OtraPersona) :-
	juega(UnaPersona, UnJuego),
	juega(OtraPersona, UnJuego).

enemigos(UnaPersona, OtraPersona) :-
	hinchanPorEquiposRivales(UnaPersona, OtraPersona),
	not(escuchanLaMismaBanda(UnaPersona, OtraPersona)),
	not(practicanElMismoJuego(UnaPersona, OtraPersona)).