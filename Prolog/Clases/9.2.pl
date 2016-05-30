amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

pareja(marsellus, mia).
pareja(pumkin, honeyBunny).

duoTemible(UnPersonaje, OtroPersonaje) :-
    esPeligroso(UnPersonaje),
    esPeligroso(OtroPersonaje),
    esPareja(UnPersonaje, OtroPersonaje).

duoTemible(UnPersonaje, OtroPersonaje) :-
    esPeligroso(UnPersonaje),
    esPeligroso(OtroPersonaje),
    esAmigo(UnPersonaje, OtroPersonaje).

esPareja(UnPersonaje, OtroPersonaje) :-
    pareja(UnPersonaje, OtroPersonaje);
    pareja(OtroPersonaje, UnPersonaje).

esAmigo(UnPersonaje, OtroPersonaje) :-
    amigo(UnPersonaje, OtroPersonaje);
    amigo(OtroPersonaje, UnPersonaje).
    