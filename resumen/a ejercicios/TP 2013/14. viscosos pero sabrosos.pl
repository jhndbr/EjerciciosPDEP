/* viscosos pero sabrosos */

%comio(Personaje, Bicho), 
%Bicho = vaquitaSanAntonio(nombre, peso), hormiga(nombre), cucaracha(nombre, tamanio, peso)

comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
comio(shenzi,hormiga(conCaraDeSimba)).

pesoHormiga(2).
%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).
peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).

%jugosita(cucaracha(gimeno,12,8)) true

jugosita(cucaracha(Nombre, Tamanio, Peso)):- comio(_, cucaracha(Nombre2, Tamanio, Peso2)), Nombre2 \= Nombre, Peso > Peso2.

hormigofilico(Personaje):- personaje(Personaje), comio(Personaje, hormiga(H1)), comio(Personaje, hormiga(H2)), H1 \= H2.

cucarachofobico(Personaje):- personaje(Personaje), forall(comio(Personaje, Bicho), Bicho \= cucaracha(_,_,_)).

personaje(Personaje):- findall(P, peso(P, _), L), member(Personaje, [mufasa|L]).

picarones(Picarones):- setof(P, picaron(P), Picarones).

picaron(pumba).
picaron(Personaje):- personaje(Personaje), comio(Personaje, cucaracha(A,B,C)), jugosita(cucaracha(A,B,C)).
picaron(Personaje):- personaje(Personaje), comio(Personaje, vaquitaSanAntonio(remeditos,4)).

persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).
persigue(scar, mufasa).

cuanto_engorda(Personaje, Peso):- personaje(Personaje), findall(B, comio(Personaje, B), Bichos), suma_de_pesos(Bichos, P1), 
	findall(P, persigue(Personaje, P), L), suma_de_pesos(L, P2), Peso is P1 + P2.

suma_de_pesos([H|T], N):- peso_de(H, P), suma_de_pesos(T, N2), N is P + N2.
suma_de_pesos([], 0).

peso_de(vaquitaSanAntonio(_, P), P).
peso_de(hormiga(_), 2).
peso_de(cucaracha(_, _, P), P).
peso_de(Personaje, Peso):- peso(Personaje, P), cuanto_engorda(Personaje, P2), Peso is P + P2.

rey(Rey):- personaje(Rey), not(persigue(Rey, _)), not(comio(Rey, _)), persigue(X, Rey), not((persigue(Y, Rey), X \= Y)).
