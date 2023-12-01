%jugador(nombre, items, hambre)
jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).
% lugar(sitio, jugadores, odcuridad)
lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

tieneItem(Jugador, Item):-
    jugador(Jugador, Items, _),
    member(Item, Items).

sePreocupaPorSuSalud(Jugador) :-
    jugador(Jugador, _, _),
    comestible(Item1),
    comestible(Item2),
    Item1 \= Item2,
    tieneItem(Jugador,Item1),
    tieneItem(Jugador,Item2).

cantidadDeItem(Jugador, Item, Cantidad) :-
    jugador(Jugador, _, _),
    findall(Item, tieneItem(Jugador, Item), ListaItems),
    length(ListaItems, Cantidad).

tieneMasDe(Jugador, Item) :-
    cantidadDeItem(Jugador, Item, Cantidad),
    forall((jugador(OtroJugador, _, _), OtroJugador \= Jugador, cantidadDeItem(OtroJugador, Item, OtraCantidad)), Cantidad > OtraCantidad).

%punto 2

hayMonstruos(Lugar) :-
    lugar(Lugar, _, Oscuridad),
    Oscuridad > 6.

correPeligro(Jugador) :-
    estaDondeHayMounstruos(Jugador),
    tienehambre(Jugador),
    noTieneComestible(Jugador).

estaDondeHayMounstruos(Jugador) :-
    jugador(Jugador, _, _),
    lugar(Lugar, Jugadores, _),
    hayMonstruos(Lugar),
    member(Jugador, Jugadores).

tienehambre(Jugador) :-
    jugador(Jugador, _, Hambre),
    Hambre < 4.

noTieneComestible(Jugador):-
    jugador(Jugador, _, _),
    comestible(Item),
    not(tieneItem(Jugador, Item)).

nivelPeligrosidad(Lugar, Nivel) :-
        lugar(Lugar, _, _),
        hayMonstruos(Lugar),
        Nivel is 100.
    
nivelPeligrosidad(Lugar, Nivel) :-
        lugarPoblado(Lugar),
        porcentajeDeHambriento(Lugar, Porcentaje),
        Nivel is Porcentaje.
    
nivelPeligrosidad(Lugar, Nivel) :-
        lugar(Lugar, _, Oscuridad),
        Nivel is Oscuridad * 10.

lugarPoblado(Lugar):-
    lugar(Lugar, Jugadores, _),
    length(Jugadores, Poblacion),
    Poblacion > 0.

porcentajeDeHambriento(Lugar,Porcentaje):- 
    lugar(Lugar, Jugadores, _),
    length(Jugadores, Poblacion),
    findall(Jugador, (member(Jugador, Jugadores), tienehambre(Jugador)), Hambrientos),
    length(Hambrientos, HambrientosCount),
    Porcentaje is (HambrientosCount / Poblacion) * 100.

%punto3 
item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).

puedeConstruir(Jugador, Item) :-
    item(Item, Requisitos),
    puedeCumplirRequisitos(Jugador, Requisitos).

puedeCumplirRequisitos(_, []).
puedeCumplirRequisitos(Jugador, [simple(Item, Cantidad)|T]) :-
    cantidadDeItem(Jugador, Item, CantidadJugador),
    CantidadJugador >= Cantidad,
    puedeCumplirRequisitos(Jugador, T).
puedeCumplirRequisitos(Jugador, [compuesto(Item)|T]) :-
    puedeConstruir(Jugador, Item),
    puedeCumplirRequisitos(Jugador, T).