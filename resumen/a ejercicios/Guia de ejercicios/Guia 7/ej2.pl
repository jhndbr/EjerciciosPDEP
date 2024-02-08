%cuadrado_aritmetico
cuadrado_aritmetico(M):-
	cumple_operaciones(M),
	cumple_unicidad(M),
	transpuesta(M,MT),
	cumple_operaciones(MT).

% cantidad_de_cuadrados_aritmeticos, 16
cantidad_de_cuadrados_aritmeticos(C):- findall(M, cuadrado_aritmetico(M), L), length(L,C).
	
% cumple_operaciones
cumple_operaciones([A,B,C]):- operacion(A), operacion(B), operacion(C).

operacion([A,B,C]):- between(1,10,A), between(1,10,B), between(1,10,C), operacion_(A,B,C).

operacion_(A,B,C):- C is A + B.
operacion_(A,B,C):- C is A - B.
	
% cumple_unicidad
cumple_unicidad(Lista):- flat(Lista, ListaF), todos_distintos(ListaF).

/* podria usarse flatten, pero este es mas eficiente */
flat([[A,B,C], [D,E,F], [G,H,I]], [A,B,C,D,E,F,G,H,I]).

todos_distintos([H|T]):- not(member(H,T)), todos_distintos(T).
todos_distintos([]).

/* transpuesta, mas eficiente, se aprovecha el uso de que la matriz es fija */
transpuesta([[A,B,C],[D,E,F],[G,H,I]], [[A,D,G], [B,E,H], [C,F,I]]).

/* funciona para todas las matrices
traspuesta(M, [P|T]):- primer_columna(M, P, A), traspuesta(A, T).
traspuesta(Vacia, []):- vacia(Vacia).

vacia([[]|T]):- vacia(T).
vacia([[]]).

primer_columna([[P|A]|R], [P|Ps], [A|As]):- primer_columna(R, Ps, As).
primer_columna([], [], []).
*/








