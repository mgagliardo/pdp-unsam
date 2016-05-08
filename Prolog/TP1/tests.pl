rivales(boca, river).
rivales(sanLorenzo, huracan).

hincha(fer, boca).
hincha(nico, river).
hincha(tato, newells).

partido(futbol, boca, river, bombonera).
partido(basquet, velez, river, fortin).
partido(futbol, racing, newells, cilindro).
partido(futbol, river, boca, monumental).

toca(sigRagga, lunaPark).
toca(zonaGanjah, lunaPark).
toca(sigRagga, bombonera).
toca(elBordo, lunaPark).
toca(viejasLocas, fortin).
toca(sigRagga, fortin).

vende(topshow, lunaPark, 8).
vende(ticketek, bombonera, 10).
vende(ticketek, fortin, 10).
vende(bombonera, bombonera, 0).

capacidad(lunaPark, 10000).
capacidad(bombonera, 50000).
capacidad(fortin, 49000).
capacidad(monumental, 65000).


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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

fanatico(fer).
fanatico(nico).

teGustaUnaSolaBanda(UnaPersona) :-
	aggregate_all(count, escucha(UnaPersona, UnaBanda), Count),
	Count = 1.

tocaUnaBandaQueEscuchas(UnaPersona, UnLugar) :-
	escucha(UnaPersona, UnaBanda),
	toca(UnaBanda, UnLugar).

tocaTuBanda(UnaPersona, UnLugar) :-
	tocaUnaBandaQueEscuchas(UnaPersona, UnLugar);
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



precioBaseDeUnLugar(UnLugar, PrecioBase) :-
	capacidad(UnLugar, Capacidad),
	PrecioBase is Capacidad/100.


	precioBaseDeUnLugar(UnLugar, PrecioBase),

compra(UnaPersona, UnVendedor, PrecioFinal) :-
	asiste(UnaPersona, UnLugar),
	vende(UnVendedor, UnLugar, Comision),
	precioFinal(UnLugar, PrecioFinal, Comision).




Nos piden averiguar qué persona compra entrada, a quién y a qué precio,
 por medio de un predicado compra/3 que relaciona una persona, 
 un vendedor y un precio respectivamente, sabiendo que:

    Cada lugar tiene un precio base que se calcula como la capacidad / 100.

    A ese precio base se le suma el porcentaje de comisión 
    (sobre el mismo precio base) del vendedor para ese lugar, 
    obteniendo así el precio final de la entrada.

    Las personas le compran a cualquier vendedor que venda entradas 
    para cualquier lugar que asistan. Excepto fer, quien no 
    compra entradas en ticketek ni para aquellos lugares cuya capacidad superen las 50000 personas.

    Editor
    Consola






%precioBaseDeUnLugar(UnLugar, PrecioBase) :-
%	capacidad(UnLugar, SuCapacidad),
%	PrecioBase is SuCapacidad/100.

%precioFinal(UnLugar, PrecioQuePagaLaPersona, Cometa) :-
%	precioBaseDeUnLugar(UnLugar, PrecioBase),
%	PrecioQuePagaLaPersona is PrecioBase+PrecioBase*Cometa/100.

%compra(UnaPersona, UnVendedor, PrecioQuePagaLaPersona) :-
%	UnaPersona \= fer,
%	asiste(UnaPersona, UnLugar),	
%	vende(UnVendedor, UnLugar, Cometa),
%	precioFinal(UnLugar, PrecioQuePagaLaPersona, Cometa).

%compra(fer, UnVendedor, PrecioQuePagaLaPersona) :-
%	asiste(fer, UnLugar),
%	capacidad(UnLugar, SuCapacidad),
%	SuCapacidad =< 50000,
%	UnVendedor \= ticketek,
%	vende(UnVendedor, UnLugar, Cometa),
%	precioFinal(UnLugar, PrecioQuePagaLaPersona, Cometa).