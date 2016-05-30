% Un servicio de delivery de comidas cuenta con información sobre platos con los que se pueden
% armar menúes. La información es esta:
% 1. componentes de cada plato, p.ej.

componente(milanesa,ingrediente(pan,3)).
componente(milanesa,ingrediente(huevo,2)).
componente(milanesa,ingrediente(carne,2)).
componente(ensMixta,ingrediente(tomate,2)).
componente(ensMixta,ingrediente(cebolla,1)).
componente(ensMixta,ingrediente(lechuga,2)).
componente(ensFresca,ingrediente(huevo,1)).
componente(ensFresca,ingrediente(remolacha,2)).
componente(ensFresca,ingrediente(zanahoria,1)).
componente(budinDePan,ingrediente(pan,2)).
componente(budinDePan,ingrediente(caramelo,1)).



% 2. calorías de cada ingrediente posible, por unidad de medida usada para definir la
% composición de los platos, p.ej.

calorias(pan,30).
calorias(tomate,22).
calorias(cebolla,20).
calorias(huevo,18).
calorias(lechuga,13).
calorias(carne,40).
calorias(caramelo,170).

% 3. para cada plato, si es entrada, principal o postre, p.ej.

esPlatoPrincipal(milanesa).
esEntrada(ensFresca).
esEntrada(ensMixta).
esPostre(budinDePan).

% Observamos que aparecen dos conceptos distintos, el de plato (p.ej. milanesa), y el de ingrediente
% (p.ej. pan). Los ingredientes sirven para armar platos, los platos son los que se puede incluir en un
% menú.
% A partir de esta información, definir los siguientes predicados. La información que se agrega en el
% punto a. puede ser usada en los siguientes.
% En todos los casos, los ejemplos se refieren a los hechos listados arriba.


% a. Lo que haga falta para agregar a la información disponible qué proveedores pueden proveer
% qué ingredientes.
% P.ej. podríamos tener un proveedor Disco que provee pan, caramelo, carne y cebolla.

provee(disco, pan).
provee(disco, caramelo).
provee(disco, carne).
provee(disco, cebolla).

provee(carrefour, huevo).
provee(carrefour, lechuga).

% b. composición/2 que relaciona un plato con la lista de componentes necesarios para su
% preparación.
% ?- composicion(milanesa,X).
% X = [ingrediente(pan, 3),ingrediente(huevo, 2),ingrediente(carne, 2)]

plato(milanesa).
plato(ensFresca).
plato(ensMixta).
plato(budinDePan).

composicion(Plato, ListaIngredientes) :-
  plato(Plato),
  findall(Ingrediente,
          componente(Plato, Ingrediente),
          ListaIngredientes
        ).


% c.caloriasTotal/2, que relaciona un plato con su cantidad total de calorías por porción.
% Las calorías de un plato se calculan a partir de sus ingredientes.
% P.ej. la milanesa tiene 206 calorías (30 * 3 + 18 * 2 + 40 * 2) por porción.

caloriasTotal(Plato, TotalCalorias) :-
  composicion(Plato, Ingredientes),
  findall(Caloria,
          (
            member(Ingrediente, Ingredientes),
            calcularCaloria(Ingrediente, Caloria)
          ),
          Calorias),
  sumlist(Calorias, TotalCalorias).


calcularCaloria(ingrediente(Ingrediente, Cantidad), CaloriaFinal) :-
  calorias(Ingrediente, CaloriaParcial),
  CaloriaFinal is CaloriaParcial*Cantidad.


% d. platoSimpatico/1
% Se dice que un plato es simpático si ocurre alguna de estas condiciones:
% • incluye entre sus ingredientes al pan y al huevo.
% • tiene menos de 200 calorías por porción.
% En el ejemplo, la milanesa es simpática, mientras que el budín de pan no (tiene pan pero no
% huevo, y tiene 230 calorías por porción).Asegurar que el predicado sea inversible.

caloriasMax(200).

platoSimpatico(Plato) :-
  composicion(Plato, Ingredientes),
  hayHuevoYPan(Ingredientes).

