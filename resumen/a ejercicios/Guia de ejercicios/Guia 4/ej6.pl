/* liga_de_futbol */

%fecha(NroFecha, partido(EquipoLocal,GolesLocal,EquipoVisitante,GolesVisitante)).

fecha(1,partido(mandiyu,0,losAndes,2)).
fecha(1,partido(yupanqui,2,claypole,1)).
fecha(1,partido(jjurquiza,1,cambaceres,4)).
fecha(2,partido(yupanqui,4,jjurquiza,2)).
fecha(2,partido(losAndes,3,claypole,1)).
fecha(2,partido(cambaceres,2,mandiyu,2)).
fecha(3,partido(jjurquiza,3,losAndes,1)).
fecha(3,partido(mandiyu,2,claypole,2)).
fecha(3,partido(cambaceres,3,yupanqui,2)).

% rival
rival(Equipo, Fecha, Rival):- fecha(Fecha, partido(Equipo, _, Rival, _)).
rival(Equipo, Fecha, Rival):- fecha(Fecha, partido(Rival, _, Equipo, _)).

% goles_local_fecha
goles_local_fecha(Fecha, Goles):- findall(G, fecha(Fecha, partido(_, G, _, _)), Gs), sum_list(Gs, Goles).

% jugaron
jugaron(Equipo1, Equipo2):- rival(Equipo1, _, Equipo2).

% falta_que_jueguen
falta_que_jueguen(E1, E2):- equipo(E1), equipo(E2), E1 \= E2,  not(jugaron(E1,E2)).

equipos(Equipos):- setof(E2, F ^ G1 ^ E1 ^ G2 ^ fecha(F, partido(E1, G1, E2, G2)), Equipos).
equipo(E):- equipos(Es), member(E,Es).

% gano perdio
gano(E1,E2):- fecha(_, partido(E1, G1, E2, G2)), G1 > G2.
gano(E1,E2):- fecha(_, partido(E2, G2, E1, G1)), G1 > G2.

perdio(E1,E2):- fecha(_, partido(E1, G1, E2, G2)), G1 < G2.
perdio(E1,E2):- fecha(_, partido(E2, G2, E1, G1)), G1 < G2.

empataron(E1,E2):- jugaron(E1,E2), not(gano(E1,E2)), not(perdio(E1,E2)).

%puntos
puntos(Equipo, Puntos):- equipo(Equipo), findall(1 , gano(Equipo,_), Ganados), length(Ganados, G), findall(1 , empataron(Equipo,_), Empatados),
	length(Empatados, E), Puntos is G * 3 + E.
	
% equipo_imprevisible
equipo_imprevisible(Equipo):- equipo(Equipo), gano(Equipo, A), perdio(Equipo, B), gano(B,A).

% goles
goles(Equipo, Goles):- equipo(Equipo), goles_como_local(Equipo, A), goles_como_visitante(Equipo, B), Goles is A + B.

goles_como_local(Equipo, Goles):- findall(G, fecha(_, partido(Equipo, G, _, _)), Gs), sum_list(Gs, Goles).
goles_como_visitante(Equipo, Goles):- findall(G, fecha(_, partido(_, _, Equipo, G)), Gs), sum_list(Gs, Goles).

% invicto
invicto(Equipo):- equipo(Equipo), not(perdio(Equipo,_)), not(empataron(Equipo, _)).

looser(Equipo):- equipo(Equipo), not(gano(Equipo,_)), not(empataron(Equipo, _)).

% mas_capo_que
mas_capo_que(Equipo1, Equipo2):- gano(Equipo1, Equipo2), forall(gano(Equipo2, X), gano(Equipo1, X)).

% campeon
campeon(Equipo):- equipo(Equipo), puntos(Equipo, Puntos), forall((equipo(E), E \= Equipo, puntos(E,P)), Puntos > P),
	goles(Equipo, Goles), forall((equipo(E), E \= Equipo, goles(E,G)), Goles > G).
	
% tabla_de_posiciones
tabla_de_posiciones(Tabla):- setof(puntos(P,E), puntos(E,P), Tabla1), reverse(Tabla1, Tabla).
