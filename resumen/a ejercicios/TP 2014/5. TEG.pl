/* TEG */

continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).

paisContinente(americaDelSur,argentina).
paisContinente(americaDelSur,brasil).
paisContinente(americaDelSur,chile).
paisContinente(americaDelSur,uruguay).
paisContinente(americaDelNorte,alaska).
paisContinente(americaDelNorte,yukon).
paisContinente(americaDelNorte,canada).
paisContinente(americaDelNorte,oregon).
paisContinente(asia,kamtchatka).
paisContinente(asia,china).
paisContinente(asia,siberia).
paisContinente(asia,japon).
paisContinente(oceania,australia).
paisContinente(oceania,sumatra).
paisContinente(oceania,java).
paisContinente(oceania,borneo).

jugador(amarillo). jugador(magenta).
jugador(negro). jugador(rojo).

paisesQueOcupa(magenta,  [argentina, uruguay]).
paisesQueOcupa(negro,    [chile, kamtchatka, australia, sumatra, java, borneo]).
paisesQueOcupa(amarillo, [brasil, alaska, yukon, canada, oregon, china, siberia, japon]).

objetivo(amarillo, [ocuparContinente(asia), ocuparPaises(20)]).
objetivo(rojo,     [destruirJugador(negro)]).
objetivo(magenta,  [destruirJugador(rojo)]).
objetivo(negro,    [ocuparContinente(oceania), ocuparContinente(americaDelSur)]).


sigue_en_juego(Jugador):- 
	paisesQueOcupa(Jugador,Lista), 
	Lista \= [].

cantidad_de_paises(Jugador,N):- 
	paisesQueOcupa(Jugador,Lista), 
	length(Lista,N).

ocupa(Jugador,Pais):- 
	paisesQueOcupa(Jugador,Lista), 
	member(Pais,Lista).

esta_peleado(Cont):- 
	continente(Cont), 
	forall(
		sigue_en_juego(Jugador), 
		(paisContinente(Cont,Pais), ocupa(Jugador,Pais)) ).

ocupa_continente(Jugador,Cont):- 
	sigue_en_juego(Jugador), 
	continente(Cont), 
	forall(paisContinente(Cont,P), ocupa(Jugador,P)).

se_atrinchero(Jugador):- 
	sigue_en_juego(Jugador), 
	continente(Cont), 
	forall(ocupa(Jugador,P), paisContinente(Cont,P)).

capo_cannoniere(Jugador):- 
	sigue_en_juego(Jugador), 
	cantidad_de_paises(Jugador,N), 
	forall(
		(sigue_en_juego(Jugador2), cantidad_de_paises(Jugador2,N2)),
		N >= N2).

ganador(Jugador):- 
	objetivo(Jugador, Lista), 
	forall(member(Objetivo,Lista), se_cumple(Jugador,Objetivo)).

se_cumple(Jugador,ocuparContinente(Cont)):- 
	ocupa_continente(Jugador,Cont).
se_cumple(Jugador,ocuparPaises(N)):- 
	cantidad_de_paises(Jugador,C), 
	C >= N.
se_cumple(_,destruirJugador(Jugador)):- 
	jugador(Jugador), 
	not(sigue_en_juego(Jugador)).