platoSimpatico(Plato) :-
  caloriasMax(MaximoCal),
  caloriasTotal(Plato, Calorias),
  Calorias < MaximoCal.

hayHuevoYPan(Ingredientes) :-
  member(ingrediente(pan, _), Ingredientes),
  member(ingrediente(huevo, _), Ingredientes).

% e. menuDiet/3
% Tres platos forman un menú diet si: el primero es entrada, el segundo es plato principal, el
% tercero es postre, y además la suma de las calorías por porción de los tres no supera 450.

caloriasMenuDiet(450).

menuDiet(UnPlato, OtroPlato, OtroPlatoMas) :-
  esEntrada(UnPlato),
  esPlatoPrincipal(OtroPlato),
  esPostre(OtroPlatoMas),
  caloriasJuntasNoSuperan450(UnPlato, OtroPlato, OtroPlatoMas).

caloriasJuntasNoSuperan450(UnPlato, OtroPlato, OtroPlatoMas) :-
  caloriasMenuDiet(CalMax),
  caloriasTotales(UnPlato, OtroPlato, OtroPlatoMas, Calorias),
  Calorias =< CalMax.

caloriasTotales(UnPlato, OtroPlato, OtroPlatoMas, CaloriasTotal) :-
  caloriasTotal(UnPlato, CaloriasUnPlato),
  caloriasTotal(OtroPlato, CaloriasOtroPlato),
  caloriasTotal(OtroPlatoMas, CaloriasOtroPlatoMas),
  CaloriasTotal is CaloriasUnPlato + CaloriasOtroPlato + CaloriasOtroPlatoMas.


% f.tieneTodo/2
% Este predicado relaciona un proveedor con un plato, si el proveedor provee todos los
% ingredientes del plato.
% P.ej. Disco “tiene todo” para el budín de pan, pero no para la milanesa.

tieneTodo(Proveedor, Plato) :-
  provee(Proveedor, _),
  composicion(Plato, _),
  forall(
        componente(Plato, ingrediente(Ingrediente, _)),
        provee(Proveedor, Ingrediente)
        ).

% g. ingredientePopular/1
% Decimos que un ingrediente es popular si hay más de 3 platos que lo incluyen.
% Asegurar que el predicado sea inversible.

numeroIngPopular(3).

ingredientePopular(Ingrediente) :-
  componente(_, ingrediente(Ingrediente, _)),
  encontrarPlatosQueContienenIngrediente(Platos, Ingrediente),
  cantidadDePlatosEsPopular(Platos).

encontrarPlatosQueContienenIngrediente(Platos, Ingrediente) :-
  findall(Plato,
            componente(Plato, ingrediente(Ingrediente, _)),
          Platos).

cantidadDePlatosEsPopular(Platos) :-
  length(Platos, Cantidad),
  numeroIngPopular(Num),
  Cantidad > Num.

% h. cantidadTotal/3
% Relaciona un ingrediente, una lista de pares (plato, cantidad), y la cantidad total de unidades
% del ingrediente que hacen falta para fabricar la lista.
% P.ej. si pregunto
% ?- cantidadTotal(pan, [plato(milanesa,5), plato(ensMixta,4), plato(budinDePan,3)], X).
% la única respuesta esperada es 21 (15 de las milanesas y 6 de los budines, la ensalada mixta
% no suma).

cantidadTotal(Ingrediente, ListaDePlatos, CantidadTotal) :-
  findall(Cantidad,
          ingredientesTotalesDeUnPlato(Ingrediente, ListaDePlatos, Cantidad),
          Cantidades),
  sumlist(Cantidades, CantidadTotal).

ingredientesTotalesDeUnPlato(Ingrediente, ListaDePlatos, Cantidad) :-
  member(plato(NombrePlato, CantidadPlato), ListaDePlatos),
  platoTieneIngrediente(Ingrediente, NombrePlato, CantidadDelIngrediente),
  Cantidad is CantidadDelIngrediente * CantidadPlato.

platoTieneIngrediente(Ingrediente, NombrePlato, CantidadDelIngrediente) :-
  componente(NombrePlato, ingrediente(Ingrediente, CantidadDelIngrediente)).
