mujeres([ana, nora, marta]).
varones([luis, juan, pedro]).
mujer(M):- mujeres(Mujeres), member(M,Mujeres).
varon(V):- varones(Vs), member(V,Vs).

preferencias(ana, [luis, juan, pedro]).
preferencias(nora, [juan, pedro, luis]).
preferencias(marta, [pedro, luis, juan]).
preferencias(luis, [ana, nora, marta]).
preferencias(juan, [marta, ana, nora]).
preferencias(pedro, [nora, marta, ana]).

% parejas

parejas(Mujeres, Varones, Parejas):- mujeres(Mujeres), varones(Varones), permutation(Varones, VaronesP), formar_parejas(Mujeres, VaronesP, Parejas).

formar_parejas([M|Ms], [V|Vs], [pareja(M,V)|Resto]):- formar_parejas(Ms, Vs, Resto).
formar_parejas([], [], []).

% insatisfecho

insatisfecho(A, Parejas):- pareja_de(A, B, Parejas), prefiere(A, C, B), pareja_de(D, C, Parejas), prefiere(C, A, D).
	
prefiere(A,C,B):- preferencias(A, Orden), nth0(P1, Orden, C), nth0(P2, Orden, B), P1 < P2.

pareja_de(M,V,Parejas):- member(pareja(M, V), Parejas).

% estable

estable(Parejas):- parejas(_, _, Parejas), forall(member(pareja(A,_), Parejas), not(insatisfecho(A, Parejas))).


/*
C = [pareja(ana,luis),pareja(nora,juan),pareja(marta,pedro)] ;
C = [pareja(ana,luis),pareja(nora,pedro),pareja(marta,juan)] ;
C = [pareja(ana,juan),pareja(nora,luis),pareja(marta,pedro)] ;
C = [pareja(ana,juan),pareja(nora,pedro),pareja(marta,luis)] ;
C = [pareja(ana,pedro),pareja(nora,luis),pareja(marta,juan)] ;
C = [pareja(ana,pedro),pareja(nora,juan),pareja(marta,luis)] ;
*/



/* cementerio de predicados
parejas(Parejas):- findall(pareja(A,B), pareja(A,B), Parejas).
parejas([pareja(A,B), pareja(C,D), pareja(E,F)]):- A \= C, A \= E, C \= E, B \= D, B \= F, D \= F.
parejas(Mujeres, Varones, Parejas):- member(M,Mujeres), member(V,Varones), pareja(M,V), not(member(pareja(M,V), Parejas)), 
parejas(Mujeres, Varones, Parejas).
quiere_dejar(A,B):- pareja(A,B), prefiere(A,C,B), pareja(P,C), prefiere(C,A,P).
pareja(A,B):- mujer(A), varon(B).

inestable(pareja(A,B)):- quiere_dejar(A,B).
inestable(pareja(A,B)):- quiere_dejar(B,A).

*/