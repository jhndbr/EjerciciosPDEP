/* Monstruos motorizados */

lugar(castillo).
lugar(espacio).
lugar(tv).

viveEn(dracula, castillo).
viveEn(frankenstein, castillo).
%viveEn(godzilla, espacio).
%viveEn(sullivan, espacio).
viveEn(allien, espacio).
viveEn(barney, tv).
%viveEn(mLegrand, tv).

% auto(capacidad maxima), colectivo(color, asientos simples, asientos dobles), nave([cantidad de pasajeros por sector])

maneja(frankenstein, auto(6)).
maneja(godzilla, auto(4)).
maneja(sullivan, nave([2,3,1])).
maneja(barney, colectivo(fucsia,10,5)).

maneja(allien, colectivo(verde,10,10)).
maneja(allien, nave([3,4])).

esta_de_a_pie(M):- 
	monstruo(M),
	not(maneja(M,_)).

puede_llevar(M1,M2):- 
	viveEn(M1, L), 
	viveEn(M2, L),
	maneja(M1,_).
	
cantidad_de_pasajeros(M,C):- 
	monstruo(M),
	setof(X, M ^ puede_llevar(M,X), L), 
	length(L,N), 
	capacidad_maxima(M, CM) , 
	minimo(N, CM, C).

lugar_vehiculizado(L):- 
	lugar(L),
	forall(viveEn(M,L), gran_capacidad(M)).

	
	
%%% predicados auxiliares %%%

monstruo(M):- viveEn(M,_).
	
gran_capacidad(M):- 
	capacidad_maxima(M,C), 
	C > 10.
	
capacidad_maxima(M,C):- 
	maneja(M, auto(C)).
capacidad_maxima(M,C):- 
	maneja(M, nave(L)), 
	sumlist(L,C).
capacidad_maxima(M,C):- 
	maneja(M, colectivo(_, AS, AD)), 
	C is AS + 2 * AD.


minimo(A,B,A):- A <  B, !.
minimo(A,B,B):- A >= B.
