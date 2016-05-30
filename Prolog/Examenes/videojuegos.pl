% 1)
tienePlataformaQueSoporta(Empresa, Juego) :-
  juego(Juego, Plataforma),
  vendePlataforma(Empresa, Plataforma).

vendePlataforma(Empresa, Consola) :-
  Consola \= pc(_),
  empresa(Empresa, Consola).

vendePlataforma(Empresa, pc(SOSoportados)) :-
  empresa(Empresa, pc(SOVendidos)),
  member(SO, SOSoportados),
  member(SO, SOVendidos).


% 2)
propietario(Empresa, Juego) :-
  tienePlataformaQueSoporta(Empresa, Juego),
  findall(OtraEmpresa,
    tienePlataformaQueSoporta(OtraEmpresa, Juego),
    Empresas),
  not(hayOtro(Empresa, Empresas)).

hayOtro(Elemento, Lista) :-
  member(OtroElemento, Lista),
  OtroElemento \= Elemento.

%%%%%%%%%%%%%%%%%%%%%%

propietario(Empresa, Juego) :-
  tienePlataformaQueSoporta(Empresa, Juego),
  not(otraEmpresaSoporta(Empresa, Juego)).

otraEmpresaSoporta(UnaEmpresa, Juego) :-
  tienePlataformaQueSoporta(OtraEmpresa, Juego),
  UnaEmpresa \= OtraEmpresa.


% 3)
prefierenPortatiles(Juego) :-
  estaParaConsolaNoPortatil(Juego),
  usanTodosPortatil(Juego).

estaParaConsolaNoPortatil(Juego) :-
  juego(Juego, Consola),
  not(portatil(Consola)).

usanTodosPortatil(Juego) :-
  forall(usuario(Juego, Consola, _),
    portatil(Consola)).



% 4)
nivelFanatismo(Juego, Nivel) :-
  cantidadDeUsuarios(Juego, Cantidad),
  Nivel is Cantidad / 10000.

cantidadDeUsuarios(Juego, Cantidad) :-
  usuario(Juego, _, _),
  findall(CantFanaticos,
    usuario(Juego, _, CantFanaticos),
    Cantidades),
  sumlist(Cantidades, Cantidad).


% 5)
esPirateable(Juego) :-
  correSobrePlataformaHackeable(Juego),
  tieneMuchosUsuario(Juego).

tieneMuchosUsuario(Juego) :-
  tieneMasUsucarioQue(Juego, 5000).
tieneMasUsucarioQue(Juego, CantidadMin) :-
  cantidadDeUsuarios(Juego, Cantidad),
  Cantidad > CantidadMin.

correSobrePlataformaHackeable(Juego) :-
  juego(Juego, Plataforma),
  esHackeable(Plataforma).

esHackeable(pc(_)).
esHackeable(psp).
esHackeable(playstation(1)).
esHackeable(playstation(2)).
esHackeable(playstation(N)) :-
  N < 3.


% 6.a)
ultimoDeLaSaga(Titulo, saga(Titulo, Version)) :-
  juego(saga(Titulo, Version), _),
  esLaUltima(Titulo, Version).

esLaUltima(Titulo, Version) :-
  forall(juego(saga(Titulo, OtraVersion), _),
    Version >= OtraVersion)


ultimoDeLaSaga(Titulo, saga(Titulo, Version)) :-
  juego(saga(Titulo, Version), _),
  not(haySiguiente(Titulo, Version)).

haySiguiente(Titulo, Version) :-
  juego(saga(Titulo, SiguienteVersion), _),
  SiguienteVersion > Version.


% 6.b)
buenaSaga(Titulo) :-
  ultimoDeLaSaga(Titulo, UltimoDeLaSaga),
  cantidadDeUsuarios(UltimoDeLaSaga, Cantidad),
  mantuvieronMitad(UltimoDeLaSaga, Cantidad).

mantuvieronMitad(saga(_, 1), _).
mantuvieronMitad(saga(Titulo, Version), Cantidad) :-
  VersionAnterior is Version - 1,
  cantidadDeUsuarios(saga(Titulo, VersionAnterior), CantidadAnterior),
  mantuvoMitad(CantidadAnterior, Cantidad)
  mantuvieronMitad(saga(Titulo, VersionAnterior), CantidadAnterior).

mantuvoMitad(CantidadAnterior, Cantidad) :-
  Mitad is CantidadAnterior / 2,
  Cantidad >= Mitad.
