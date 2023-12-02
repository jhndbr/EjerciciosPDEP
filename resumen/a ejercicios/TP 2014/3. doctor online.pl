/* doctor online */

% enfermedad (nombre, tipo, causa, sintomas, duracion?).
enfermedad(gripe,			aguda, 		virus,		[congestion_nasal, dolor_de_cabeza, tos]).
enfermedad(meningitis, 		aguda, 		virus, 		[fiebre, vomitos, dolor_de_cabeza]).
enfermedad(meningitis, 		aguda, 		bacterias, 	[fiebre, vomitos, dolor_de_cabeza]).
enfermedad(tuberculosis, 	aguda, 		bacterias, 	[cansancio, tos, sudoracion]).
enfermedad(epoc, 			cronica, 	virus, 		[disnea, tos], 10).

% persona(nombre, sintomas)
persona(analia,[dolor_de_cabeza, congestion_nasal, cansancio]).
persona(jorge, [somnolencia, cansancio, disnea]).
persona(nadia, [fiebre, dolor_de_cabeza, congestion_nasal]).
persona(juan, [tos]).

%alivia(sintoma, medicamento)
alivia(tos, jarabe).
alivia(cansancio,vitaminas).
alivia(fiebre, paracetamol).
alivia(dolor_de_cabeza,paracetamol).
alivia(disnea, broncodilatadores).

enfermero(martha).
doctor(foreman, neurologo).
doctor(house, nefrologia).

sintomas(E,S):-    enfermedad(E,_,_,S).
sintomas(epoc,S):- enfermedad(epoc,_,_,S,_).

enfermo_de(P,E):- persona(P,S1), sintomas(E,S2), interseccion(S1,S2,S), length(S,N) , N >= 2.

tratar(E,M):- sintomas(E,S), member(S1,S), alivia(S1,M).

sugerir(P,M):- enfermo_de(P,E), tratar(E,M).

bacteriana(E):- enfermedad(E,_,bacterias,_).

% lo_puede_atender(persona, enfermedad, medico)
lo_puede_atender(P,E,M):- enfermo_de(P,E), enfermedad(E, aguda, _, _), enfermero(M).
lo_puede_atender(P,E,M):- enfermo_de(P,E), enfermedad(E, _, bacterias, _), doctor(M,_).
lo_puede_atender(P,E,M):- enfermo_de(P,E), enfermedad(E, cronica, _, _, D), D > 5, doctor(M,_).


interseccion(A,B,C):- findall(X,(member(X,A), member(X,B)), C).

/*
11 ?- sintomas(E,S).
E = gripe,
S = [congestion_nasal,dolor_de_cabeza,tos] ;
E = meningitis,
S = [fiebre,vomitos,dolor_de_cabeza] ;
E = meningitis,
S = [fiebre,vomitos,dolor_de_cabeza] ;
E = tuberculosis,
S = [cansancio,tos,sudoracion] ;
E = epoc,
S = [disnea,tos].

12 ?- enfermo_de(P,E).
P = analia,
E = gripe ;
P = nadia,
E = gripe ;
P = nadia,
E = meningitis ;
P = nadia,
E = meningitis ;
false.

13 ?- tratar(E,M).
E = gripe,
M = paracetamol ;
E = gripe,
M = jarabe ;
E = meningitis,
M = paracetamol ;
E = meningitis,
M = paracetamol ;
E = meningitis,
M = paracetamol ;
E = meningitis,
M = paracetamol ;
E = tuberculosis,
M = vitaminas ;
E = tuberculosis,
M = jarabe ;
E = epoc,
M = broncodilatadores ;
E = epoc,
M = jarabe.

14 ?- sugerir(P,M).
P = analia,
M = paracetamol ;
P = analia,
M = jarabe ;
P = nadia,
M = paracetamol ;
P = nadia,
M = jarabe ;
P = nadia,
M = paracetamol ;
P = nadia,
M = paracetamol ;
P = nadia,
M = paracetamol ;
P = nadia,
M = paracetamol ;
P = nadia,
M = paracetamol ;
P = nadia,
M = paracetamol ;
P = nadia,
M = paracetamol ;
P = nadia,
M = paracetamol ;
false.

15 ?- bacteriana(E).
E = meningitis ;
E = tuberculosis.

16 ?- lo_puede_atender(P,E,M).
P = analia,
E = gripe,
M = martha ;
P = nadia,
E = gripe,
M = martha ;
P = nadia,
E = meningitis,
M = martha ;
P = nadia,
E = meningitis,
M = martha ;
P = nadia,
E = meningitis,
M = martha ;
P = nadia,
E = meningitis,
M = martha ;
P = nadia,
E = meningitis,
M = foreman ;
P = nadia,
E = meningitis,
M = house ;
P = nadia,
E = meningitis,
M = foreman ;
P = nadia,
E = meningitis,
M = house ;
false.
*/



