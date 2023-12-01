herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(peter, trapeador).
tiene(winston, varitaDeNeutrones).

satisfaceNecesidad(Integrante, aspiradora(PotenciaRequerida)) :-
    tiene(Integrante, aspiradora(Potencia)),
    Potencia >= PotenciaRequerida.

satisfaceNecesidad(Integrante, Herramienta) :-
    tiene(Integrante, Herramienta).
%punto 3
puedeRealizar(Integrante, _) :-
    tiene(Integrante, varitaDeNeutrones).

puedeRealizar(Integrante, Tarea) :-
    herramientasRequeridas(Tarea, Herramientas),
    forall(member(Herramienta, Herramientas), satisfaceNecesidad(Integrante, Herramienta)).

costoTotal(Cliente, CostoTotal) :-
    findall(Costo, (tareaPedida(Cliente, Tarea, Metros), precio(Tarea, Precio), Costo is Metros * Precio), Costos),
    sum_list(Costos, CostoTotal).

tareaPedida(juan, ordenarCuarto, 50).
tareaPedida(juan, limpiarTecho, 30).
tareaPedida(maria, cortarPasto, 100).
tareaPedida(maria, limpiarBanio, 60).

precio(ordenarCuarto, 10).
precio(limpiarTecho, 15).
precio(cortarPasto, 20).
precio(limpiarBanio, 25).

% punto 4
aceptaPedido(ray, Cliente) :-
    not(tareaPedida(Cliente, limpiarTecho, _)),
    forall(tareaPedida(Cliente, Tarea, _), puedeRealizar(ray, Tarea)).

aceptaPedido(winston, Cliente) :-
    costoTotal(Cliente, Costo),
    Costo > 500,
    forall(tareaPedida(Cliente, Tarea, _), puedeRealizar(winston, Tarea)).

aceptaPedido(egon, Cliente) :-
    not((tareaPedida(Cliente, Tarea, _), tareaCompleja(Tarea))),
    forall(tareaPedida(Cliente, Tarea, _), puedeRealizar(egon, Tarea)).

aceptaPedido(peter, Cliente) :-
    forall(tareaPedida(Cliente, Tarea, _), puedeRealizar(peter, Tarea)).

tareaCompleja(Tarea) :-
    herramientasRequeridas(Tarea, Herramientas),
    length(Herramientas, Cantidad),
    Cantidad > 2.

tareaCompleja(limpiarTecho).

% punto 5

puedeRealizar(Integrante, Tarea) :-
    herramientasRequeridas(Tarea, Herramientas),
    forall(member(Herramienta, Herramientas), satisfaceNecesidad(Integrante, Herramienta)).
