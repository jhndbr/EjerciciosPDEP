/* TEG */

continente(americaDelSur). 
continente(americaDelNorte).
continente(asia). 
continente(oceania).

paisContinente(americaDelSur, argentina). 
paisContinente(americaDelSur,brasil).
paisContinente(americaDelSur, chile). 
paisContinente(americaDelSur, uruguay).
paisContinente(americaDelNorte, alaska). 
paisContinente(americaDelNorte,yukon).
paisContinente(americaDelNorte, canada). 
paisContinente(americaDelNorte,oregon). 
paisContinente(asia, kamtchatka). 
paisContinente(asia, china).
paisContinente(asia, siberia). 
paisContinente(asia, japon).
paisContinente(oceania,australia). 
paisContinente(oceania,sumatra).
paisContinente(oceania,java). 
paisContinente(oceania,borneo).

limitrofes(argentina,brasil). 
limitrofes(argentina,chile).
limitrofes(argentina,uruguay). 
limitrofes(uruguay,brasil).
limitrofes(alaska,kamtchatka). 
limitrofes(alaska,yukon).
limitrofes(alaska,oregon).
limitrofes(canada,yukon). 
limitrofes(canada,oregon). 
limitrofes(siberia,kamtchatka).
limitrofes(siberia,china). 
limitrofes(china,kamtchatka).
limitrofes(japon,china). 
limitrofes(japon,kamtchatka).
limitrofes(australia,sumatra). 
limitrofes(australia,java).
limitrofes(australia,borneo). 
limitrofes(australia,chile).

% Usar este para saber si son limitrofes ya que es una relacion simetrica
sonLimitrofes(X, Y):- limitrofes(X, Y).
sonLimitrofes(X, Y):- limitrofes(Y, X).

jugador(amarillo).
jugador(magenta).
jugador(negro).

ocupa(argentina, magenta). 
ocupa(uruguay, magenta). 
ocupa(chile, negro). 
ocupa(kamtchatka, negro).
ocupa(australia, negro). 
ocupa(sumatra, negro). 
ocupa(java, negro).
ocupa(borneo, negro).
ocupa(brasil, amarillo).
ocupa(alaska, amarillo). 
ocupa(yukon, amarillo).
ocupa(canada, amarillo). 
ocupa(oregon, amarillo). 
ocupa(china, amarillo). 
ocupa(siberia, amarillo). 
ocupa(japon, amarillo).

esta_peleado(Cont):- continente(Cont), forall(jugador(J), (paisContinente(Cont, Pais), ocupa(Pais, J))).

ocupa_continente(Jugador, Cont):- jugador(Jugador), continente(Cont), forall(paisContinente(Cont, Pais), ocupa(Pais, Jugador)).

se_atrinchero(Jugador):- jugador(Jugador), continente(Cont), forall(ocupa(Pais, Jugador), paisContinente(Cont, Pais)).

esta_en_el_horno(Pais):- paisContinente(_, Pais), forall(sonLimitrofes(Pais, P2), ocupa(P2, _)).

pais_no_ocupado(Pais):- paisContinente(_, Pais), not(ocupa(Pais, _)).