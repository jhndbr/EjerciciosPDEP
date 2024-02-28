personaje(thundercat(leonO, 5)). %nombre, fuerza
personaje(thundercat(jaga, 0)). %¡es un espíritu!
personaje(thundercat(panthro, 4)).
personaje(thundercat(cheetara, 3)).
personaje(thundercat(tigro, 3)).
personaje(thundercat(grune, 4)).
personaje(mutante(reptilio, 4)). %nombre, fuerza
personaje(mutante(chacalo, 2)).
personaje(mutante(buitro, 2)).
personaje(mutante(mandrilok, 3)).
personaje(lunatack(luna)).
personaje(lunatack(chilla)).
personaje(momia(mummRa)).
personaje(momia(mummRana)).

traidor(grune).
traidor(chacalo).
lider(thundercat, leonO). %facción, líder
lider(mutante, reptilio).
lider(lunatack, luna).
guia(jaga).

% Punto 1
viveEn(thundercat(X), cubil_felino) :- personaje(thundercat(X, _)), \+ traidor(X).
viveEn(mutante(X), madriguera) :- personaje(mutante(X, _)).
viveEn(momia(X), piramide) :- personaje(momia(X)).
viveEn(X, sin_hogar) :- traidor(X); (personaje(lunatack(X)), \+ lider(lunatack, X)).


faccion(Faccion) :-
    setof(F, X^(personaje(X), functor(X, F, _)), Facciones),
    member(Faccion, Facciones).

faccion(Faccion) :-
    setof(FactionName, Character^(personaje(Character), functor(Character, FactionName, _)), ListOfFactions),
member(Faccion, ListOfFactions).

%punto2
caracteristicas(Nombre, lunatack, 3) :-
    personaje(Functor),
    Functor =.. [lunatack, Nombre].

caracteristicas(Nombre, momia, 8) :-
    personaje(Functor),
    Functor =.. [momia, Nombre].

caracteristicas(Nombre, Faccion, Fuerza) :-
    personaje(Functor),
    Functor =.. [Faccion, Nombre, Fuerza],
    Faccion \= lunatack,
    Faccion \= momia.

% Punto 3
% Base case: a list with one character is harmonic
esArmonico([Personaje]) :-
    personaje(Personaje),
    not(traidor(Personaje)).

% Recursive case 1: all characters are not traitors and belong to the same faction
esArmonico([Personaje1, Personaje2 | Resto]) :-
    personaje(Personaje1),
    personaje(Personaje2),
    Personaje1 \= Personaje2,
    not(traidor(Personaje1)),
    not(traidor(Personaje2)),
    functor(Personaje1, Faccion, _),
    functor(Personaje2, Faccion, _),
    esArmonico_sin_repetir(Personaje2, [Personaje2 | Resto]).

% Recursive case 2: all characters are traitors
esArmonico([Personaje1, Personaje2 | Resto]) :-
    personaje(Personaje1),
    personaje(Personaje2),
    Personaje1 \= Personaje2,
    traidor(Personaje1),
    traidor(Personaje2),
    esArmonico_sin_repetir(Personaje2, [Personaje2 | Resto]).

% Predicate auxiliar para evitar personajes repetidos
esArmonico_sin_repetir(_, []).
esArmonico_sin_repetir(Personaje, [OtroPersonaje | Resto]) :-
    Personaje \= OtroPersonaje,
    esArmonico([OtroPersonaje | Resto]).
% Case a: The first character is a guide and the second one is a leader

puedeGuiarA(Personaje1, Personaje2) :-
    personaje(Personaje1),
    personaje(Personaje2),
    Personaje1 \= Personaje2,
    guia(Personaje1),
    lider(_, Personaje2),
    functor(Personaje1, Faccion, _),
    functor(Personaje2, Faccion, _).

% Case b: The second character is not a guide, and the first one is stronger than the second one
puedeGuiarA(Personaje1, Personaje2) :-
    personaje(Personaje1),
    personaje(Personaje2),
    Personaje1 \= Personaje2,
    not(guia(Personaje2)),
    caracteristicas(Personaje1, _, Fuerza1),
    caracteristicas(Personaje2, _, Fuerza2),
    Fuerza1 > Fuerza2,
    functor(Personaje1, Faccion, _),
    functor(Personaje2, Faccion, _).

% mummRa can guide any other bad character, regardless of the faction
puedeGuiarA(mummRa, Personaje) :-
    personaje(Personaje),
    mummRa \= Personaje,
    (functor(Personaje, mutante, _); functor(Personaje, lunatack, _); traidor(Personaje)).

% Base case: a character guides only himself
fuerzaGuiada(Personaje, Fuerza) :-
    personaje(Personaje),
    caracteristicas(Personaje, _, Fuerza),
    not((puedeGuiarA(Personaje, Otro), Otro \= Personaje)).

% Recursive case: a character guides other characters
fuerzaGuiada(Personaje, FuerzaTotal) :-
    personaje(Personaje),
    caracteristicas(Personaje, _, Fuerza),
    findall(FuerzaOtro, (puedeGuiarA(Personaje, Otro), Otro \= Personaje, caracteristicas(Otro, _, FuerzaOtro)), Fuerzas),
    sum_list([Fuerza | Fuerzas], FuerzaTotal).


% Base case: a character has guide level 1 if he can guide another character
nivelDeGuia(Personaje, 1) :-
    personaje(Personaje),
    puedeGuiarA(Personaje, _).

% Recursive case: a character has guide level N if he can guide another character who has guide level N-1
nivelDeGuia(Personaje, Nivel) :-
    Nivel > 1,
    NivelAnterior is Nivel - 1,
    personaje(Personaje),
    puedeGuiarA(Personaje, Otro),
    nivelDeGuia(Otro, NivelAnterior).


seArmoLaHecatombe(Personajes) :-
    findall(Faccion, (member(Personaje, Personajes), personaje(Personaje), functor(Personaje, Faccion, _)), Facciones),
    sort(Facciones, FaccionesUnicas),
    length(FaccionesUnicas, CantidadFacciones),
    CantidadFacciones >= 3.