/* los topos */

entierra(juanCarlos, 		[originalidad]).
entierra(oldMcDonald, 		[semillaDeLino, semillaDeGirasol]).
entierra(ignacio, 			[televisor, computadora, fotosFamiliares, mocos, ignacio]).
entierra(pobreton, 			[]).
entierra(turistaDeLaPlaya, 	[turistaDeLaPlaya]).

%% Se sabe de un pirata su nombre y los mares por los que navegó.
entierra(pirata(barbaRoja,   [atlantico, pacifico, indico, artico, antartico]),	[joyas, oro]).
entierra(pirata(jackSparrow, [atlantico]), 										[oro, mapa]).
entierra(pirata(piraton, 	 []), 												[anilloDeCompromiso, relacionMatrimonial]).
entierra(pirata(alCapone, 	 []), 												[declaracionJurada, oro, dolares, armas, victimas, drogas]).

%% De los perros se sabe el nombre, la raza y la edad en años.
entierra(perro(perroDinamita, ovejero, 3), [hueso]).
entierra(perro(lazy, collie, 8), 		   [victimas]).

diogenes(P):- entierra(P, L), length(L,N), N > 5.
enterro(P,C):- entierra(P,L), member(C,L).
superficial(P):- entierra(P,[]).
se_quiere_ir(P):- entierra(P,L), member(P,L).
tesoro(C):- entierra(pirata(_,_), L), member(C,L).
rico(P):- entierra(P,L), member(oro,L).
nauseoso(P):- pirata(P), P = pirata(_,[]).
peligroso(P):- entierra(P,L), member(victimas,L).
esta_viejito(P):- perro(P), P = perro(_, _, E), E > 7.
es_pirata_argento(P):- pirata(P), P = pirata(_,[mar_del_plata|_]).

pirata(P):- entierra(P, _), P = pirata(_,_).
perro(P):- entierra(P, _), P = perro(_,_,_).

gran_pirata(L):- findall(T, tesoro(T), L).
estamos_al_horno:- findall(P, (pirata(P), peligroso(P)), L1), length(L1, N1),
	findall(P2, nauseoso(P2), L2), length(L2, N2), N1 > N2.
	
dividir_tesoro(P,[L1],L2):- pirata(P), entierra(P,[L1|L2]), L2 \= [].
