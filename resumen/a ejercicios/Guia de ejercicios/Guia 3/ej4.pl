/* ej4: viajes */

/*vuelo(Codigo_de_vuelo, Capacidad_en_toneladas, [Lista_de_destinos] ).
escala(ciudad, tiempo_de_espera)
tramo(tiempo_en_vuelo) */

vuelo('ARG845', 	30, 
	[escala(rosario,0), tramo(2), escala(buenosAires,0)]).
	
vuelo('MH101', 		95, 
	[escala(kualaLumpur,0), tramo(9), escala(capeTown,2),tramo(15), escala(buenosAires,0)]).
	
vuelo('DLH470', 	60, 
	[escala(berlin,0), tramo(9), escala(washington,2), tramo(2),escala(nuevaYork,0)]).

vuelo('AAL1803',	250, 
	[escala(nuevaYork,0), tramo(1), escala(washington,2), tramo(3), escala(ottawa,3), tramo(15), 
	 escala(londres,4), tramo(1), escala(paris,0)]).

vuelo('BLE849', 	175, 
	[escala(paris,0), tramo(2), escala(berlin,1), tramo(3), escala(kiev,2), tramo(2), 
	 escala(moscu,4), tramo(5), escala(seul,2), tramo(3), escala(tokyo,0)]).

vuelo('NPO556', 	150, 
	[escala(kiev,0), tramo(1), escala(moscu,3), tramo(5), escala(nuevaDelhi,6), tramo(2), 
	 escala(hongKong,4), tramo(2), escala(shanghai,5), tramo(3), escala(tokyo,0)]).

vuelo('DSM3450', 	75, 
	[escala(santiagoDeChile,0), tramo(1), escala(buenosAires,2), tramo(7), 
	 escala(washington,4), tramo(15), escala(berlin,3), tramo(15), escala(tokyo,0)]).

% tiempo_total_de_vuelo	 

tiempo_total_de_vuelo(Vuelo, Tiempo):- vuelo(Vuelo, _, Destinos), tiempo(Destinos, Tiempo).

tiempo([escala(_, T1), tramo(T2)|Resto], Tiempo):- tiempo(Resto, TiempoR), Tiempo is TiempoR + T1 + T2.
tiempo([escala(_,T)], T).

% escala_aburrida

escala_aburrida(Vuelo, Escala):- vuelo(Vuelo, _, Destinos), escalas(Escala, Destinos).

escalas(escala(Lugar, Tiempo), Destinos):- member(escala(Lugar, Tiempo), Destinos), Tiempo > 3.

% ciudades_aburridas

%ciudades_aburridas(Vuelo, Ciudades):- vuelo(Vuelo, _, Destinos), findall(C, (member(escala(C, T), Destinos), T > 3), Ciudades).
ciudades_aburridas(Vuelo, Ciudades):- vuelo(Vuelo, _, _), findall(C, escala_aburrida(Vuelo, escala(C, _)), Ciudades).

% vuelo_largo

vuelo_largo(Vuelo):- vuelo(Vuelo, _, Destinos), tramos(Destinos, Tiempo), Tiempo >= 10.

tramos([escala(_, _), tramo(T1)|Resto], Tiempo):- tramos(Resto, T2), Tiempo is T2 + T1.
tramos([escala(_, _)], 0).

% conectados

conectados(Vuelo1, Vuelo2):- vuelo(Vuelo1, _, Destinos1), vuelo(Vuelo2, _, Destinos2), Vuelo1 \= Vuelo2, get_ciudades(Destinos1, Ciudades1), 
	get_ciudades(Destinos2, Ciudades2), member(Ciudad, Ciudades1), member(Ciudad, Ciudades2).
	
get_ciudades([escala(C1, _), tramo(_)|Resto], [C1|Ciudades]):- get_ciudades(Resto, Ciudades).
get_ciudades([escala(C, _)], [C]).

% banda_de_tres

banda_de_tres(Vuelo1, Vuelo2, Vuelo3):- conectados(Vuelo1, Vuelo2), conectados(Vuelo2, Vuelo3).

% distancia_en_escalas

distancia_en_escalas(Ciudad1, Ciudad2, Distancia):- vuelo(_, _, Destinos), get_ciudades(Destinos, Ciudades), member(Ciudad1, Ciudades),
	member(Ciudad2, Ciudades), nth0(Pos1, Ciudades, Ciudad1), nth0(Pos2, Ciudades, Ciudad2), Distancia is abs(Pos2 - Pos1).
	
% vuelo_lento

vuelo_lento(Vuelo):- vuelo(Vuelo, _, Destinos), not(vuelo_largo(Vuelo)), forall(member(escala(A,B), Destinos), escala_aburrida(Vuelo, escala(A,B))).