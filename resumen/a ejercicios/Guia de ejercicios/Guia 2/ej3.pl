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