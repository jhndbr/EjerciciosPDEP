/* Lógico - Listas - Recursividad */

% a
encolar2(E, L1, L2):- append(L1, [E], L2).

encolar(E, [H|T], [H|L]):- encolar(E, T, L).
encolar(E, [], [E]).

% b
maximo([H,J|T], M):- H >= J, maximo([H|T], M).
maximo([H,J|T], M):- H <  J, maximo([J|T], M).
maximo([M], M).

maximo2([H|T],M):- accMax(T,H,M).

accMax([H|T],A,Max) :- H  >  A, accMax(T,H,Max).
accMax([H|T],A,Max) :- H  =< A, accMax(T,A,Max).
accMax([],A,A). 

maximo3(L,M):- member(M,L), forall(member(A,L), M >= A).
maximo4(L,M):- member(M,L), forall((member(A,L), A \= M), M > A).
maximo5(L,M):- member(M,L), not((member(A,L), M < A)).

% c
unir_sin_rep([H|T], L2, L3):-         member(H,L2),  unir_sin_rep(T, L2, L3).
unir_sin_rep([H|T], L2, [H|L3]):- not(member(H,L2)), unir_sin_rep(T, L2, L3).
unir_sin_rep([], L, L).

% d
interseccion([H|T], L2, [H|L3]):- member(H,L2), interseccion(T, L2, L3).
interseccion([H|T], L2, L3):- not(member(H,L2)), interseccion(T, L2, L3).
interseccion([], _, []).

% e
es_creciente([H,J|T]):- H =< J, es_creciente([J|T]).
es_creciente([_]). 

% f
mayores([H|T], N, [H|L]) :- H >  N,   mayores(T, N, L).
mayores([_|T], N, L)     :-           mayores(T, N, L).
mayores([], _, []).

sublist([H|T],[H|L]):- sublist(T,L).
sublist([_|T],L)    :- sublist(T,L).
sublist([],[]).

% g
reversa(L, R):- reversa(L, [], R).
reversa([H|T], L, R):- reversa(T, [H|L], R).
reversa([], L, L).

reversa1([H|T], R):- reversa1(T, RT), append(RT, [H], R).
reversa1([],[]).

% Explosion combinatoria
%Desarrollar el predicado entretenimientos/2, relaciona una cantidad de dinero con los
%entretenimientos posibles que puede realizar con dicha cantidad.

entretenimiento(cine).
entretenimiento(teatro).
entretenimiento(pool).
entretenimiento(parqueTematico).
costo(cine, 30).
costo(teatro, 40).
costo(pool, 15).
costo(parqueTematico, 50).

entretenimientos(Monto,Lista):- todos(Ent), alcanza(Monto, Ent, Lista).

todos(Lista):- findall(Ent, entretenimiento(Ent), Lista).

alcanza(Monto, [H|T], [H|L]):- costo(H, Costo), Costo =< Monto, Monto2 is Monto - Costo, alcanza(Monto2, T, L).
alcanza(Monto, [_|T], L):-  alcanza(Monto, T, L).
alcanza(_, [], []).

/*
?- entretenimientos(100, ListaEntre).
ListaEntre = [cine, teatro, pool] ;
ListaEntre = [cine, teatro] ;
ListaEntre = [cine, pool, parqueTematico] ;
ListaEntre = [cine, pool] ;
ListaEntre = [cine, parqueTematico] ;
ListaEntre = [cine] ;
ListaEntre = [teatro, pool] ;
ListaEntre = [teatro, parqueTematico] ;
ListaEntre = [teatro] ;
ListaEntre = [pool, parqueTematico] ;
ListaEntre = [pool] ;
ListaEntre = [parqueTematico] ;
ListaEntre = [].
*/