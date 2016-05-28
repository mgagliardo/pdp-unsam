laMadre(Alguien) :-
    tieneParaguasAmarillo(Alguien),
    tieneUnBajo(Alguien),
    tieneLibroDeNeruda(Alguien),
    seRieConTed(Alguien).

tieneLibroDeNeruda(Alguien) :-
    tiene(Alguien, libro(pabloNeruda, _)).
    
tieneParaguasAmarillo(Alguien) :-
	tiene(Alguien, paraguas(amarillo)).
    
tieneUnBajo(Alguien) :-
    tiene(Alguien, instrumento(bajo)).

seRieConTed(Alguien) :-
	seRieCon(Alguien, ted).