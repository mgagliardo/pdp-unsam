%9.1

esPeligroso(Personaje) :-
    haceActividadPeligrosa(Personaje).

esPeligroso(Personaje) :-
    tieneEmpleadosPeligrosos(Personaje).

haceActividadPeligrosa(Personaje) :-
    personaje(Personaje, Actividad),
    actividadPeligrosa(Actividad).
    
actividadPeligrosa(mafioso(maton)).
    
actividadPeligrosa(ladron(Choreos))
    member(licorerias, Choreos).

tieneEmpleadosPeligrosos(Personaje),
    trabajaPara(Personaje, Empleado),
    esPeligroso(Empleado).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%9.2

duoTemible(UnPersonaje, OtroPersonaje) :-
    esPeligroso(UnPersonaje),
    esPeligroso(OtroPersonaje),
    parejaOAmigos(UnPersonaje, OtroPersonaje).
    
parejaOAmigos(UnPersonaje, OtroPersonaje) :-
    pareja(UnPersonaje, OtroPersonaje).

parejaOAmigos(UnPersonaje, OtroPersonaje) :-
    pareja(OtroPersonaje, UnPersonaje).
    
parejaOAmigos(UnPersonaje, OtroPersonaje) :-
    amigo(UnPersonaje, OtroPersonaje).

parejaOAmigos(UnPersonaje, OtroPersonaje) :-
    amigo(OtroPersonaje, UnPersonaje).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%9.3

estaEnProblemas(butch).

estaEnPeroblemas(Persona) :-
    encargo(_, Persona, buscar(Alguien, _)),
        personaje(Alguien, boxeador).

estaEnProblemas(Personaje) :-
    trabajaPara(Jefe, Persona),
    esPeligroso(Jefe),
    pareja(Jefe, Pareja),
    encargo(Jefe, Persona, cuidar(Pareja)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%9.4

sanCayetano(Alguien) :-
    loTieneCerca(Alguien, _),
    forall(loTieneCerca(Alguien, Encargado), 
    	encargo(Alguien, Encargado, _)).

loTieneCerca(Alguien, Encargado) :-
    amigo(Alguien, Encargado).
    
loTieneCerca(Alguien, Encargado) :-
    trabajaPara(Alguien, Encargado).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%9.5

elMasAtareado(Persona) :-
    cantidadEncargos(Persona, CantidadMax),
    forall(cantidadEncargos(_, Cantidad),
        Cantidad =< CantidadMax).

cantidadEncargos(Personaje, Cantidad) :-
    encargo(_, Personaje, _),
    findall(Tarea, encargo(_, Personaje, Tarea), Tareas),
    length(Tareas, Cantidad).