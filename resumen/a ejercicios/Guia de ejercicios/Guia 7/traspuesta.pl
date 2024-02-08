/* funciona joya */
traspuesta(M, [P|T]):- primer_columna(M, P, A), traspuesta(A, T).
traspuesta(Vacia, []):- vacia(Vacia).

vacia([[]|T]):- vacia(T).
vacia([[]]).

/* a probar, basado en la de stackoverflow */
traspuesta([],[]).
traspuesta([H|R], T):- traspuesta(H, [H|R], T).

traspuesta([], _, []).
traspuesta([_|Rs], Ms, [Ts|Tss]):- primer_columna(Ms, Ts, Ms1), traspuesta(Rs, Ms1, Tss).


/* funciona para matrices de 3 * X, ej [[1,2,3,3],[4,5,6,6],[7,8,9,9]] */
transpuesta([[A|B], [C|D], [E|F]], [[A,C,E]|T]):- transpuesta([B,D,F], T).
transpuesta([[], [], []], []).

/*
transpuesta(([[1,2,3],[4,5,6],[7,8,9]], X) --> [[1,4,7],[2,5,8],[3,6,9]]
A = 1, B = 2,3
C = 4, D = 5,6
E = 7, F = 8,9
X = [[1,4,7]|T] = [[1,4,7],[2,5,8],[3,6,9]]
transpuesta([[2,3],[5,6],[8,9]], T)
A = 2, B = 3
C = 5, D = 6
E = 8, F = 9
T = [[2,5,8]|R] = [[2,5,8],[3,6,9]]
transpuesta([[3],[6],[9]], R)
A = 3, B = []
C = 6, D = []
E = 9, F = []
R = [[3,6,9]|S] = [[3,6,9]]
transpuesta([[],[],[]], S)
S = []
*/
	
%primer_columna(matriz, primer_columna, adjunta)
primer_columna([[P|A]|R], [P|Ps], [A|As]):- primer_columna(R, Ps, As).
primer_columna([], [], []).

/*
M = [1,2,3],[4,5,6],[7,8,9]
PC = [1,4,7],
Adj = [[2,3],[5,6],[8,9]].
primer_columna([[1,2,3],[4,5,6],[7,8,9]],PC,Adj). --> PC = [1,4,7], Adj = [[2,3],[5,6],[8,9]].
P 	= 1
A   = [2,3]
R   = [[4,5,6],[7,8,9]]
PC  = [1|Ps]			= [1,4,7]
Adj = [[2,3]|As]		= [[2,3],[5,6], [8,9]]
primer_columna([[4,5,6],[7,8,9]], Ps, As)
P  = 4
A  = [5,6]
R  = [[7,8,9]]
Ps = [4|Ps2]			= [4,7]
As = [[5,6]|As2]		= [[5,6], [8,9]]
primer_columna([[7,8,9]], Ps2, As2)
P  = 7
A  = [8,9]
R  = []
Ps2 = [7|Ps3]			= [7]
As2 = [[8,9]|As3]		= [[8,9]]
primer_columna([], Ps3, As3)
Ps3 = []
As3 = []
*/
