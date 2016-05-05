escucha(nahue, losPiojos).
escucha(nahue, zonaGanjah).
escucha(nahue, sigRagga).
escucha(fer, manuChao).



escucha(javi, elBordo).

juega(fer, futbol).
juega(nico, basquet).
juega(tato, futbol).
juega(tato, hearthstone).

juega(javi,UnJuego) :-
	escucha(Alguien, sigRagga),
	juega(Alguien, UnJuego).

juega(javi, UnJuego) :-
	juega(fer, UnJuego).
