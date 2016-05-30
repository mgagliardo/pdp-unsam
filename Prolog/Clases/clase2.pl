anio(2016).
persona(homero, 1980).
persona(marge, 1982).
persona(bart, 2006).
persona(hugo, 2006).
persona(lisa, 2008).
persona(maggie, 2015).
persona(abe, 1950).
persona(herbert, 1981).

padre(marge, bart).
padre(marge, lisa).
padre(marge, maggie).
padre(marge, hugo).
padre(homero, bart).
padre(homero, lisa).
padre(homero, maggie).
padre(homero, hugo).
padre(abe, homero).
padre(abe, herbert).

edad(Persona, Edad) :-
  anio(AnioActual),
  persona(Persona, AnioNacimiento),
  Edad is AnioActual - AnioNacimiento.

abuelo(Abuelo, Nieta) :-
  padre(Abuelo, Padre),
  padre(Padre, Nieta).

fueAbandonado(herbert).
fueAbandonado(hugo).

tienePeloNormal(Alguien) :-
  tienePelo(Alguien),
  not(padre(Alguien, _)).

tienePelo(Alguien) :-
  persona(Alguien, _),
  Alguien \= homero,
  Alguien \= abe.
























% color/1 :: String -> String
% color "cielo" = "azul"
% color "sol" = "amarillo"
% color "nube" = "blanco"

% color/2
color(cielo, azul).
color(sol, amarillo).
color(nube, blanco).
