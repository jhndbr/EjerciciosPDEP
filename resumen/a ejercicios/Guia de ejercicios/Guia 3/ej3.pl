/* ej 3: subtes, orden_en_las_listas */

linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[once,venezuela,humberto1ro,inclan,caseros]).

combinacion([lima,avMayo]). % a c
combinacion([once,miserere]). % a h
combinacion([pellegrini,diagNorte,nueveJulio]). % b c, b d, c d
combinacion([independenciaC,independenciaE]). % c e

esta_en(Estacion, Linea):- linea(Linea, Estaciones), member(Estacion, Estaciones).

distancia(Est1, Est2, Dist):- esta_en(Est1, Linea), esta_en(Est2, Linea), linea(Linea, Estaciones), 
	nth0(Pos1, Estaciones, Est1), nth0(Pos2, Estaciones, Est2), Dist is abs(Pos2 - Pos1).

misma_altura(Est1, Est2):- esta_en(Est1, Linea1), esta_en(Est2, Linea2), Linea1 \= Linea2, linea(Linea1, Estaciones1), linea(Linea2, Estaciones2),
	nth0(Pos, Estaciones1, Est1), nth0(Pos, Estaciones2, Est2).
	
%viaje_facil(Est1, Est2):- esta_en(Est1, Linea), esta_en(Est2, Linea).
viaje_facil(Est1, Est2):- esta_en(Est1, Linea1), esta_en(Est2, Linea2), Linea1 \= Linea2, combinacion(Combinaciones), 
	member(Est3, Combinaciones), esta_en(Est3, Linea1), member(Est4, Combinaciones), Est3 \= Est4, esta_en(Est4, Linea2).

misma_linea(Est1, Est2):- esta_en(Est1, Linea), esta_en(Est2, Linea).
lineas_distintas(Est1, Est2):- esta_en(Est1, Linea1), esta_en(Est2, Linea2), Linea1 \= Linea2.
