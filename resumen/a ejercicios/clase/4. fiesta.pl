/* fiesta */

fiesta(feriaMedieval,[sheldon,leonard,raj],epico).
fiesta(halloween,[ted,sluttyPumking],naranja).
fiesta(ninguna, [], epico).

persona(sheldon, superheroe(flash, rojo, 8)).
persona(leonard, epico(frodo, hobbit)).
persona(leonard, superheroe(flash, rojo, 8)).
persona(raj, superheroe(flash, rojo, 8)).
persona(raj, superheroe(acuaman, naranja, 2)).
persona(masrshall, epico(kvote, posadero)).
persona(ted, epico(bran, blanco)).
persona(lilly, superheroe(mujerMaravilla, amarillo, 7)).

%se_corresponden(tema, disfraz)

se_corresponden(epico, epico(Personaje, Caract)):- persona(_, epico(Personaje, Caract)).
se_corresponden(superheroes, superheroe(S, C, P)):- persona(_, superheroe(S, C, P)), P > 5.
se_corresponden(C, superheroe(S, C, P)):- persona(_, superheroe(S, C, P)).
se_corresponden(verde, epico(Personaje, Caract)):- persona(_, epico(Personaje, Caract)), Caract \= hobbit.
se_corresponden(marron, epico(Personaje, hobbit)):- persona(_, epico(Personaje, hobbit)).

%disfraz_apto(disfraz, fiesta)

disfraz_apto(Disfraz, Fiesta):- fiesta(Fiesta, _, Tema), se_corresponden(Tema, Disfraz).

%disfraz_para_ir(persona, fiesta, disfraz)

conocido(sheldon, leonard).
conocido(leonard, raj).

conocido1(A, B):- conocido(A, B).
conocido1(A, C):- conocido(A, B), conocido1(B, C).

conocido2(A, B):- conocido1(A, B).
conocido2(A, B):- conocido1(B, A).

disfraz_para_ir(Persona, Fiesta, Disfraz):- consigue_disfraz(Persona, Disfraz), fiesta(Fiesta, Invitados, _), member(Persona, Invitados),
	disfraz_apto(Disfraz, Fiesta).
	
consigue_disfraz(Persona, Disfraz):- persona(Persona, Disfraz).
consigue_disfraz(Persona, Disfraz):- persona(Persona), conocido2(Persona, Persona2), persona(Persona2, Disfraz).

persona(Persona):- setof(P, D ^ persona(P, D), L), member(Persona, L).

necesita_preparacion(Persona):- persona(Persona, Disfraz), forall(conocido2(Persona, Persona2), persona(Persona2, Disfraz)).

estan_resentidos(P1, P2):- disfraz_para_ir(P1, Fiesta, Disfraz), disfraz_para_ir(P2, Fiesta, Disfraz), P1 \= P2, 
	not(conocido2(P1, P2)), not(conocido2(P2, P1)).
	
tema_recurrente(Tema):- tema(Tema), findall(T, fiesta(_, _, T), Temas), length(Temas, Cant), ocurrencias(Tema, Temas, N), N >= Cant // 2 + 1.

tema(Tema):- setof(T, F ^ I ^ fiesta(F, I, T), L), member(Tema, L).

ocurrencias(Tema, [Tema|Cola], N):- ocurrencias(Tema, Cola, N2), N is N2 + 1.
ocurrencias(Tema, [H|Cola], N):- Tema \= H, ocurrencias(Tema, Cola, N).
ocurrencias(_, [], 0).

parejita(Fiesta):- fiesta(Fiesta, Invitados, _), forall(member(Inv, Invitados), disfraz_para_ir(Inv, Fiesta, _)).