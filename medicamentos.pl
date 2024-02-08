% vende(Farmacia, Medicamento, Precio).

% incluye(Medicamento, Droga).

% efecto(Droga, Efecto) 
%   Efecto: 
%     cura(Enfermedad)
%     potencia(Enfermedad)

% estaEnfermo(persona, Enfermedad).

% padre(Padre, Hijo).

% actividad(Persona, Fecha, Actividad).
%   Fecha: fecha(Dia, Mes, Anio)
%   Actividad:
%     compro(Medicamento, Farmacia)
%     preguntoPor(Medicamento, Farmacia)

vende(laGondoriana, trancosin, 35).
vende(laGondoriana, sanaSam, 35).

incluye(trancosin, athelas).
incluye(trancosin, cenizaBoromireana).

efecto(athelas, cura(desazon)).
efecto(athelas, cura(heridaDeOrco)).
efecto(cenizaBoromireana, cura(gripeA)).
efecto(cenizaBoromireana, potencia(deseoDePoder)).

estaEnfermo(eomer, heridaDeOrco). % eomer es varon
estaEnfermo(eomer, deseoDePoder).
estaEnfermo(eomund, desazon).
estaEnfermo(eowyn, heridaDeOrco). % eowyn es mujer

padre(eomund, eomer).

actividad(eomer, fecha(15, 6, 3014), compro(trancosin, laGondoriana)).
actividad(eomer, fecha(15, 8, 3014), preguntoPor(sanaSam, laGondoriana)).
actividad(eowyn, fecha(14, 9, 3014), preguntoPor(sanaSam, laGondoriana)).



% Punto 1

medicamentoUtil(Persona, Medicamento) :-
    sirveParaCurar(Medicamento, Persona),
    not(sirveParaPotenciar(Medicamento, Persona)).

sirveParaCurar(Medicamento, Persona) :-
    sirveParaCurar(Medicamento, Persona, _).

sirveParaCurar(Medicamento, Persona, Enfermedad) :-
    sirveParaCurar(Medicamento, Persona, Enfermedad, _).

sirveParaCurar(Medicamento, Persona, Enfermedad, Droga) :-
    estaEnfermo(Persona, Enfermedad),
    incluye(Medicamento, Droga),
    efecto(Droga, cura(Enfermedad)).

sirveParaPotenciar(Medicamento, Persona) :-
    sirveParaPotenciar(Medicamento, Persona, _).

sirveParaPotenciar(Medicamento, Persona, Droga) :-
    estaEnfermo(Persona, Enfermedad),
    incluye(Medicamento, Droga),
    efecto(Droga, potencia(Enfermedad)).


% Punto 2

medicamentoMilagroso(Persona, Medicamento) :-
    sirveParaCurar(Medicamento, Persona),
    forall(
        estaEnfermo(Persona, Enfermedad), 
        sirveParaCurar(Medicamento, Persona, Enfermedad)
    ),
    not(sirveParaPotenciar(Medicamento, Persona)).


% Punto 3

drogaSimpatica(Droga) :-
    droga(Droga),
    curaMasEnfermedadesQue(Droga, 4),
    not(sirveParaPotenciar(_, _, Droga)).

drogaSimpatica(Droga) :-
    sirveParaCurar(_, eomer, Enfermedad1, Droga),
    sirveParaCurar(_, eowyn, Enfermedad2, Droga),
    Enfermedad1 \= Enfermedad2.

drogaSimpatica(Droga) :-
    incluye(Medicamento, Droga),
    vende(_, Medicamento, _),
    forall(vende(_, Medicamento, Precio), Precio =< 10).

droga(Droga) :-
    efecto(Droga, _).

curaMasEnfermedadesQue(Droga, Cantidad) :-
    findall(Enfermedad, efecto(Droga, cura(Enfermedad)), Enfermedades),
    length(Enfermedades, CantidadEnfermedades),
    CantidadEnfermedades >= Cantidad.


% Punto 4

tipoSuicida(Persona) :-
    actividad(Persona, _, compro(Medicamento, _)),
    not(sirveParaCurar(Medicamento, Persona)),
    sirveParaPotenciar(Medicamento, Persona).


% Punto 5

tipoAhorrativo(Persona) :-
    actividad(Persona, _, _),
    forall(
        actividad(Persona, _, compro(Medicamento, Farmacia)),
        preguntoEnOtroLadoQueLoVendiaMasCaroQue(Medicamento, Farmacia, Persona)
    ).

preguntoEnOtroLadoQueLoVendiaMasCaroQue(Medicamento, FarmaciaCompra, Persona) :-
    vende(FarmaciaCompra, Medicamento, PrecioCompra),
    actividad(Persona, _, preguntoPor(Medicamento, FarmaciaPregunta)),
    vende(FarmaciaPregunta, Medicamento, PrecioPregunta),
    PrecioCompra < PrecioPregunta,
    FarmaciaCompra \= FarmaciaPregunta.
    

% Punto 6.a

tipoActivoEn(Persona, Mes, Anio) :-
    actividad(Persona, fecha(_, Mes, Anio), _).


% Punto 6.b

diaProductivo(Fecha) :-
    actividad(_, Fecha, _),
    forall(
        actividad(Persona, Fecha, Actividad), 
        actividadUtil(Persona, Actividad)
    ).

actividadUtil(Persona, compro(Medicamento, _)) :-
    medicamentoUtil(Medicamento, Persona).

actividadUtil(Persona, preguntoPor(Medicamento, _)) :-
    medicamentoUtil(Medicamento, Persona).


% Punto 7

gastoTotal(Persona, GastoTotal) :-
    actividad(Persona, _, _),
    findall(Precio, compraDe(Persona, Precio) , Precios),
    sumlist(Precios, GastoTotal).

compraDe(Persona, Precio) :-
    actividad(Persona, _, compro(Medicamento, Farmacia)),
    vende(Farmacia, Medicamento, Precio).


% Punto 8

zafoDe(Persona, Enfermedad) :-
    ancestro(Persona, Ancestro),
    estaEnfermo(Ancestro, Enfermedad),
    not(estaEnfermo(Persona, Enfermedad)).

ancestro(Persona, Ancestro) :-
    padre(Ancestro, Persona).

ancestro(Persona, Ancestro) :-
    padre(Padre, Persona),
    ancestro(Padre, Ancestro).
