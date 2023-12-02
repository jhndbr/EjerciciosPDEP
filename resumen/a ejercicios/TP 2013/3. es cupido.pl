/* es cupido */


hombre(juan, sereno).
%hombre(juan, decidido).
hombre(jose, melancolico).
hombre(pedro, reflexivo).
mujer(ursula, decidida).
mujer(maria, melancolica).
mujer(juana, soniadora).

compatibles(M, V):- mujer(M, melancolica), hombre(V, sereno).
compatibles(M, V):- mujer(M, decidida), hombre(V, reflexivo).
compatibles(M, V):- mujer(M, soniadora), hombre(V, decidido).

compatibles(M, V):- mujer(M, melancolica), hombre(V, decidido).
compatibles(M, V):- mujer(M, decidida), hombre(V, melancolico).

deseable(M, H1, H2):- mujer(M, _), hombre(H1, _), compatibles(M, H1), hombre(H2,_), H1 \= H2, compatibles(M, H2).
deseable(H, M1, M2):- hombre(H, _), mujer(M1, _), compatibles(M1, H), mujer(M2, _), M1 \= M2, compatibles(M2, H).
