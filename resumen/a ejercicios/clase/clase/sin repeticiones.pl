sin_repeticiones([], []).
sin_repeticiones([H|T], L):-          member(H,T), sin_repeticiones(T,L).
sin_repeticiones([H|T], [H|L]):- not(member(H,T)), sin_repeticiones(T,L).


sin_repeticiones2(L1, L2):- setof(X, L1 ^ member(X,L1), L2).