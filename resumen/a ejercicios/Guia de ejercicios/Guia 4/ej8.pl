/* subtes */

linea(a,[plazaMayo,peru,lima,congreso,once,castroBarros,primeraJunta]).
linea(c,[retiro,diagNorte,avMayo,moreno,constitucion]).
linea(d,[catedral,nueveJulio,medicina,pzaItalia,carranza]).
linea(h,[rivadavia,belgrano,sanJuan,parquePatricios]).
combinacion(peru,catedral).
combinacion(lima,avMayo).
combinacion(diagNorte,nueveJulio).
combinacion(once,rivadavia).

% pasa_por
pasa_por(Linea, Estacion):- linea(Linea, Estaciones), member(Estacion, Estaciones).

% combinan
combinan(Linea1,Linea2):- combinacion(Estacion1, Estacion2), linea(Linea1, Estaciones1), member(Estacion1, Estaciones1),
	linea(Linea2, Estaciones2), Linea1 \= Linea2, member(Estacion2, Estaciones2).
	
% cantidad_de_estaciones_entre
cantidad_de_estaciones_entre(Estacion1, Estacion2, Cantidad):- linea(_, Estaciones), member(Estacion1, Estaciones), member(Estacion2, Estaciones),
	nth0(Pos1, Estaciones, Estacion1), nth0(Pos2, Estaciones, Estacion2), Cantidad is abs(Pos2 - Pos1).

% es_cabecera	

es_cabecera(Estacion):- primera_estacion(_, Estacion).
es_cabecera(Estacion):- ultima_estacion(_, Estacion).

primera_estacion(Linea, Estacion):- linea(Linea, [Estacion|_]).
ultima_estacion(Linea, Estacion):- linea(Linea, Estaciones), last(Estaciones, Estacion).

%es_cabecera(Estacion):- linea(_, [Estacion|_]).
%es_cabecera(Estacion):- linea(_, Estaciones), last(Estaciones, Estacion).

% es_linea_universal
es_linea_universal(Linea):- linea(Linea, _), forall((linea(Linea2, _), Linea \= Linea2 ), combinan(Linea, Linea2)).

% cabecera_mas_cercana
cabecera_mas_cercana(Estacion, Cabecera):- pasa_por(Linea, Estacion), primera_estacion(Linea, Primera), ultima_estacion(Linea, Ultima),
	cantidad_de_estaciones_entre(Estacion, Primera, C1), cantidad_de_estaciones_entre(Estacion, Ultima, C2),
	elegir_estacion(Primera, C1, Ultima, C2, Cabecera).
	
elegir_estacion(P, C1, _, C2, P):- C1 =< C2.
elegir_estacion(_, C1, U, C2, U):- C1 >= C2.

/*
cabecera_mas_cercana(Estacion, Cabecera):- linea(Linea, Estaciones), pasa_por(Linea, Estacion), pasa_por(Linea, Cabecera1), es_cabecera(Cabecera1),
	pasa_por(Linea, Cabecera2), es_cabecera(Cabecera2), Cabecera1 \= Cabecera2, cantidad_de_estaciones_entre(Estacion, Cabecera1, N1),
	cantidad_de_estaciones_entre(Estacion, Cabecera2, N2), elegir_estacion(Cabecera1, N1, Cabecera2, N2, Cabecera).
*/

% hay_viaje_directo
hay_viaje_directo(Estacion1, Estacion2):- pasa_por(Linea, Estacion1), pasa_por(Linea,Estacion2).

% hay_viaje_con_combinacion
hay_viaje_con_combinacion(Estacion1, Estacion2):- combinan(Linea1, Linea2), pasa_por(Linea1, Estacion1), pasa_por(Linea2,Estacion2).

% hay_viaje
hay_viaje(Estacion1, Estacion2):- hay_viaje_directo(Estacion1, Estacion2).
hay_viaje(Estacion1, Estacion2):- hay_viaje_con_combinacion(Estacion1, Estacion2).

% longitud_viaje
longitud_viaje(Estacion1, Estacion2, Cantidad):- hay_viaje_directo(Estacion1, Estacion2), cantidad_de_estaciones_entre(Estacion1, Estacion2, Cantidad).
longitud_viaje(Estacion1, Estacion2, Cantidad):- 
	combinacion(Estacion1C, Estacion2C), linea(Linea1, Estaciones1), member(Estacion1C, Estaciones1),
	linea(Linea2, Estaciones2), Linea1 \= Linea2, member(Estacion2C, Estaciones2), 
	member(Estacion1, Estaciones1), member(Estacion2, Estaciones2),
	cantidad_de_estaciones_entre(Estacion1, Estacion1C, C1), cantidad_de_estaciones_entre(Estacion2, Estacion2C, C2), Cantidad is C1 + C2.

