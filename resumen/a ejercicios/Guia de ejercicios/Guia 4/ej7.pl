/* distintos_paises */
paisContinente(americaDelSur, argentina).
paisContinente(americaDelSur, bolivia).
paisContinente(americaDelSur, brasil).
paisContinente(americaDelSur, chile).
paisContinente(americaDelSur, ecuador).
paisContinente(europa, alemania).
paisContinente(europa, espania).
paisContinente(europa, francia).
paisContinente(europa, inglaterra).
paisContinente(asia, aral).
paisContinente(asia, china).
paisContinente(asia, gobi).
paisContinente(asia, india).
paisContinente(asia, iran).

/* países_importantes */
paisImportante(argentina).
paisImportante(kamchatka).
paisImportante(alemania).

/* países_limítrofes */
limitrofes([argentina,brasil]).
limitrofes([bolivia,brasil]).
limitrofes([bolivia,argentina]).
limitrofes([argentina,chile]).
limitrofes([espania,francia]).
limitrofes([alemania,francia]).
limitrofes([nepal,india]).
limitrofes([china,india]).
limitrofes([nepal,china]).
limitrofes([afganistan,china]).
limitrofes([iran,afganistan]).

/* distribucion_en_el_tablero */
ocupa(argentina, azul, 4).
ocupa(bolivia, rojo, 1).
ocupa(brasil, verde, 4).
ocupa(chile, negro, 3).
ocupa(ecuador, rojo, 2).
ocupa(alemania, azul, 3).
ocupa(espania, azul, 1).
ocupa(francia, azul, 1).
ocupa(inglaterra, azul, 2).
ocupa(aral, negro, 2).
ocupa(china, verde, 1).
ocupa(gobi, verde, 2).
ocupa(india, rojo, 3).
ocupa(iran, verde, 1).

/* continentes */
continente(americaDelSur).
continente(europa).
continente(asia).

/* objetivos */
objetivo(rojo, ocuparContinente(asia)).
objetivo(azul, ocuparPaises([argentina, bolivia, francia, inglaterra, china])).
objetivo(verde, destruirJugador(rojo)).
objetivo(negro, ocuparContinente(europa)).

% esta_en_continente
esta_en_continente(Jugador, Continente):- jugador(Jugador),  continente(Continente), ocupa(Pais, Jugador, _), paisContinente(Continente, Pais).

jugador(J):- objetivo(J, _).

% cantidad_de_paises
cantidad_de_paises(Jugador, Cantidad):- jugador(Jugador), findall(P, ocupa(P,Jugador,_), L), length(L, Cantidad).

% ocupa_continente
ocupa_continente(Jugador, Continente):- jugador(Jugador), continente(Continente), 
	forall(paisContinente(Continente, Pais), ocupa(Pais, Jugador, _)).
	
% le_falta_mucho
le_falta_mucho(Jugador, Continente):- jugador(Jugador), continente(Continente), findall(P, paisContinente(Continente, P), Paises), length(Paises, CPaises),
	findall(P, (paisContinente(Continente, P), ocupa(P, Jugador, _)), PaisesOcup), length(PaisesOcup, CPaisesOcup), Falta = CPaises - CPaisesOcup,
	Falta > 2.

% son_limitrofes	
son_limitrofes(P1,P2):- limitrofes(Paises), member(P1,Paises), member(P2, Paises).

% es_groso
es_groso(Jugador):- jugador(Jugador), forall(paisImportante(Pais), ocupa(Pais, Jugador, _)).
es_groso(Jugador):- jugador(Jugador), cantidad_de_paises(Jugador, Cantidad), Cantidad > 10.
es_groso(Jugador):- jugador(Jugador), findall(Ej, ocupa(_, Jugador, Ej), Ejs), sum_list(Ejs, Cantidad), Cantidad > 50.

% esta_en_el_horno
esta_en_el_horno(Pais):- ocupa(Pais, Jugador1, _), jugador(Jugador2), Jugador2 \= Jugador1, forall(son_limitrofes(Pais, PaisL), ocupa(PaisL, Jugador2, _)).

% es_caotico
es_caotico(Continente):- continente(Continente), findall(J, (ocupa(P,J,_), paisContinente(Continente,P)), Js), length(Js, N), N > 3.

% capo_cannoniere
capo_cannoniere(Jugador):- jugador(Jugador), cantidad_de_paises(Jugador, Cantidad), 
	forall((jugador(J), J \= Jugador, cantidad_de_paises(J,C)), Cantidad > C).
	
% ganador
ganador(Jugador):- jugador(Jugador), objetivo(Jugador, Objetivo), cumple_objetivo(Jugador, Objetivo).

cumple_objetivo(Jugador, ocuparContinente(Continente)):- forall(paisContinente(Continente, Pais), ocupa(Pais, Jugador, _)).
cumple_objetivo(Jugador, ocuparPaises(Lista)):- forall(member(Pais, Lista), ocupa(Pais, Jugador, _)).
cumple_objetivo(_, destruirJugador(Jugador2)):- not(ocupa(_, Jugador2, _)).

