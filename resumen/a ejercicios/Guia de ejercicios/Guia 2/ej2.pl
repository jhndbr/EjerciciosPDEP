resultado(player1, precision, 	6).
resultado(player1, fuerza, 		5).
resultado(player1, equilibrio, 	3).

resultado(player2, precision, 	8).
resultado(player2, fuerza, 		6).
resultado(player2, equilibrio,	9).

resultado(player3, precision, 	10).
resultado(player3, fuerza, 		15).
resultado(player3, equilibrio, 	20).

competidor(player1). 
competidor(player2). 
competidor(player3).

puntaje_total_2(Competidor, 0):- competidor(Competidor), no_clasifica(Competidor).
puntaje_total_2(Competidor, Puntaje):- competidor(Competidor), not(no_clasifica(Competidor)), 
	findall(P, puntaje(Competidor, _, P), L), sumlist(L, Puntaje).

puntaje_total(Competidor, 0):- competidor(Competidor), puntaje(Competidor, precision, P1), puntaje(Competidor, fuerza, P2), 
	puntaje(Competidor, equilibrio, P3), not(check(P1,P2,P3)).
puntaje_total(Competidor, Puntaje):- competidor(Competidor), puntaje(Competidor, precision, P1), puntaje(Competidor, fuerza, P2), 
	puntaje(Competidor, equilibrio, P3), check(P1,P2,P3), Puntaje is P1 + P2 + P3.
	
no_clasifica(Competidor):- forall(puntaje(Competidor, _, Puntaje), Puntaje < 5).
	
%check(A, B, C):- A >= 5; B >= 5; C >= 5.
check(A, B, C):- not((A < 5, B < 5, C < 5)).




puntaje(Competidor, Prueba, Puntaje):- resultado(Competidor, Prueba, Resultado), call(Prueba, Resultado, Puntaje).

	
precision(Resultado, 10):- between(9,11, Resultado).
precision(Resultado, 6):- Resultado >= 7, Resultado < 9.
precision(Resultado, 6):- Resultado > 11, Resultado =< 15.
precision(Resultado, 0):- Resultado < 7; Resultado > 15.

fuerza(Resultado, 3):- Resultado =< 5.
fuerza(Resultado, 6):- Resultado > 5, Resultado =< 10.
fuerza(Resultado, Puntaje):- Resultado > 10, Puntaje is 9 + (Resultado - 10) / 5.

equilibrio(Resultado, Puntaje):- Puntaje is Resultado / 3.
