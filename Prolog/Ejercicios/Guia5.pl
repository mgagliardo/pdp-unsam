

%5.2

personaje(arya, (14, mujer)).
personaje(cersei, (34, mujer)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%5.3

personaje(arya, Personaje).
Personaje = stark(14, mujer).

personaje(cersei, Personaje).
Personaje = lannister(34, mujer).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%5.4

esStarkAdulto(Nombre) :-
    personaje(Nombre, stark(Edad, _)),
    Edad > 15.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%5.5

personajeAdulto(Nombre) :-
    personaje(Nombre, stark(Edad, _)),
    Edad > 15.
    
personajeAdulto(Nombre) :-
    personaje(Nombre, lannister(Edad, _)),
    Edad > 15.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%5.6

personajeAdulto(Nombre) :-
    personaje(Nombre, Personaje),
    esAdulto(Personaje).
    
esAdulto(stark(Edad, _)) :-
    Edad >15.
    
esAdulto(lannister(Edad, _)) :-
    Edad >15.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 5.7

esPeligroso(Nombre) :-
    personaje(Nombre, Personaje),
    esPersonajePeligroso(Personaje).
    
esPersonajePeligroso(lannister(Oro)) :-
    Oro >= 300.
    
esPersonajePeligroso(stark(_, _)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 5.8

esPersonajePeligroso(nightwatch(_,lobo(_))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 5.9



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 5.9


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 5.9
