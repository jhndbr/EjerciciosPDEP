%tarea(agente, tarea, ubicacion)
%tareas:
%  ingerir(descripcion, tamaño, cantidad)
%  apresar(malviviente, recompensa)
%  asuntosInternos(agenteInvestigado)
%  vigilar(listaDeNegocios)

tarea(vigilanteDelBarrio, ingerir(pizza, 1.5, 2),laBoca).
tarea(vigilanteDelBarrio, vigilar([pizzeria, heladeria]), barracas).
tarea(canaBoton, asuntosInternos(vigilanteDelBarrio), barracas).
tarea(sargentoGarcia, vigilar([pulperia, haciendaDeLaVega, plaza]),puebloDeLosAngeles).
tarea(sargentoGarcia, ingerir(vino, 0.5, 5),puebloDeLosAngeles).
tarea(sargentoGarcia, apresar(elzorro, 100), puebloDeLosAngeles). 
tarea(vega, apresar(neneCarrizo,50),avellaneda).
tarea(jefeSupremo, vigilar([congreso,casaRosada,tribunales]),laBoca).

ubicacion(puebloDeLosAngeles).
ubicacion(avellaneda).
ubicacion(barracas).
ubicacion(marDelPlata).
ubicacion(laBoca).
ubicacion(uqbar).

%jefe(jefe, subordinado)
jefe(jefeSupremo,vega ).
jefe(vega, vigilanteDelBarrio).
jefe(vega, canaBoton).
jefe(jefeSupremo,sargentoGarcia).


frecuenta(Agente,Ubicacion):-
tarea(Agente, _, Ubicacion).

frecuenta(Agente,buenosAires):-
tarea(Agente, _, _).

frecuenta(vega,quilmes).

frecuenta(Agente, marDelPlata) :-
    tarea(Agente, vigilar(Negocios), _),
    member(alfajores, Negocios).

lugarinaccetible(Ubicacion):-
    ubicacion(Ubicacion),
    not(frecuenta(_,Ubicacion)).

afincado(Agente) :-
    tarea(Agente, _, Ubicacion1),
    tarea(Agente, _, Ubicacion2),
    Ubicacion1 = Ubicacion2.

cadenaDeMando([Agente1, Agente2]) :-
    jefe(Agente1, Agente2).

cadenaDeMando([Agente1, Agente2 | Resto]) :-
    jefe(Agente1, Agente2),
    cadenaDeMando([Agente2 | Resto]).


puntuacion(Agente, Puntuacion) :-
    tarea(Agente, _, _),
    findall(Puntos, (tarea(Agente, Tarea, _), puntos(Tarea, Puntos)), ListaPuntos),
    sum_list(ListaPuntos, Puntuacion).

puntos(vigilar(Negocios), Puntos) :-
    length(Negocios, NumeroNegocios),
    Puntos is NumeroNegocios * 5.

puntos(ingerir(_, Tamanio, Cantidad), Puntos) :-
    Puntos is -10 * Tamanio * Cantidad.

puntos(apresar(_, Recompensa), Puntos) :-
    Puntos is Recompensa / 2.
