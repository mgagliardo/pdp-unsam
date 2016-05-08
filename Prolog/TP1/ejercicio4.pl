precioBaseDeUnLugar(UnLugar, PrecioBase) :-
	capacidad(UnLugar, Capacidad),
	PrecioBase is Capacidad/100.

porcentajeDeComision(PrecioBase, Cometa, Porcentaje) :-
	Porcentaje is PrecioBase*Cometa/100.

precioFinal(UnLugar, PrecioQuePagaLaPersona, UnVendedor) :-
	vende(UnVendedor, UnLugar, Comision),
	precioBaseDeUnLugar(UnLugar, PrecioBase),
	porcentajeDeComision(PrecioBase, Comision, Porcentaje),
	PrecioQuePagaLaPersona is PrecioBase + Porcentaje.

pretenciones(fer, UnVendedor, UnLugar):-
	capacidad(UnLugar, Capacidad),
	Capacidad =< 50000,
	vende(UnVendedor, UnLugar, _),
	UnVendedor \= ticketek.

compra(UnaPersona, UnVendedor, PrecioQuePagaLaPersona) :-
	asiste(UnaPersona, UnLugar),
	precioFinal(UnLugar, PrecioQuePagaLaPersona, UnVendedor),
	UnaPersona \= fer.

compra(UnaPersona, UnVendedor, PrecioQuePagaLaPersona) :-
	precioFinal(UnLugar, PrecioQuePagaLaPersona, UnVendedor),
	pretenciones(UnaPersona, UnVendedor, UnLugar).