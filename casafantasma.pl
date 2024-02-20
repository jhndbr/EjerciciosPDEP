tiene(ray, trapeador).
tiene(winston, varitaDeNeutrones).
tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(peter, trapeador).
tiene(peter, aspiradora(150)).

% herramientasRequeridas(Tarea, Herramientas)
herramientasRequeridas(limpieza, [trapeador]).
herramientasRequeridas(pintura, [trapeador]).
herramientasRequeridas(reparacion, [trapeador, aspiradora(100)]).

% tareaPedida(Cliente, Tarea, Metros)
tareaPedida(john, limpieza, 50).
tareaPedida(john, pintura, 30).
tareaPedida(jane, limpieza, 40).
tareaPedida(jane, reparacion, 20).
tareaPedida(jane, pintura, 10).

% precio(Tarea, PrecioPorMetro)
precio(limpieza, 10).
precio(pintura, 15).
precio(reparacion, 20).


satisfaceNecesidad(Integrante, aspiradora(PotenciaRequerida)) :-
    tiene(Integrante, aspiradora(Potencia)),
    Potencia >= PotenciaRequerida.

satisfaceNecesidad(Integrante, Herramienta) :-
    tiene(Integrante, Herramienta). 


puedeRealizar(Persona, _) :-
    tiene(Persona, varitaDeNeutrones).

puedeRealizar(Persona, Tarea) :-
    herramientasRequeridas(Tarea, Herramientas),
    forall(member(Herramienta, Herramientas), satisfaceNecesidad(Persona, Herramienta)).

cobrar(Cliente, Total) :-
    tareaPedida(Cliente, Tarea, Metros),
    precio(Tarea, PrecioPorMetro),
    findall(PrecioTarea, (
        tareaPedida(Cliente, Tarea, Metros),
        precio(Tarea, PrecioPorMetro),
        PrecioTarea is PrecioPorMetro * Metros
    ), Precios),
    sum_list(Precios, Total).

aceptarPedido(ray, Cliente) :-
    forall(tareaPedida(Cliente, Tarea, _), Tarea \= limpiarTechos),
    puedeRealizarTodas(ray, Cliente).

aceptarPedido(winston, Cliente) :-
    cobrar(Cliente, Total),
    Total > 500,
    puedeRealizarTodas(winston, Cliente).

aceptarPedido(egon, Cliente) :-
    forall((tareaPedida(Cliente, Tarea, _), herramientasRequeridas(Tarea, Herramientas)), (length(Herramientas, Cantidad), Cantidad =< 2)),
    puedeRealizarTodas(egon, Cliente).

aceptarPedido(peter, Cliente) :-
    puedeRealizarTodas(peter, Cliente).

puedeRealizarTodas(Integrante, Cliente) :-
    forall(tareaPedida(Cliente, Tarea, _), puedeRealizar(Integrante, Tarea)).

%% cambion punto 6

% herramientasRequeridas(Tarea, Herramientas)
herramientasRequeridas(ordenarCuarto, [[aspiradora(100), escoba], trapeador, plumero]).

puedeRealizar(Integrante, Tarea) :-
    herramientasRequeridas(Tarea, Herramientas),
    puedeUsarTodas(Integrante, Herramientas).

puedeUsarTodas(_, []).
puedeUsarTodas(Integrante, [H|T]) :-
    (is_list(H) -> puedeUsarAlguna(Integrante, H) ; tiene(Integrante, H)),
    puedeUsarTodas(Integrante, T).

puedeUsarAlguna(Integrante, [H|_]) :-
    tiene(Integrante, H).
puedeUsarAlguna(Integrante, [_|T]) :-
    puedeUsarAlguna(Integrante, T).

