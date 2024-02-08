/* el ultimo teorema de fermat */

fermat_tenia_razon(A, B, C, N):- not((
	between(1, 100, A), between(1, 100, B), between(1, 100, C), between(3, 100, N), C ** N =:= A ** N + B ** N)).
	