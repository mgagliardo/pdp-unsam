%%%TODAVIA NO FUNCIONAL%%%

precioBaseDeUnLugar(UnLugar, PrecioBase) :-
	capacidad(UnLugar, SuCapacidad),
	PrecioBase is SuCapacidad/100.

precioFinal(UnLugar, UnVendedor, PrecioFinal) :-
	vende(UnVendedor, UnLugar, Cometa),
	precioBaseDeUnLugar(UnLugar, PrecioBase),
	PrecioFinal is PrecioBase+(PrecioBase*Cometa*0.01).

asistisAdondeVende(UnaPersona, UnVendedor, UnLugar) :-
	asiste(UnaPersona, UnLugar),
	vende(UnVendedor, UnLugar, Cometa).

compra(UnaPersona, UnVendedor, UnPrecio) :-
	asistisAdondeVende(UnaPersona, UnVendedor, UnLugar),
	precioFinal(UnLugar, UnVendedor, UnPrecio).

compra(fer, UnVendedor, UnPrecio) :-
	asiste(fer, UnLugar),	
	capacidad(UnLugar, SuCapacidad),
	SuCapacidad < 50000,
	UnVendedor \= ticketek,
	compra(fer, UnVendedor, UnPrecio).