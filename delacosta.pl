%Prolog de la Costa
%Punto 1

puestosDeComida(hamburguesas, 2000).
puestosDeComida(panchitosConPapas, 1500).
puestosDeComida(lomitosCompletos, 2500).
puestosDeComida(caramelos, 0).

atraccion(autitosChocadores, tranquila(atp)).
atraccion(casaEmbrujada, tranquila(atp)).
atraccion(laberinto, tranquila(atp)).
atraccion(tobogan, tranquila(chicos)).
atraccion(calesita, tranquila(chicos)).

atraccion(barcoPirata, intensa(14)).
atraccion(tazasChinas, intensa(6)).
atraccion(simulador, intensa(2)).

atraccion(abismoMortal, montaniaRusa(3, 134)).
atraccion(paseoPorElBosque, montaniaRusa(0, 45)).

atraccion(torpedoSalpicon, acuatica()).
atraccion(esperoQueHayasTraidoUnaMudaDeRopa, acuatica()).

visitante(eusebio, 3000, 80, viejitos).
visitante(carmela, 0, 80, viejitos).
sentimiento(eusebio, 50, 0).
sentimiento(carmela, 0, 25).
%visitante(Visitante, Dinero, Edad, GrupoFamiliar).
%sentimiento(Visitante, Hambre, Aburrimiento).

%Punto 2
bienestar(Visitante, Estado) :-
    sentimiento(Visitante, Hambre, Aburrimiento),
    Suma is Hambre + Aburrimiento,
    bienestarSegun(Suma, Estado, Visitante).
    
 
bienestarSegun(0, felicidadPlena, Visitante) :- estaAcompaniado(Visitante).
bienestarSegun(0, podriaEstarMejor, Visitante) :- not(estaAcompaniado(Visitante)).
bienestarSegun(Suma, podriaEstarMejor, _) :- between(1, 50, Suma).
bienestarSegun(Suma, necesitaEntretenerse, _) :- between(51, 99, Suma).
bienestarSegun(Suma, seQuiereIrACasa, _) :- Suma >= 100.

estaAcompaniado(Visitante) :-
    visitante(Visitante, _, _, GrupoFamiliar),
    visitante(OtroVisitante, _, _, GrupoFamiliar),
    Visitante \= OtroVisitante.

%Punto 3
puedeSatisfacerSuHambre(GrupoFamiliar, Comida) :-
    visitante(_, _, _, GrupoFamiliar),
    puestosDeComida(Comida, _),
    forall(visitante(Visitante, _, _, GrupoFamiliar), puedePagarYSatisfacerse(Visitante, Comida)).

puedePagarYSatisfacerse(Visitante, Comida) :-
    puedePagar(Visitante, Comida),
    satisface(Comida, Visitante).

puedePagar(Visitante, Comida) :-
    visitante(Visitante, Dinero, _, _),
    puestosDeComida(Comida, Precio),
    Dinero >= Precio,
    Comida \= caramelos.

satisface(hamburguesas, Visitante) :-
    sentimiento(Visitante, Hambre, _),
    Hambre < 50.

satisface(panchitosConPapas, Visitante) :-
   esChico(Visitante).

satisface(lomitosCompletos, _).

satisface(caramelos, Visitante) :-
    puestosDeComida(Comida, _),
    not(puedePagar(Visitante, Comida)).
    
esChico(Visitante) :-
    visitante(Visitante, _, Edad, _),
    Edad < 13.

%Punto 4
lluviaDeHamburguesas(Visitante, Atraccion) :-
    puedePagar(Visitante, hamburguesas),
    atraccion(Atraccion, _),
    atraccionSegun(Atraccion, Visitante).

atraccionSegun(Atraccion, _) :-
    atraccion(Atraccion, intensa(CoeficienteDeLanzamiento)),
    CoeficienteDeLanzamiento > 10.

atraccionSegun(Atraccion, Visitante) :-
    atraccion(Atraccion, montaniaRusa(_, _)),
    visitante(Visitante, _, _, _),
    esPeligrosa(Atraccion, Visitante).

atraccionSegun(tobogan, _).

esPeligrosa(Atraccion, Visitante) :-
    not(esChico(Visitante)),
    not(bienestar(Visitante, necesitaEntretenerse)),
    montaniaConMayoresGiros(Atraccion).
    
esPeligrosa(Atraccion, Visitante) :-
    esChico(Visitante),
    duraMasDe(60, Atraccion).

montaniaConMayoresGiros(Atraccion) :-
    atraccion(Atraccion, montaniaRusa(GirosInvertidos, _)),
    forall(atraccion(_, montaniaRusa(OtrosGirosInvertidos, _)), GirosInvertidos >= OtrosGirosInvertidos).

duraMasDe(Segundos, Atraccion) :-
    atraccion(Atraccion, montaniaRusa(_, SegundosAtraccion)),
    SegundosAtraccion > Segundos.

%Punto 5
opcionesDeEntretenimiento(Mes, Visitante, Opcion) :-
    visitante(Visitante, _, _, _),
    atraccion(Opcion, _),
    opcionesDeAtracciones(Mes, Visitante, Opcion).

opcionesDeEntretenimiento(_, Visitante, Opcion) :-
    puestosDeComida(Opcion, _),
    puedePagar(Visitante, Opcion).

opcionesDeAtracciones(_, _, Opcion) :-
    atraccion(Opcion, tranquila(atp)).

opcionesDeAtracciones(_, Visitante, Opcion) :-
    esChico(Visitante),
    atraccion(Opcion, tranquila(chicos)).
%Si hay un chico
opcionesDeAtracciones(_, Visitante, Opcion) :-
    tieneUnChicoEnSuGrupoFamiliar(Visitante),
    atraccion(Opcion, tranquila(chicos)).

opcionesDeAtracciones(_, _, Opcion) :-
    atraccion(Opcion, intensa(_)).

opcionesDeAtracciones(_, Visitante, Opcion) :-
    atraccion(Opcion, montaniaRusa(_, _)),
    not(esPeligrosa(Opcion, Visitante)).

opcionesDeAtracciones(Mes, _, Opcion) :-
    atraccion(Opcion, acuatica()),
    coincideCon(Mes).

coincideCon(Mes) :-
    mesesDeApertura(MesesDeApertura),
    member(Mes, MesesDeApertura).

mesesDeApertura([septiembre, octubre, noviembre, diciembre, enero, febrero, marzo]).

    tieneUnChicoEnSuGrupoFamiliar(Visitante) :-
    visitante(Visitante, _, _, GrupoFamiliar),
    visitante(Chico, _, _, GrupoFamiliar),
    esChico(Chico).