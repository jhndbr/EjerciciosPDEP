/* domino */

tieneFicha(carlos,ficha(0,4)).
tieneFicha(carlos,ficha(0,6)).
tieneFicha(carlos,ficha(5,1)).
tieneFicha(german,ficha(5,0)).
tieneFicha(miguel,ficha(3,2)).
tieneFicha(miguel,ficha(3,3)).
tieneFicha(juan,ficha(1,6)).
estado([ficha(0,1),ficha(1,4),ficha(4,2),ficha(2,2),ficha(2,5)]).

cede_turno(Jugador):- jugador(Jugador), not(puede_poner(Jugador)).

puede_poner(Jugador):- estado(Estado), numeros_posibles(Estado, N1, N2), numeros_jugador(Jugador, Ns), pertenece(N1, N2, Ns).

numeros_posibles(Lista, A, B):- first(Lista, ficha(A, _)), last(Lista, ficha(_, B)).

numeros_jugador(Jugador, Ns):- findall(F, tieneFicha(Jugador, F), Fichas), get_numeros(Fichas, Ns).

get_numeros([ficha(A,B)|Resto], [A,B|Lista]):- get_numeros(Resto,Lista).
get_numeros([], []).

pertenece(A,_,C):- member(A,C).
pertenece(_,B,C):- member(B,C).

jugadores(Js):- setof(J, F ^ tieneFicha(J, F), Js).
jugador(J):- jugadores(Js), member(J,Js).

first([H|_], H).