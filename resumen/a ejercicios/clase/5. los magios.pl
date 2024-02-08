:-  op(900, fy, not). 

persona(bart).
persona(larry).
persona(otto).
persona(marge).

%los magios son functores alMando(nombre, antiguedad), novato(nombre) y elElegido(nombre).
persona(alMando(burns,29)).
persona(alMando(clark,20)).
persona(novato(lenny)).
persona(novato(carl)).
persona(elElegido(homero)).

hijo(homero,abbe).
hijo(bart,homero).
hijo(larry,burns).

salvo(carl,lenny).
salvo(homero,larry).
salvo(otto,burns).

gozaBeneficio(carl, confort(sillon)).
gozaBeneficio(lenny, confort(sillon)).
gozaBeneficio(lenny, confort(estacionamiento, techado)).
gozaBeneficio(carl, confort(estacionamiento, libre)).
gozaBeneficio(clark, confort(viajeSinTrafico)).
gozaBeneficio(clark, dispersion(fiestas)).
gozaBeneficio(burns, dispersion(fiestas)).
gozaBeneficio(lenny, economico(descuento, 500)).

% 1. aspirante_a_magio

aspirante_a_magio(Persona):- no_magio(Persona), descendiente(Persona, Magio), magio(Magio).
aspirante_a_magio(Persona):- no_magio(Persona), salvo(Persona, Magio), magio(Magio).

descendiente(A, B):- hijo(A, B).
descendiente(A, C):- hijo(A, B), descendiente(B, C).

no_magio(Persona):- persona(Persona), not es_magio(Persona).

% generador de magios (por nombre)
magio(Magio):- persona(alMando(Magio, _)).
magio(Magio):- persona(novato(Magio)).
magio(Magio):- persona(elElegido(Magio)).

% reconocedor de magios (por functor), no inversible
es_magio(alMando(_, _)).
es_magio(novato(_)).
es_magio(elElegido(_)).

% 2. puede_dar_ordenes

puede_dar_ordenes(A, B):- persona(alMando(A, _)), persona(novato(B)).
puede_dar_ordenes(A, B):- persona(alMando(A, N)), persona(alMando(B, M)), N > M.
puede_dar_ordenes(A, B):- persona(elElegido(A)), magio(B), A \= B.

% 3. siente_envidia

siente_envidia(A, L):- aspirante_a_magio(A), findall(M, magio(M), L).
siente_envidia(A, L):- no_magio(A), not aspirante_a_magio(A), findall(M, (magio(M); aspirante_a_magio(M)), L).
siente_envidia(A, L):- persona(novato(A)), findall(M, persona(alMando(M, _)), L).

% 4. mas_envidioso

mas_envidioso(A):- envidiosos(L), max_envidia(A, L).

envidiosos(L):- findall(A, (siente_envidia(A,_)), L).

max_envidia(X, [H,J|T]):- mas_envidioso_que(H, J), max_envidia(X, [H|T]).
max_envidia(X, [H,J|T]):- not mas_envidioso_que(H, J), max_envidia(X, [J|T]).
max_envidia(X, [X]).

mas_envidioso_que(H, J):- siente_envidia(H, L), length(L, N), siente_envidia(J, L2), length(L2, N2), N >= N2.

% 5. solo_lo_goza

solo_lo_goza(Persona, Beneficio):- gozaBeneficio(Persona, Beneficio), not((gozaBeneficio(Persona2, Beneficio), Persona2 \= Persona)).

% 6. tipo_de_beneficio_mas_aprovechado

tipo_de_beneficio_mas_aprovechado(B):- beneficios(Bs), beneficio(B), ocurrencias(B, Bs, N), 
	forall((beneficio(B2), B2 \= B, ocurrencias(B2, Bs, N2)), N > N2).

ocurrencias(B, [B|Cola], N):- ocurrencias(B, Cola, N2), N is N2 + 1.
ocurrencias(B, [H|Cola], N):- B \= H, ocurrencias(B, Cola, N).
ocurrencias(_, [], 0).

beneficio(Beneficio):- beneficios(Bs), setof(B, member(B, Bs), L), member(Beneficio, L).

beneficios(L2):- findall(B, gozaBeneficio(_, B), L), procesar_beneficios(L, L2).

procesar_beneficios([H|T], [H2|T2]):- functor(H, H2, _), procesar_beneficios(T, T2).
procesar_beneficios([],[]).

