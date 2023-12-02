puntajes(hernan,[3,5,8,6,9]).
puntajes(julio,[9,7,3,9,10,2]).
puntajes(ruben,[3,5,3,8,3]).
puntajes(roque,[7,10,10]).

puntaje(Competidor, Salto, Puntaje):- puntajes(Competidor, Lista), nth1(Salto, Lista, Puntaje).

descalificado(Competidor):- puntajes(Competidor, Lista), length(Lista, N), N > 5.

clasifica(Competidor):- puntajes(Competidor, Lista), condicion(Lista).

condicion(Lista):- sumlist(Lista, Total), Total >= 28.
condicion(Lista):- findall(X, (member(X, Lista), X >= 8), L), length(L, N), N >= 2.
