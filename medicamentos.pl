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

medicamentoMilagroso(Persona, Medicamento) :-
    forall(estaEnfermo(Persona, Enfermedad), (incluye(Medicamento, Droga), efecto(Droga, cura(Enfermedad)))),
    not((incluye(Medicamento, Droga), efecto(Droga, potencia(Enfermedad)), estaEnfermo(Persona, Enfermedad))).


