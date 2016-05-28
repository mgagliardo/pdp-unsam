anio(2016).
persona(homero, 1980).
persona(marge, 1982).
persona(bart, 2006).
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
