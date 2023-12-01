atiende(dodain, dia(lunes, 9, 15)).
atiende(dodain, dia(miercoles, 9, 15)).
atiende(dodain, dia(viernes, 9, 15)).
atiende(lucas, dia(martes, 10, 20)).
atiende(juanC, dia(sabado, 18, 22)).
atiende(juanC, dia(domingo, 18, 22)).
atiende(juanFdS, dia(jueves, 10, 20)).
atiende(juanFdS, dia(viernes, 12, 20)).
atiende(leoC, dia(lunes, 14, 18)).
atiende(leoC, dia(miercoles, 14, 18)).
atiende(martu, dia(miercoles, 23, 24)).
%no podemos agregar mas informacion a la base de datos por primcipio de universo cerrado
atiende(vale, Dia, HorarioInicio, HorarioFinal):-atiende(dodain, Dia, HorarioInicio, HorarioFinal).
atiende(vale, Dia, HorarioInicio, HorarioFinal):-atiende(juanC, Dia, HorarioInicio, HorarioFinal).
%esta mal agregar algo que no sabemos, asi que no se agrega

atiendeEn(Persona, Dia, Hora) :-
    atiende(Persona, dia(Dia, HoraInicio, HoraFin)),
    between(HoraInicio, HoraFin, Hora).

atiendeSolo(Persona, Dia, Hora) :-
    atiendeEn(Persona, Dia, Hora),
    not((atiendeEn(OtraPersona, Dia, Hora), OtraPersona \= Persona)).



%atiendenEseDia(Dia, Personas) :-
 %   findall(Persona, atiende(Persona, dia(Dia, _, _)), Personas).

posibilidadesAtencion(Dia, Personas):-
    findall(Persona, distinct(Persona, atiendeEn(Persona, Dia, _)), PersonasPosibles),
    combinar(PersonasPosibles, Personas).
  
  combinar([], []).
  combinar([Persona|PersonasPosibles], [Persona|Personas]):-combinar(PersonasPosibles, Personas).
  combinar([_|PersonasPosibles], Personas):-combinar(PersonasPosibles, Personas).

venta(dodain, fecha(10, 8), [golosinas(1200), cigarrillos(jockey), golosinas(50)]).
% dodain hizo las siguientes ventas el miércoles 12 de agosto: 8 bebidas alcohólicas, 
% 1 bebida no-alcohólica, golosinas por $ 10
venta(dodain, fecha(12, 8), [bebidas(true, 8), bebidas(false, 1), golosinas(10)]).
% martu hizo las siguientes ventas el miercoles 12 de agosto: golosinas por $ 1000, cigarrillos Chesterfield, Colorado y Parisiennes.
venta(martu, fecha(12, 8), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
% lucas hizo las siguientes ventas el martes 11 de agosto: golosinas por $ 600.
venta(lucas, fecha(11, 8), [golosinas(600)]).
% lucas hizo las siguientes ventas el martes 18 de agosto: 2 bebidas no-alcohólicas y cigarrillos Derby.
venta(lucas, fecha(18, 8), [bebidas(false, 2), cigarrillos([derby])]).

% Queremos saber si una persona vendedora es suertuda, esto ocurre si para todos los días en los que vendió,
% la primera venta que hizo fue importante. Una venta es importante:
% - en el caso de las golosinas, si supera los $ 100.
% - en el caso de los cigarrillos, si tiene más de dos marcas.
% - en el caso de las bebidas, si son alcohólicas o son más de 5.
personaSuertuda(Persona):-
  vendedora(Persona),
  forall(venta(Persona, _, [Venta|_]), ventaImportante(Venta)).

vendedora(Persona):-venta(Persona, _, _).

ventaImportante(golosinas(Precio)):-Precio > 100.
ventaImportante(cigarrillos(Marcas)):-length(Marcas, Cantidad), Cantidad > 2.
ventaImportante(bebidas(true, _)).
ventaImportante(bebidas(_, Cantidad)):-Cantidad > 5.