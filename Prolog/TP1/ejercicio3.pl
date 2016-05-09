fanatico(fer).
fanatico(nico).

teGustaUnaSolaBanda(UnaPersona) :-
	aggregate_all(count, escucha(UnaPersona, UnaBanda), Count),
	Count = 1.

tocaUnaBandaQueEscuchas(UnaPersona, UnLugar) :-
	escucha(UnaPersona, UnaBanda),
	toca(UnaBanda, UnLugar).

tocaTuBanda(UnaPersona, UnLugar) :-
	tocaUnaBandaQueEscuchas(UnaPersona, UnLugar),
	teGustaUnaSolaBanda(UnaPersona).

elEquipoQueTeGustaJuegaDeLocal(UnaPersona, UnLugar) :-
	juega(UnaPersona, UnDeporte),
	hincha(UnaPersona, UnEquipo),
	partido(UnDeporte, UnEquipo, _, UnLugar).

vasDeVisitaPorqueSosFanatico(UnaPersona, UnLugar) :-
	fanatico(UnaPersona),
	juega(UnaPersona, UnDeporte),
	hincha(UnaPersona, UnEquipo),
	partido(UnDeporte, _, UnEquipo, UnLugar).

asiste(UnaPersona, UnLugar) :-
	tocaTuBanda(UnaPersona, UnLugar);
	elEquipoQueTeGustaJuegaDeLocal(UnaPersona, UnLugar);
	vasDeVisitaPorqueSosFanatico(UnaPersona, UnLugar).