% Una empresa de servicios varios ofrece la posibilidad de realizar compras varias desde un sitio
% en Internet. Los usuarios solo deben registrarse e ir eligiendo cada artículo, como también su
% cantidad.
% Este sistema corre un proceso al finalizar el día que genera la siguiente base de conocimientos:

precioUnitario(producto(tomate), 12.50).
precioUnitario(producto(leche, sancor), 2.45).
precioUnitario(producto(papa), 4.50).
precioUnitario(producto(yogur, laSerenisima), 1.75).
precioUnitario(producto(yogur, sancor), 1.65).
precioUnitario(producto(yogur, manfrey), 1.15).
precioUnitario(producto(fosforos, los3Patitos), 1).

% El producto se representa como un functor con:
% • El nombre de un producto genérico, o bien
% • El nombre de un producto y la marca que lo comercializa

compro(leo, producto(tomate), 2).
compro(leo, producto(yogur, manfrey), 10).
compro(leo, producto(papa), 1).
compro(nico, producto(tomate), 3).
compro(flor, producto(yogur, laSerenisima), 2).
compro(flor, producto(leche, sancor), 4).
marcaImportante(sancor).
marcaImportante(laSerenisima).

% Se pide:
% 1) Realice las consultas que permitan determinar
% a. quiénes compraron productos de Sancor (debe devolver los individuos leo y flor)
% b. qué compró Leo
% c. si Leo compró 2 cosas de algún producto (debe decirme que sí).

% EN CONSOLA

% 2) Resuelva el predicado cuantoGasto/2 que relaciona una persona con el total que
% gastó.

cuantoGasto(Persona, TotalGastado) :-
  compro(Persona, _, _),
  findall(PrecioParcial,
         calcularGastado(Persona, PrecioParcial),
         Precios),
  sumlist(Precios, TotalGastado).

calcularGastado(Persona, ParcialGastado) :-
  compro(Persona, Producto, CantidadProducto),
  calcularPrecioParcial(Producto, CantidadProducto, ParcialGastado).

calcularPrecioParcial(Producto, CantidadProducto, ParcialGastado) :-
  precioUnitario(Producto, Precio),
  ParcialGastado is CantidadProducto*Precio.


% 3) Codifique el predicado esMarquero/1, que relaciona las personas que sólo compran
% cosas de marcas importantes. Pensarlo:
% a. Que acepte a las personas que compran productos genéricos (como el tomate,
% la papa, etc.)
% En ese caso la consulta esMarquero(Quien) incluye a nico y a flor.

esMarqueroGenerico(Persona) :-
  compro(Persona, _, _),
  forall(
        compro(Persona, Producto, _),
        puedeSerGenerico(Producto)
        ).

% b. Que no acepte a las personas que compran productos genéricos.
% En ese caso la consulta esMarquero(Quien) sólo incluye a flor.

esMarqueroNoGenerico(Persona) :-
  compro(Persona, _, _),
  forall(
        compro(Persona, Producto, _),
        esDeMarca(Producto)
        ).

puedeSerGenerico(producto(_, Marca)) :-
  marcaImportante(Marca).

puedeSerGenerico(producto(_)).

esDeMarca(producto(_, Marca)) :-
  marcaImportante(Marca).


% 4) Resuelva el predicado esGastador/1, donde una persona es gastadora si:
% • Compró más de 5 productos, o
% • Compró un producto de La Serenísima (como Flor), o
% • El total de la compra excede los 100$.
% El predicado a generar debe ser inversible.

precioExcedido(100).
cantidadExcedidaProductos(5).

esGastador(Persona) :-
  precioExcedido(MaxPrecio),
  cuantoGasto(Persona, TotalGastado),
  TotalGastado > MaxPrecio.


esGastador(Persona) :-
  cantidadExcedidaProductos(CantMax),
  findall(Cantidad,
          compro(Persona, _, Cantidad),
          CantProductosComprados),
  length(CantProductosComprados, Cant),
  Cant > CantMax.

esGastador(Persona) :-
  compro(Persona, producto(_, laSerenisima), _).
