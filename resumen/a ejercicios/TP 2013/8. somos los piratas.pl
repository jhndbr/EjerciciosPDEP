/* somos los piratas */

mujer(betina).
mujer(laura).
mujer(carola).

bonita(laura).
bonita(betina).

cocinera(laura).

pirata(felipe, 27). /*nombre, edad*/
pirata(marcos, 39).
pirata(facundo, 45).
pirata(tomas, 20).
pirata(gonzalo, 22).

bravo(tomas).
bravo(felipe).
bravo(marcos).

ferocidad(Persona, 2):- mujer(Persona), not(cocinera(Persona)).
ferocidad(Persona, 4):- mujer(Persona), cocinera(Persona).
ferocidad(Persona, 5):- pirata(Persona, _), bravo(Persona).
ferocidad(Persona, 0):- pirata(Persona, _), not(bravo(Persona)).

tripulante(mujer, X):- mujer(X), bonita(X).
tripulante(mujer, X):- mujer(X), cocinera(X).
tripulante(pirata, X):- pirata(X, _), bravo(X).
tripulante(pirata, X):- pirata(X, E), E > 40.

%tripulacion(L):- findall(F, (tripulante(mujer, T), ferocidad(T, F)), L), sumlist(L, N), N > 10.
%tripulacion(L):- findall(F, (tripulante(pirata, T), ferocidad(T, F)), L), sumlist(L, N), N > 10.

tripulacion(Tripulacion):- mujeres(M), ferocidad_total(F, M, Tripulacion), F >= 10.
tripulacion(Tripulacion):- piratas(P), ferocidad_total(F, P, Tripulacion), F >= 10.

mujeres(L):- setof(T, tripulante(mujer, T), L).
piratas(L):- setof(T, tripulante(pirata, T), L).

ferocidad_total(Fer, [H|T], [H|L]):- ferocidad(H, F), ferocidad_total(FT, T, L), Fer is F + FT. 
ferocidad_total(F, [_|T], L):- ferocidad_total(F, T, L).
ferocidad_total(0, [], []).













