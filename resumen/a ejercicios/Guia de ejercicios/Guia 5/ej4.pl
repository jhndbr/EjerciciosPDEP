suma([H|T], S):- suma(T, S2), S is H + S2.
suma([], 0).

encolar([H|T], E, [H|L]):- encolar(T, E, L).
encolar([], E, [E]).

maximo([H,J|T], M):- H >= J, maximo([H|T], M).
maximo([H,J|T], M):- H <  J, maximo([J|T], M).
maximo([M], M).

% elemento_en(Lista, Posicion, Elemento)
elemento_en([H|_], 1, H).
elemento_en([_|L], P, E):- P > 1, P2 is P - 1, elemento_en(L, P2, E).

