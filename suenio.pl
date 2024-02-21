% cree(Persona, Entidad)
cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoDePascua).
cree(macarena, reyesMagos).
cree(macarena, magoCapria).
cree(macarena, campanita).

% sueno(Persona, Sueno)
sueno(gabriel, ganarLoteria([5, 9])).
sueno(gabriel, serFutbolista(arsenal)).
sueno(juan, serCantante(100000)).
sueno(macarena, serCantante(10000)).

persona(gabriel).
persona(juan).
persona(macarena).

% dificultad(Sueno, Dificultad)
dificultad(serCantante(Discos), 6) :- Discos > 500000.
dificultad(serCantante(_), 4).
dificultad(ganarLoteria(Numeros), Dificultad) :- length(Numeros, Cantidad), Dificultad is 10 * Cantidad.
dificultad(serFutbolista(Equipo), 3) :- equipoChico(Equipo).
dificultad(serFutbolista(_), 16).

% equipoChico(Equipo)
equipoChico(arsenal).
equipoChico(aldosivi).

% esAmbiciosa(Persona)
esAmbiciosa(Persona) :-
    cree(Persona,_),
    findall(Dificultad, (sueno(Persona, Sueno), dificultad(Sueno, Dificultad)), Dificultades),
    sumlist(Dificultades, Total),
    Total > 20.


tieneQuimica(Personaje, Persona) :-
    Personaje \= campanita,
    cree(Persona, Personaje),
    not(esAmbiciosa(Persona)),
    forall(sueno(Persona, Sueno), esSuenoPuro(Sueno)).

% tieneQuimica(Personaje, Persona)
tieneQuimica(campanita, Persona) :-
    cree(Persona, campanita),
    tieneSuenoFacil(Persona).


% tieneSuenoFacil(Persona)
tieneSuenoFacil(Persona) :-
    sueno(Persona, Sueno),
    dificultad(Sueno, Dificultad),
    Dificultad < 5.

% esSuenoPuro(Sueno)
esSuenoPuro(serFutbolista(_)).
esSuenoPuro(serCantante(Discos)) :- Discos < 200000.   

% amigo(Personaje1, Personaje2)
amigo(campanita, reyesMagos).
amigo(campanita, conejoDePascua).
amigo(conejoDePascua, cavenaghi).

% puedeAlegrar(Personaje, Persona)
puedeAlegrar(Personaje, Persona) :-
    sueno(Persona, _),
    tieneQuimica(Personaje, Persona),
    not(estaEnfermo(Personaje)),
    !.

puedeAlegrar(Personaje, Persona) :-
    sueno(Persona, _),
    tieneQuimica(Personaje, Persona),
    amigo(Personaje, Amigo),
    not(estaEnfermo(Amigo)).

% estaEnfermo(Personaje)
% Agrega aquí los personajes que están enfermos, por ejemplo:
estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).