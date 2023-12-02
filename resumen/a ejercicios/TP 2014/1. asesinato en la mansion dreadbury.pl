/* asesinato en la mansion dreadbury */

vive_en_la_mansion_dreadbury(tia_agatha).
vive_en_la_mansion_dreadbury(carnicero).
vive_en_la_mansion_dreadbury(charles).

asesino(A,V):- 
	vive_en_la_mansion_dreadbury(A),
	odia(A,V), 
	not(mas_rico(A,V)), !.

odia(tia_agatha,P):- 
	vive_en_la_mansion_dreadbury(P), 
	P \= carnicero.
	
odia(carnicero,P):- 
	odia(tia_agatha,P).

odia(charles,P):- 
	vive_en_la_mansion_dreadbury(P), 
	not(odia(tia_agatha,P)).

mas_rico(P,tia_agatha):- 
	vive_en_la_mansion_dreadbury(P), 
	not(odia(carnicero,P)).

anioActual(2014).

nacio_en(tia_agatha,1934).
nacio_en(carnicero,1942).
nacio_en(charles,1933).

edad(P,E):- nacio_en(P,A), anioActual(AC), E is AC - A.

alguien_con_50_anios :- edad(_,50).

tiene_81_anios(P):- edad(P,81).

/*
[debug] 30 ?- edad(_,50).
false.

[debug] 31 ?- edad(tia_agatha,E).
E = 80.

[debug] 32 ?- edad(P,81).
P = charles.

[debug] 33 ?- edad(P,E).
P = tia_agatha,
E = 80 ;
P = carnicero,
E = 72 ;
P = charles,
E = 81.

[debug] 34 ?- edad(juan,E).
false.
*/
