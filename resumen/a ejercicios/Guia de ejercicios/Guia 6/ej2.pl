%codo(color).
%canio(color, longitud).
%canilla(tipo, color, ancho).

codo(rojo). codo(azul). codo(negro).
canio(rojo, 5). canio(azul, 5). canio(negro, 5).
canilla(triangular, rojo, 5). canilla(triangular, azul, 5). canilla(triangular, negro, 5). 

% precio
precio([H|T], Precio):- precio(T, Precio2), precio(H, PrecioH), Precio is PrecioH + Precio2.
precio([], 0).

precio(codo(_), 5).
precio(canio(_, Longitud), Precio):- Precio is Longitud * 3.
precio(canilla(triangular, _, _), 20).
precio(canilla(Tipo, _, Ancho), 12):- Tipo \= triangular, Ancho =< 5.
precio(canilla(Tipo, _, Ancho), 15):- Tipo \= triangular, Ancho >  5.

% puedo_enchufar
puedo_enchufar(Pieza1, Pieza2):- color(Pieza1, Color), color(Pieza2, Color).
puedo_enchufar(Pieza1, Pieza2):- color(Pieza1, azul), color(Pieza2, rojo).
puedo_enchufar(Pieza1, Pieza2):- color(Pieza1, rojo), color(Pieza2, negro).

puedo_enchufar(Canieria, Pieza):- last(Canieria, PiezaU), puedo_enchufar(PiezaU, Pieza).
puedo_enchufar(Pieza, [P|_]):- puedo_enchufar(Pieza, P).

color(codo(Color), Color).
color(canio(Color, _), Color).
color(canilla(_, Color, _), Color).

% canieria_bien_armada
canieria_bien_armada([_]).
canieria_bien_armada([H,J|T]):- puedo_enchufar(H,J), canieria_bien_armada([J|T]).

% canierias_legales
canierias_legales(Piezas, Canieria):- sublist(Piezas, PiezasS), permutation(PiezasS, Canieria), canieria_bien_armada(Canieria).

sublist([H|T], [H|L]):- sublist(T,L).
sublist([_|T], L):- sublist(T,L).
sublist([], []).

perm([], []).
perm(L, [H|P]) :- select(H, L, Rest), perm(Rest, P).

canierias([codo(rojo), codo(azul), codo(negro),
canio(rojo, 5), canio(azul, 5), canio(negro, 5),
canilla(triangular, rojo, 5), canilla(triangular, azul, 5), canilla(triangular, negro, 5)]).
/*
select(X, [X|Tail], Tail).
select(Elem, [Head|Tail], [Head|Rest]) :- select(Elem, Tail, Rest).
*/