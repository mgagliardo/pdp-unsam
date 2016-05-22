elMejor(Alguien) :-
	edad(Alguien, EdadDeAlguien),
	forall(edad(_, Edad), EdadDeAlguien =< Edad).