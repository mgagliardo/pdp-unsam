% El   malvado   Sr.   Whispers,   antiguo   ​
% sensante ​,   quiere   atrapar   a   todos
% los   de   su   raza,   para   usarlos   con   fines   perversos,   y   nos   pidió   ayuda
% para llevar a cabo su tarea. % Los   sensantes   son   un   grupo   de   personas   que   están   conectadas
% místicamente,   permitiendo   pensar,   sentir   y   hasta   a   veces   tomar
% control   del   cuerpo   de   otro   sensante.   Se   conforman   en   grupos
% gracias a un sensante anterior que le da nacimiento al grupo.
% grupoSensante(Madre, Grupo).
grupoSensante(angelica, [capheus, sun, nomi, kala, riley, lito, will, wolfgang]).


% Se pide:
% 1. Saber si una persona está ​conectadoCon/2 ​otra persona, sabiendo que:
% a. Todo sensante está conectado con su madre.
conectado(Madre, UnaPersona) :-
  grupoSensante(Madre, ListaSensantes),
  member(UnaPersona, ListaSensantes).

% b. Sensantes de un mismo grupo están conectados.
conectado(UnaPersona, OtraPersona) :-
  grupoSensante(_, ListaSensantes),
  member(UnaPersona, ListaSensantes),
  member(OtraPersona, ListaSensantes).

% c. Jonas y Angélica están conectados.
conectado(jonas, angelica).

% d. El   Sr.   Whispers   está   conectado   a   todo   aquel   que   lo   vio   a   los   ojos.   Por   ahora
% Jonas y Angélica  lo miraron a los ojos
% Nota ​
% : No hace falta que esta relación sea simétrica ​
conectado(srWhispers, jonas).
conectado(srWhispers, angelica).


% 2. Poseemos información sobre los gustos de las personas:
leGusta(capheus, actor(jeanClaudeVanDamme)).
leGusta(capheus, cancion(whatsUp)).
leGusta(sun, deporte(kickboxing)).
leGusta(sun, cancion(whatsUp)).
leGusta(nomi, persona(amanita)).
leGusta(nomi, cancion(whatsUp)).
leGusta(kala, persona(wolfgang)).
leGusta(kala, cancion(whatsUp)).
leGusta(riley, persona(will)).
leGusta(riley, cancion(whatsUp)).
leGusta(lito, persona(hernando)).
leGusta(lito, cancion(whatsUp)).
leGusta(will, cancion(whatsUp)).
leGusta(wolfgang, persona(kala)).
leGusta(wolfgang, cancion(whatsUp)).

% a. Se   quiere   saber   si   dos   personas   hacen   una parejaSensante/2​, esto   significa   que
% se gustan mutuamente y pertenecen al mismo grupo.
% En nuestro ejemplo, Kala y Wolfgang hacen una pareja sensante.

parejaInteresante(UnaPersona, OtraPersona) :-
  seGustanMutuamente(UnaPersona, OtraPersona),
  conectado(UnaPersona, OtraPersona).

seGustanMutuamente(UnaPersona, OtraPersona) :-
  leGusta(UnaPersona, persona(OtraPersona)),
  leGusta(OtraPersona, persona(UnaPersona)).

% b. Indicar si un gusto es sintonizador/1​, o sea, si le gusta a todas las personas que
% conforman algún grupo sensante. En nuestro ejemplo, la canción What’s Up es sintonizador.

sintonizador(UnGusto) :-
  teGusta(_, UnGusto),
  lesGustaATodos(UnGusto).

lesGustaATodos(UnGusto) :-
  grupoSensante(_, ListaSensantes),
  forall(
      member(Persona, ListaSensantes),
      teGusta(Persona, UnGusto)
      ).

teGusta(Persona, Gusto) :-
  leGusta(Persona, actor(Gusto)).

teGusta(Persona, Gusto) :-
  leGusta(Persona, deporte(Gusto)).

teGusta(Persona, Gusto) :-
  leGusta(Persona, cancion(Gusto)).

teGusta(Persona, Gusto) :-
  leGusta(Persona, persona(Gusto)).


% 3. También sabemos dónde se encuentran los sensantes:
viveEn(capheus, nairobi).
viveEn(sun, seul).
viveEn(nomi, sanFrancisco).
viveEn(kala, mumbai).
viveEn(riley, londres).
viveEn(lito, mexicoDF).
viveEn(will, chicago).
viveEn(wolfgang, berlin).

% Queremos saber si un grupo está disperso/1​.
% Esto se cumple para cualquier grupo
% sensante cuyos integrantes viven todos en distintos países.
% En nuestro ejemplo, el grupo de Angélica está disperso.

disperso(Grupo) :-
  grupoSensante(_, Grupo),
  ciudadesDondeVivenMiembros(Grupo, Ciudades),
  tamanioEsIdentico(Ciudades, Grupo).

ciudadesDondeVivenMiembros(Grupo, Ciudades) :-
  findall(Ciudad,
          miembroGrupoViveEn(Grupo, Ciudad),
          ListCiudades),
  list_to_set(ListCiudades, Ciudades).

miembroGrupoViveEn(Grupo, Ciudad) :-
  member(Persona, Grupo),
  viveEn(Persona, Ciudad).

tamanioEsIdentico(UnaLista, OtraLista) :-
  length(UnaLista, CantUnaLista),
  length(OtraLista, CantUnaLista).

% 4. Por último, queremos analizar información sobre sus habilidades:
% habilidad(Persona, conductor(NombreDeVehículo,CantPasajeros)).

habilidad(capheus, conductor(vanDamm, 25)).
habilidad(sun, negocios).
habilidad(sun, pelear).
habilidad(sun, coser).
habilidad(nomi, bloguera).
habilidad(nomi, delincuente(hacker)).
habilidad(kala, quimica).
habilidad(riley, dj).
habilidad(lito, actor).
habilidad(will, policia).
habilidad(wolfgang, inteligente).
habilidad(wolfgang, pelear).
habilidad(wolfgang, delincuente(ladronDeJoyas)).

% Se desea saber si una persona es habilidosa/1​.
% Esto ocurre cuando tiene al menos 3 habilidades buenas.
% Se sabe que salvo ser delincuente, policía o conductor de un
% vehículo chico (en   donde   entren   menos   de   20   personas),
% todo el resto de las habilidades son buenas.
% En nuestro ejemplo, la única habilidosa es Sun.

habilidosa(Persona) :-
  habilidad(Persona, _),
  not(tieneHabilidadesMalas(Persona)),
  tieneMasDe3HabilidadesBuenas(Persona).

maximoHabilidadesBuenas(3).

tieneMasDe3HabilidadesBuenas(Persona) :-
  maximoHabilidadesBuenas(Max),
  findall(Habilidad,
          habilidad(Persona, Habilidad),
          CantidadHabilidades),
  length(CantidadHabilidades, Cantidad),
  Cantidad >= Max.

tieneHabilidadesMalas(Persona) :-
  habilidad(Persona, delincuente(_)).

tieneHabilidadesMalas(Persona) :-
  habilidad(Persona, policia).

tieneHabilidadesMalas(Persona) :-
  habilidad(Persona, Coche),
  cocheEsChico(Coche).

tamanioCocheChico(20).

cocheEsChico(conductor(_, CantidadPersonasQueEntran)) :-
  tamanioCocheChico(Max),
  CantidadPersonasQueEntran < Max.
