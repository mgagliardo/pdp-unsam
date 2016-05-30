anio(2016).
persona(homero, 1980).
persona(marge, 1982).
persona(bart, 2006).
persona(hugo, 2006).
persona(lisa, 2008).
persona(maggie, 2015).
persona(abe,1950).
persona(herbert, 1975).

edad(Persona, Edad) :-
    anio(AnioActual),
    persona(Persona, AnioNacimiento),
    Edad is AnioActual - AnioNacimiento.

padre(homero, bart).
padre(homero, lisa).
padre(homero, maggie).
padre(homero, hugo).
padre(abe, homero).


abuelo(Abuelo, Nieta) :-
    padre(Padre, Nieta),
    padre(Abuelo, Padre).

% Otra forma
%abuelo(Abuelo, Nieta) :-
%    padre(Abuelo, Padre),
%    padre(Padre, Nieta).

fueAbandonado(herbert).
fueAbandonado(hugo).


%tienePeloNormal(Alguien) :-
%    persona(Alguien, _), 
%    not(padre(Alguien, _)).

tienePelo(Alguien) :-
    persona(Alguien, _),
    Alguien \= homero,
    Alguien \= abe.

tienePeloNormal(Alguien) :-
    tienePelo(Alguien),
    not(padre(Alguien, _)).


%----

buenaNota(Nota) :-
    between(4,10,Variable).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% CLASE 3 %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

come(homero, [donas, langosta, chuleta]).
come(bart, [dulces]).
come(lisa, [ensalada]).
come(maggie, []).

puedeComer(Persona, Comida) :-
	come(Persona, Comidas),
	member(Comida, Comidas).	


%esGloton cuando come 2 comidas o dulces.

esGloton(Persona) :-
	puedeComer(Persona, dulces).

esGloton(Persona) :-
	come(Persona, Comidas),
	length(Comidas, Cantidad),
	Cantidad > 2.


%Nivel de irritabilidad de una persona, que es la suma de los años de sus hijos.

nivelDeIrritabilidad(Persona, Irritabilidad) :-
	todasLasEdadesDeHijos(Persona, Edades),
	sumatoria(Edades, Irritabilidad).

%FINDALL
todasLasEdadesDeHijos(Persona, Edades) :-
	padre(Persona, _),
	findall(Edad, edadDeHijo(Persona, Edad), Edades).	

edadDeHijo(Persona, EdadHijo) :-
	padre(Persona, Hijo),
	edad(Hijo, EdadHijo).

%RECURSIVIDAD
sumatoria([], 0).

sumatoria([N|Ns], Total) :-
	sumatoria(Ns, Subtotal),
	Total is N + Subtotal.

transporte(auto(5, 4)).
transporte(bondi(20, 6)).
transporte(tren([locomotora, vagon(40, 10), vagon(40, 8), vagon(20, 8)])).
transporte(avion(80, 3)).


%Un transporte daña la capa de ozono cuando tiene mas de 3 ruedas

daniaLaCapaDeOzono(Transporte) :-
	transporte(Transporte),
	cantidadDeRuedas(Transporte, CantidadDeRuedas),
	CantidadDeRuedas > 4.

cantidadDeRuedas(auto(_, CantRuedas), CantRuedas).

cantidadDeRuedas(bondi(_, CantRuedas), CantRuedas).

cantidadDeRuedas(tren(Vagones), CantRuedas) :-
	findall(Rueda, ruedasVagones(Vagones, Ruedas), RuedasTotales),
	sumatoria(RuedasTotales, CantRuedas).

cantidadDeRuedas(vagon(_, CantRuedas), CantRuedas).

cantidadDeRuedas(locomotora, 0).

ruedasVagones(Vagones, Ruedas) :-
	member(Vagon, Vagones),
	cantidadDeRuedas(Vagon, Ruedas).
 