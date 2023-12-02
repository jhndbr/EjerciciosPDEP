personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).


trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

actividadPeligrosa(mafioso(maton)).
actividadPeligrosa(ladron(Lista)) :- 
    member(licorerias, Lista).

esPeligroso(Personaje) :- 
    personaje(Personaje, Ocupacion),
    actividadPeligrosa(Ocupacion).

esPeligroso(Personaje) :- 
    trabajaPara(Personaje, Empleado),
    esPeligroso(Empleado).


duoPeligroso(Personaje, OtroPersonaje):-
    esPeligroso(Personaje),
    esPeligroso(OtroPersonaje),
    Personaje \= OtroPersonaje.



estaEnProblemas(butch).

estaEnProblemas(Personaje) :-
    trabajaPara(Jefe, Personaje),
    esPeligroso(Jefe),
    pareja(Jefe, Pareja),
    encargo(Jefe, Personaje, cuidar(Pareja)).

estaEnProblemas(Personaje) :-
    encargo(_, Personaje, buscar(boxeador)).

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

sanCayetano(Personaje) :-
    personaje(Personaje, _),
    forall(tieneCerca(Personaje, Otro), encargo(Personaje, Otro, _)).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

tieneCerca(Personaje, Otro) :-
    amigo(Personaje, Otro).
tieneCerca(Personaje, Otro) :-
    trabajaPara(Personaje, Otro).

masAtareado(Personaje) :-
    cantidadDeEncargos(Personaje, Cantidad),
    forall((personaje(Otro, _), Otro \= Personaje, cantidadDeEncargos(Otro, OtraCantidad)), Cantidad >= OtraCantidad).

cantidadDeEncargos(Personaje, Cantidad) :-
    personaje(Personaje, _),
    findall(_, encargo(Personaje, _, _), Encargos),
    length(Encargos, Cantidad).


personajesRespetables(Personajes) :-
    personaje(Personaje,_),
    findall(Personaje, (personaje(Personaje, Actividad), nivelDeRespeto(Actividad, Nivel), Nivel > 9), Personajes).

nivelDeRespeto(actriz(Peliculas), Nivel) :-
    length(Peliculas, CantidadDePeliculas),
    Nivel is CantidadDePeliculas / 10.
nivelDeRespeto(mafioso(resuelveProblemas), 10).
nivelDeRespeto(mafioso(maton), 1).
nivelDeRespeto(mafioso(capo), 20).
nivelDeRespeto(_, 0).

hartoDe(Personaje, Otro) :-
    personaje(Personaje, _),
    forall(encargo(_, Personaje, Tarea), requiereInteraccion(Tarea, Otro)).

requiereInteraccion(cuidar(Persona), Otro) :-
    Persona = Otro ; amigo(Otro, Persona).
requiereInteraccion(buscar(Persona, _), Otro) :-
    Persona = Otro ; amigo(Otro, Persona).
requiereInteraccion(ayudar(Persona), Otro) :-
    Persona = Otro ; amigo(Otro, Persona).

caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).

duoDiferenciable(Personaje1, Personaje2) :-
    (amigo(Personaje1, Personaje2) ; pareja(Personaje1, Personaje2)),
    caracteristicas(Personaje1, Caracteristicas1),
    caracteristicas(Personaje2, Caracteristicas2),
    (tieneCaracteristicaUnica(Caracteristicas1, Caracteristicas2) ; tieneCaracteristicaUnica(Caracteristicas2, Caracteristicas1)).

tieneCaracteristicaUnica(Caracteristicas1, Caracteristicas2) :-
    member(Caracteristica, Caracteristicas1),
    not(member(Caracteristica, Caracteristicas2)).