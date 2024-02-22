%composicion(plato, [ingrediente])%
composicion(platoPrincipal(milanesa),[ingrediente(pan,3),ingrediente(huevo,2),ingrediente(carne,2)]).
composicion(entrada(ensMixta),[ingrediente(tomate,2),ingrediente(cebolla,1),ingrediente(lechuga,2)]).
composicion(entrada(ensFresca),[ingrediente(huevo,1),ingrediente(remolacha,2),ingrediente(zanahoria,1)]).
composicion(postre(budinDePan),[ingrediente(pan,2),ingrediente(caramelo,1)]).
composicion(postre(frutillasConCrema),[ingrediente(frutilla,3),ingrediente(crema,2),ingrediente(pan,3)]).
composicion(postre(ensaladaDeFrutas),[ingrediente(naranja,2),ingrediente(banana,2),ingrediente(manzana,2),ingrediente(pan,3)]).


%calorías(nombreIngrediente, cantidadCalorias)%
calorias(pan,30).
calorias(huevo,18).
calorias(carne,40).
calorias(caramelo,170).

%proveedor(nombreProveedor, [nombreIngredientes])%
proveedor(disco, [pan, caramelo, carne, cebolla]).
proveedor(sanIgnacio, [zanahoria, lechuga, miel, huevo]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Punto 1%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

caloriasTotales(Plato, CaloriasTotales) :-
    composicion(entrada(Plato), Ingredientes),
    calcularCalorias(Ingredientes, CaloriasTotales).

caloriasTotales(Plato, CaloriasTotales) :-
    composicion(platoPrincipal(Plato), Ingredientes),
    calcularCalorias(Ingredientes, CaloriasTotales).

caloriasTotales(Plato, CaloriasTotales) :-
    composicion(postre(Plato), Ingredientes),
    calcularCalorias(Ingredientes, CaloriasTotales).

calcularCalorias(Ingredientes, CaloriasTotales) :-
    findall(Calorias, (
        member(ingrediente(Ingrediente, Cantidad), Ingredientes),
        calorias(Ingrediente, CaloriasIngrediente),
        Calorias is CaloriasIngrediente * Cantidad
    ), CaloriasTotalesPorIngrediente),
    sumlist(CaloriasTotalesPorIngrediente, CaloriasTotales).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% punto 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
platoSimpatico(Plato) :-
    composicion(Plato, Ingredientes),
    member(ingrediente(pan, _),Ingredientes),
    member(ingrediente(huevo, _),Ingredientes).

platoSimpatico(Plato) :-
    caloriasTotales(Plato, CaloriasTotales),
    CaloriasTotales < 200.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% punto 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
menuDiet(Entrada, PlatoPrincipal, Postre) :-
    esEntrada(Entrada),
    esPlatoPrincipal(PlatoPrincipal),
    esPostre(Postre),
    maplist(caloriasTotales, [Entrada, PlatoPrincipal, Postre], Calorias),
    sum_list(Calorias, CaloriasTotales),
    CaloriasTotales =< 450.

esEntrada(Plato) :-
    composicion(entrada(Plato), _).

esPlatoPrincipal(Plato) :-
    composicion(platoPrincipal(Plato), _).

esPostre(Plato) :-
    composicion(postre(Plato), _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% punto 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proveedorTiene(Proveedor, TipoPlato) :-
    proveedor(Proveedor, IngredientesProveedor),
    composicion(TipoPlato, Ingredientes),
    extract_ingredients(Ingredientes, Result),
    intersection(Result, IngredientesProveedor, Result).

extract_ingredients(List, Result) :-
    maplist(arg(1), List, Result).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% punto 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ingredientePopular(Ingrediente) :-
    calorias(Ingrediente,_),
    findall(TipoPlato, (composicion(TipoPlato, Plato), member(ingrediente(Ingrediente, _), Plato)), Platos),
    length(Platos, Cantidad),
    Cantidad > 3.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% punto 7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cantidadTotal(Ingrediente, CantidadesPorPlato, Total) :-
    cantidadTotal(Ingrediente, CantidadesPorPlato, 0, Total).

cantidadTotal(_, [], Total, Total). % Caso base, cuando no hay más platos que procesar

cantidadTotal(Ingrediente, [cantidad(Plato, Cantidad)|Resto], TempTotal, Total) :-
    composicion(Plato, Ingredientes),
    sumarCantidad(Ingrediente, Ingredientes, Cantidad, TempTotal, NuevoTotal),
    cantidadTotal(Ingrediente, Resto, NuevoTotal, Total).

sumarCantidad(_, [], _, Total, Total). % Caso base, cuando no hay más ingredientes que procesar

sumarCantidad(Ingrediente, [ingrediente(Ingrediente, Cantidad)|Resto], CantidadPlato, TempTotal, Total) :-
    TempTotal1 is TempTotal + Cantidad * CantidadPlato,
    sumarCantidad(Ingrediente, Resto, CantidadPlato, TempTotal1, Total).

sumarCantidad(Ingrediente, [_|Resto], CantidadPlato, TempTotal, Total) :-
    sumarCantidad(Ingrediente, Resto, CantidadPlato, TempTotal, Total).
